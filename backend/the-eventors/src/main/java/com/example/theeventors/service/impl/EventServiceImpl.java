package com.example.theeventors.service.impl;

import com.example.theeventors.config.JwtService;
import com.example.theeventors.model.*;
import com.example.theeventors.model.dto.*;
import com.example.theeventors.model.enumerations.NotificationTypes;
import com.example.theeventors.model.exceptions.ActivityNotFoundException;
import com.example.theeventors.model.exceptions.CategoryNotFoundException;
import com.example.theeventors.model.exceptions.EventNotFoundException;
import com.example.theeventors.model.exceptions.UserNotFoundException;
import com.example.theeventors.model.mapper.EventForSearchDtoMapper;
import com.example.theeventors.model.mapper.EventsDtoMapper;
import com.example.theeventors.model.mapper.ListingEventDtoResponseMapper;
import com.example.theeventors.repository.*;
import com.example.theeventors.service.*;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.maps.GeoApiContext;
import com.google.maps.GeocodingApi;
import com.google.maps.errors.ApiException;
import com.google.maps.model.GeocodingResult;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class EventServiceImpl implements EventService {

    private final EventRepository eventRepository;
    private final ActivityRepository activityRepository;
    private final CommentsRepository commentsRepository;
    private final CommentAndRepliesRepository commentAndRepliesRepository;
    private final MyActivityRepository myActivityRepository;
    private final CategoryRepository categoryRepository;
    private final BookmarkRepository bookmarkRepository;
    private final AfterDeleteOfEventRemoveFromActivityImpl deleteActivity;

    private final EventInfoService eventInfoService;

    private final EventTimesService eventTimeService;
    private final EventsDtoMapper eventsDtoMapper;

    private final EventForSearchDtoMapper searchDtoMapper;

    private final ListingEventDtoResponseMapper listingMapper;

    private final GuestService guestService;

    private final UserRepository userRepository;

    private final JwtService jwtService;
    private final MyActivityService service;

    private final LocationService locationService;

    private final EventAddressService addressService;


    final static DateTimeFormatter CUSTOM_FORMATTER = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm");

    @Override
    public List<EventsDto> findAll() {
        return this.eventRepository.findAll()
                .stream().filter(e -> ChronoUnit.HOURS.between(e.getEventTimes().getStartTime(), LocalDateTime.now()) >= 0)
                .map(eventsDtoMapper).collect(Collectors.toList());
    }

    @Override
    public List<ListingEventDtoResponse> findAllHomeScreen(String username) {
        System.out.println("=================FEED======================");
        User u = this.userRepository.findByUsername(jwtService.extractUsername(username)).orElseThrow();
        List<Event> list = this.eventRepository.findAll().stream().filter(e -> ChronoUnit.HOURS.between(e.getEventTimes().getStartTime(), LocalDateTime.now()) >= 0).toList();
        List<Event> add = new ArrayList<>();
        for (Event event : list) {
            String following = event.getEventInfo().getCreatedBy();
            System.out.println(following);
            System.out.println(u.getFollowing().stream().anyMatch(f -> f.equals(following)));
            System.out.println(event.getEventInfo().getCreatedBy().equals(u.getUsername()));
            if (u.getFollowing().stream().anyMatch(f -> f.equals(following)) || event.getEventInfo().getCreatedBy().equals(u.getUsername())) {
                System.out.println(event.getEventInfo().getTitle());
                add.add(event);
            }
        }
        return add
                .stream()
                .map(listingMapper).collect(Collectors.toList());
    }


    @Override
    public Event findById(Long id) {
        return this.eventRepository.findById(id).orElseThrow(() -> new EventNotFoundException(id));
    }

    @Override
    public EventsDto findEventById(Long id) {
        return this.eventRepository.findById(id).map(eventsDtoMapper).orElseThrow(() -> new EventNotFoundException(id));
    }

    @Override
    public Event create(EventDtoRequest e, String username, Activity activity) throws IOException, InterruptedException, ApiException {
        Category category = this.categoryRepository.findById(Long.valueOf(e.getCategory())).orElseThrow(() -> new CategoryNotFoundException(Long.valueOf(e.getCategory())));

        EventInfo eventInfo = this.eventInfoService.create(e.getTitle(), e.getDescription(), e.getCoverImage(), e.getImages(), jwtService.extractUsername(e.getCreatedBy()));
        System.out.println(e.getStartTime());
        EventTimes eventTimes = this.eventTimeService.create(LocalDateTime.now(), e.getDuration());
        Guest guests = this.guestService.create(e.getGuests());
        EventAddress address = this.addressService.create(e.getLocation());
        //User u = this.userRepository.findByUsername(username).orElseThrow();
        //u.getEvents().add(event);
        //this.userRepository.save(u);
        return this.eventRepository.save(new Event(category, eventInfo, address, eventTimes, guests, activity));
    }

    @Override
    public void addGoingUser(Long id, String username, MyActivity myActivity)  {
        Event event = this.findById(id);
        Activity activity = this.activityRepository.findById(event.getActivity().getId()).orElseThrow(() -> new ActivityNotFoundException(event.getActivity().getId()));
        if (!activity.getGoing().contains(username)) {
            activity.getInterested().remove(username);
            activity.getGoing().add(username);
        }
        if (myActivity.getMyInterestedEvent().containsKey(id)) {
            myActivity.getMyInterestedEvent().remove(id);
        }
        myActivity.getMyGoingEvent().put(id, LocalDateTime.now());

        this.myActivityRepository.save(myActivity);
        this.activityRepository.save(activity);
        event.setActivity(activity);
        this.eventRepository.save(event);
    }

    @Override
    public void addInterestedUser(Long id, String username, MyActivity myActivity) {
        Event event = this.findById(id);
        Activity activity = this.activityRepository.findById(event.getActivity().getId()).orElseThrow(() -> new ActivityNotFoundException(event.getActivity().getId()));
        if (!activity.getInterested().contains(username)) {
            activity.getGoing().remove(username);
            activity.getInterested().add(username);
        }

        if (myActivity.getMyGoingEvent().containsKey(id)) {
            myActivity.getMyGoingEvent().remove(id);
        }
        myActivity.getMyInterestedEvent().put(id, LocalDateTime.now());
        this.myActivityRepository.save(myActivity);

        this.activityRepository.save(activity);
        event.setActivity(activity);
        this.eventRepository.save(event);
    }

    @Override
    public void checkRemove(CheckRemoveDto dto) {
        String username = jwtService.extractUsername(dto.getToken());
        Event e = this.eventRepository.findById(dto.getId()).orElseThrow(() -> new EventNotFoundException(dto.getId()));
        MyActivity myActivity = this.myActivityRepository.findByUsername(username);

        if (dto.getGoingOrInterested().equals("going")) {
            e.getActivity().getGoing().remove(username);
            myActivity.getMyGoingEvent().remove(dto.getId());

        } else {
            e.getActivity().getInterested().remove(username);
            myActivity.getMyInterestedEvent().remove(dto.getId());
        }
        this.eventRepository.save(e);
        this.myActivityRepository.save(myActivity);
    }

    @Override
    public void addComment(Long id, CommentAndReplies commentAndReplies, String username, MyActivity myActivity) {
        Event event = this.findById(id);
        Comments comments = new Comments(commentAndReplies);
        this.commentsRepository.save(comments);
        event.getComments().add(comments);
        this.eventRepository.save(event);
        myActivity.getMyComments().put(commentAndReplies.getId(), id);
        this.myActivityRepository.save(myActivity);
    }

    @Override
    public void addRepliesToComment(Long id, Long idComment, String reply, String username, MyActivity myActivity) {
        Event event = this.findById(id);
        CommentAndReplies commentAndReplies = new CommentAndReplies(reply, username, id);
        this.commentAndRepliesRepository.save(commentAndReplies);
        Comments comments = event.getComments().stream().filter(c -> c.getId() == idComment).findFirst().get();

        comments.getReplies().add(commentAndReplies);
        this.commentsRepository.save(comments);

        myActivity.getMyComments().put(commentAndReplies.getId(), id);
        this.myActivityRepository.save(myActivity);
    }

    @Override
    public Event update(Long id, EventDtoRequest e) throws IOException, InterruptedException, ApiException {

        Event event = this.findById(id);
        Category category = this.categoryRepository.findById(Long.valueOf(e.getCategory())).orElseThrow(() -> new CategoryNotFoundException(Long.valueOf(e.getCategory())));

        EventInfo eventInfo = this.eventInfoService.update(event.getEventInfo().getId(), e.getTitle(), e.getDescription(), e.getCoverImage(), e.getImages(), jwtService.extractUsername(e.getCreatedBy()));
        EventTimes eventTimes = this.eventTimeService.update(event.getEventTimes().getId(), LocalDateTime.parse(e.getStartTime(), DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm")), e.getDuration());
        Guest guests = this.guestService.update(event.getGuests().getId(), e.getGuests());
        EventAddress address = this.addressService.update(event.getAddress().getId(), e.getLocation());

        event.setEventInfo(eventInfo);
        event.setEventTimes(eventTimes);
        event.setGuests(guests);
        event.setCategory(category);
        event.setAddress(address);
        return this.eventRepository.save(event);
    }

    @Override
    @Transactional
    public void delete(Long id) {
        this.deleteActivity.delete(id);
        Event event = this.findById(id);
        for (Bookmark b : this.bookmarkRepository.findAllByEvents(event)) {
            b.getEvents().remove(event);
            this.bookmarkRepository.save(b);
        }

        this.eventRepository.deleteById(id);

    }

    @Override
    public List<EventForSearchDto> findAllForSearch() {
        return this.eventRepository.findAll()
                .stream().filter(e -> ChronoUnit.HOURS.between(e.getEventTimes().getStartTime(), LocalDateTime.now()) >= 0).map(searchDtoMapper)
                .toList();
    }

    public List<ListingEventNearDto> findAllNear(Long idCategory, PositionDto pos) throws IOException, InterruptedException, ApiException {

        double lat = Double.parseDouble(pos.getLat());
        double lon = Double.parseDouble(pos.getLng());

        List<ListingEventNearDto> events = new ArrayList<>();
        this.eventRepository.findAll().stream().filter(e -> ChronoUnit.HOURS.between(e.getEventTimes().getStartTime(), LocalDateTime.now()) >= 0).filter(e -> {
            if (idCategory == 0) {
                return true;
            } else {
                return e.getCategory().getId() == idCategory;
            }
        }).forEach(event -> {


            double dist = locationService.getDistance(event.getAddress().getLat(), event.getAddress().getLng(), lat, lon);

            User u = this.userRepository.findByUsername(event.getEventInfo().getCreatedBy()).orElseThrow();
            String photo = u.getProfileImage() != null ? u.getProfileImage().getImageBase64().replaceAll("data:application/octet-stream;base64,", "") : "";
            events.add(new ListingEventNearDto(
                    event.getId(),
                    event.getEventInfo().getTitle(),
                    event.getEventInfo().getCoverImage().getImageBase64().replaceAll("data:application/octet-stream;base64,"
                            , ""),
                    event.getAddress().getLocation(),
                    event.getAddress().getLat(),
                    event.getAddress().getLng(),
                    Math.round(dist),
                    event.getEventTimes().getStartTime().format(CUSTOM_FORMATTER),
                    service.getTimeAt(event.getEventTimes().getCreatedTime()),
                    event.getEventInfo().getCreatedBy(),
                    photo,
                    event.getCategory().getId()
            ));
        });
        List<ListingEventNearDto> list = events.stream().filter(e -> e.getDistance() <= 100).toList();
        list = list.stream().sorted(ListingEventNearDto.byDistance).toList();
        return list;
    }

    public List<NearEventForMapDto> findAllNearEventsForMap(PositionDto address) throws IOException, InterruptedException, ApiException {
        List<NearEventForMapDto> list = new ArrayList<>();
        this.findAllNear(0L, address).forEach(event -> list.add(new NearEventForMapDto(event.getId(), event.getTitle(), event.getLocation(), event.getDistance(), event.getStartDateTime())));
        return list;
    }


    @Override
    public List<ListingEventTopDto> findAllTop(Long id) {
        List<ListingEventTopDto> events = new ArrayList<>();
        this.eventRepository.findAll().stream().filter(e -> ChronoUnit.HOURS.between(e.getEventTimes().getStartTime(), LocalDateTime.now()) >= 0).filter(e -> {
            if (id == 0) {
                return true;
            } else {
                return e.getCategory().getId() == id;
            }
        }).forEach(event -> {
            User u = this.userRepository.findByUsername(event.getEventInfo().getCreatedBy()).orElseThrow();
            String photo = u.getProfileImage() != null ? u.getProfileImage().getImageBase64().replaceAll("data:application/octet-stream;base64,", "") : "";

            events.add(new ListingEventTopDto(
                    event.getId(),
                    event.getEventInfo().getTitle(),
                    event.getEventInfo().getCoverImage().getImageBase64().replaceAll("data:application/octet-stream;base64,"
                            , ""),
                    event.getAddress().getLocation(),
                    event.getActivity().getGoing().size(),
                    event.getActivity().getInterested().size(),
                    event.getEventTimes().getStartTime().format(CUSTOM_FORMATTER),
                    service.getTimeAt(event.getEventTimes().getCreatedTime()),
                    event.getEventInfo().getCreatedBy(),
                    photo,
                    event.getCategory().getId()
            ));
        });
        List<ListingEventTopDto> list = events.stream().filter(e -> e.getGoing() >= 15 && e.getInterested() > 30).toList();
             list =   list.stream().sorted(Comparator.comparing(ListingEventTopDto::getInterested)
                        .thenComparing(ListingEventTopDto::getGoing))
                .toList();
        return list.size() != 0 ? list : events.stream().sorted(Comparator.comparing(ListingEventTopDto::getInterested)
                .thenComparing(ListingEventTopDto::getGoing)).toList();

    }

    @Override
    public List<ListingAllEventDto> findAllEvents(Long id) {
        List<ListingAllEventDto> list = new ArrayList<>();
        this.eventRepository.findAll().stream().filter(e -> ChronoUnit.HOURS.between(e.getEventTimes().getStartTime(), LocalDateTime.now()) >= 0)
                .forEach(event -> {
                    User u = this.userRepository.findByUsername(event.getEventInfo().getCreatedBy()).orElseThrow();
                    String photo = u.getProfileImage() != null ? u.getProfileImage().getImageBase64().replaceAll("data:application/octet-stream;base64,", "") : "";

                    list.add(new ListingAllEventDto(event.getId(),
                            event.getEventInfo().getTitle(),
                            event.getEventInfo().getCoverImage().getImageBase64().replaceAll("data:application/octet-stream;base64,"
                                    , ""),
                            event.getAddress().getLocation(),
                            event.getEventTimes().getStartTime().format(CUSTOM_FORMATTER),
                            service.getTimeAt(event.getEventTimes().getCreatedTime()),
                            event.getEventInfo().getCreatedBy(),
                            photo,
                            event.getCategory().getId()));
                });
        return list;
    }
}
