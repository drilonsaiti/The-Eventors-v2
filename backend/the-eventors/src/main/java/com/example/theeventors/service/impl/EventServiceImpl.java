package com.example.theeventors.service.impl;

import com.example.theeventors.model.*;
import com.example.theeventors.model.dto.EventDtoRequest;
import com.example.theeventors.model.dto.EventsDto;
import com.example.theeventors.model.exceptions.ActivityNotFoundException;
import com.example.theeventors.model.exceptions.CategoryNotFoundException;
import com.example.theeventors.model.exceptions.EventNotFoundException;
import com.example.theeventors.model.mapper.EventsDtoMapper;
import com.example.theeventors.repository.*;
import com.example.theeventors.service.EventInfoService;
import com.example.theeventors.service.EventService;
import com.example.theeventors.service.EventTimesService;
import com.example.theeventors.service.GuestService;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.time.LocalDateTime;
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

    private final GuestService guestService;



    @Override
    public List<EventsDto> findAll() {
        return this.eventRepository.findAll()
                .stream()
                .map(eventsDtoMapper).collect(Collectors.toList());
    }

    @Override
    public Event findById(Long id) {
        return this.eventRepository.findById(id).orElseThrow(() -> new EventNotFoundException(id));
    }

    @Override
    public Event create(EventDtoRequest e,String username, Activity activity) throws IOException {
        Category category = this.categoryRepository.findById(Long.valueOf(e.getCategory())).orElseThrow(() -> new CategoryNotFoundException(Long.valueOf(e.getCategory())));
        EventInfo eventInfo = this.eventInfoService.create(e.getTitle(),e.getDescription(),e.getLocation(),e.getCoverImage(),e.getImages(),username);
        System.out.println(e.getStartTime());
        EventTimes eventTimes = this.eventTimeService.create(LocalDateTime.now(),e.getDuration());
        Guest guests = this.guestService.create(e.getGuests());
        return this.eventRepository.save(new Event(category,eventInfo,eventTimes,guests, activity));
    }

    @Override
    public void addGoingUser(Long id,String username,MyActivity myActivity) {
        Event event = this.findById(id);
        Activity activity = this.activityRepository.findById(event.getActivity().getId()).orElseThrow(() -> new ActivityNotFoundException(event.getActivity().getId()));
        activity.getGoing().add(username);

        myActivity.getMyGoingEvent().put(id, LocalDateTime.now());
        this.myActivityRepository.save(myActivity);
        this.activityRepository.save(activity);
        event.setActivity(activity);
        this.eventRepository.save(event);
    }

    @Override
    public void addInterestedUser(Long id,String username,MyActivity myActivity) {
        Event event = this.findById(id);
        Activity activity = this.activityRepository.findById(event.getActivity().getId()).orElseThrow(() -> new ActivityNotFoundException(event.getActivity().getId()));
        activity.getInterested().add(username);

        myActivity.getMyInterestedEvent().put(id, LocalDateTime.now());
        this.myActivityRepository.save(myActivity);

        this.activityRepository.save(activity);
        event.setActivity(activity);
        this.eventRepository.save(event);
    }

    @Override
    public void addComment(Long id, CommentAndReplies commentAndReplies,String username,MyActivity myActivity) {
        Event event = this.findById(id);
        Comments comments = new Comments(commentAndReplies);
        this.commentsRepository.save(comments);
        event.getComments().add(comments);
        this.eventRepository.save(event);
        myActivity.getMyComments().put(commentAndReplies.getId(),id);
        this.myActivityRepository.save(myActivity);
    }

    @Override
    public void addRepliesToComment(Long id, Long idComment,String reply,String username,MyActivity myActivity) {
        Event event = this.findById(id);
        CommentAndReplies commentAndReplies = new CommentAndReplies(reply,username,id);
        this.commentAndRepliesRepository.save(commentAndReplies);
        Comments comments = event.getComments().stream().filter(c -> c.getId() == idComment).findFirst().get();

        comments.getReplies().add(commentAndReplies);
        this.commentsRepository.save(comments);

        myActivity.getMyComments().put(commentAndReplies.getId(),id);
        this.myActivityRepository.save(myActivity);
    }

    @Override
    public Event update(Long id, Long idCategory,EventInfo eventInfo, EventTimes eventTimes, Guest guests) {
        Event event = this.findById(id);
        Category category = this.categoryRepository.findById(idCategory).orElseThrow(() -> new CategoryNotFoundException(idCategory));
        event.setEventInfo(eventInfo);
        event.setEventTimes(eventTimes);
        event.setGuests(guests);
        event.setCategory(category);
        return this.eventRepository.save(event);
    }

    @Override
    @Transactional
    public void delete(Long id) {
        this.deleteActivity.delete(id);
        Event event = this.findById(id);
        for (Bookmark b : this.bookmarkRepository.findAllByEvents(event)){
            b.getEvents().remove(event);
            this.bookmarkRepository.save(b);
        }

        this.eventRepository.deleteById(id);

    }

}
