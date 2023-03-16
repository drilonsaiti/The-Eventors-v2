package com.example.theeventors.service.impl;

import com.example.theeventors.config.JwtService;
import com.example.theeventors.model.*;
import com.example.theeventors.model.dto.*;
import com.example.theeventors.model.exceptions.ActivityNotFoundException;
import com.example.theeventors.model.exceptions.CommentNotFoundException;
import com.example.theeventors.model.exceptions.EventNotFoundException;
import com.example.theeventors.repository.CommentAndRepliesRepository;
import com.example.theeventors.repository.EventRepository;
import com.example.theeventors.repository.MyActivityRepository;
import com.example.theeventors.repository.UserRepository;
import com.example.theeventors.service.MyActivityService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class MyActivityServiceImpl implements MyActivityService {
    final static DateTimeFormatter CUSTOM_FORMATTER = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm");

    private final MyActivityRepository myActivityRepository;
    private final EventRepository eventRepository;
    private final CommentAndRepliesRepository commRepository;

    private final UserRepository userRepository;

    private final JwtService jwtService;



    //private final MyActivityEventDtoMapper mapper;



    @Override
    public List<MyActivity> findAll() {
        return this.myActivityRepository.findAll();
    }

    @Override
    public List<MyActivityEventDto> findAllMyGoingEvents(String token) {
        System.out.println("CHECK");
        System.out.println(token.length() > 25);
        MyActivity activity = this.myActivityRepository.findByUsername(token.length() > 25 ? jwtService.extractUsername(token) : token);
        List<MyActivityEventDto> going = new ArrayList<>();

        for (Map.Entry<Long, LocalDateTime> ac : activity.getMyGoingEvent().entrySet()){

            Event e = this.eventRepository.findById(ac.getKey()).orElseThrow();

            String timeAt = this.getTimeAt(ac.getValue());

            going.add(new MyActivityEventDto(e.getEventInfo().getTitle(), e.getEventInfo().getCreatedBy(),  timeAt,
                    e.getEventInfo().getCoverImage()
                            .getImageBase64().replaceAll("data:application/octet-stream;base64,",""),
                    e.getEventTimes().getStartTime().format(CUSTOM_FORMATTER),"Going",e.getId()));
        }

        return going;
    }

    @Override
    public List<MyActivityEventDto> findAllMyInterestedEvents(String token) {
        System.out.println("CHECK");
        System.out.println(token.length() > 25);
        MyActivity activity = this.myActivityRepository.findByUsername(token.length() > 25 ? jwtService.extractUsername(token) : token);
        List<MyActivityEventDto> interested = new ArrayList<>();


        for (Map.Entry<Long, LocalDateTime> ac : activity.getMyInterestedEvent().entrySet()){

            Event e = this.eventRepository.findById(ac.getKey()).orElseThrow();

            String timeAt = this.getTimeAt(ac.getValue());
            interested.add(new MyActivityEventDto(e.getEventInfo().getTitle(), e.getEventInfo().getCreatedBy(),  timeAt,
                    e.getEventInfo().getCoverImage()
                            .getImageBase64().replaceAll("data:application/octet-stream;base64,",""),
                    e.getEventTimes().getStartTime().format(CUSTOM_FORMATTER),"Interested",e.getId()));
        }

        return interested;
    }

    @Override
    public List<MyActivityEventDto> findAllForActivityProfile(String token) {
        List<MyActivityEventDto> list = new ArrayList<>();
        list.addAll(this.findAllMyGoingEvents(token));
        list.addAll(this.findAllMyInterestedEvents(token));

        return list.stream().sorted(Comparator.comparing(MyActivityEventDto::getTimeAt)).toList();
    }

    @Override
    public String getTimeAt(LocalDateTime time) {
        String timeAt = "";
        long days = ChronoUnit.DAYS.between(time,LocalDateTime.now());
        if (days >= 7) {
            timeAt = ChronoUnit.WEEKS.between(time, LocalDateTime.now()) + "w";
        } else if (days > 0) {
            timeAt = days + "d";
        } else {
            long hours = ChronoUnit.HOURS.between(time, LocalDateTime.now());
            if (hours > 0) {
                timeAt = hours + "h";
            } else {
                timeAt = ChronoUnit.MINUTES.between(time, LocalDateTime.now()) + "m";
            }
        }

        return timeAt;
    }

    @Override
    public List<MyActivityEventDto> findAllMyEvents(String token,boolean isUser) {
        List<Event> events = this.eventRepository.findAllByEventInfo_CreatedBy(isUser ? jwtService.extractUsername(token) : token);
        return events.stream()
                .map(e -> new MyActivityEventDto(e.getEventInfo().getTitle(), e.getEventInfo().getCreatedBy(),  getTimeAt(e.getEventTimes().getCreatedTime()),
                        e.getEventInfo().getCoverImage().getImageBase64().replaceAll(        "data:application/octet-stream;base64,"
                                ,""),e.getEventTimes().getStartTime().format(CUSTOM_FORMATTER),"My events",e.getId())).toList();
    }

    @Override
    public String checkGoing(String token,Long id){
        System.out.println("CHECK INTEREST");
        MyActivity activity = this.myActivityRepository.findByUsername(jwtService.extractUsername(token));
        if (activity.getMyGoingEvent().containsKey(id)){
            return "going";
        }else if (activity.getMyInterestedEvent().containsKey(id)){
            return "interested";
        }
        return "false";
    }



    @Override
    public boolean checkInterested(String token,Long id){
        MyActivity activity = this.myActivityRepository.findByUsername(jwtService.extractUsername(token));
        return activity.getMyGoingEvent().containsKey(id);
    }

    @Override
    public List<MyCommentDto> findAllComments(String token) {
        MyActivity activity = this.myActivityRepository.findByUsername(jwtService.extractUsername(token));
        List<MyCommentDto> comments = new ArrayList<>();
        if (activity.getMyComments().size() != 0) {
            for (Map.Entry<Long, Long> s : activity.getMyComments().entrySet()) {
                CommentAndReplies c = this.commRepository.findById(s.getKey()).orElseThrow(() -> new CommentNotFoundException(s.getKey()));
                Event event = this.eventRepository.findById(c.getIdEvent()).orElseThrow(() -> new EventNotFoundException(c.getIdEvent()));
                comments.add(new MyCommentDto(c.getMessage(), this.getTimeAt(c.getCreatedAt()),
                        c.getUsername(), c.getIdEvent(), event.getEventInfo().getCreatedBy(), event.getEventInfo().getTitle(),
                        event.getEventInfo().getCoverImage().getImageBase64().replaceAll("data:application/octet-stream;base64,",""),
                        this.getTimeAt(event.getEventTimes().getCreatedTime())));
            }
        }
        return comments;

    }

    @Override
    public MyActivity findById(Long id) {
        return this.myActivityRepository.findById(id).orElseThrow(() -> new ActivityNotFoundException(id));
    }

    @Override
    public MyActivity findByUsername(String username) {
        return this.myActivityRepository.findByUsername(username);
    }

    @Override
    public MyActivity create(String username) {
        return this.myActivityRepository.save(new MyActivity(username));
    }

    @Override
    public MyActivity findOrCreate(String username) {
        if (this.myActivityRepository.findByUsername(username) != null){
            return this.myActivityRepository.findByUsername(username);
        }else{
            return this.create(username);
        }
    }

    @Override
    public void delete(Long id) {
        this.myActivityRepository.deleteById(id);
    }

    @Override
    public List<NotificationsDto> getNotifications(String token) {
        User u = this.userRepository.findByUsername(jwtService.extractUsername(token)).orElseThrow();
        List<NotificationsDto> list = new ArrayList<>();
        u.getNotification().getNotifications().stream().sorted(Comparator.comparing(NotificationInfo::getCreateAt)).forEach(n -> {
            list.add(new NotificationsDto(
                    n.getId(),
                    n.getFromUser(),
                    n.getTitle(),
                    n.getMessage(),
                    this.getTimeAt(n.getCreateAt()),
                    n.isRead(),
                    n.getTypes(),
                    n.getIdEvent(),
                    n.getIdComment()
                    )
            );
        });
        return list;
    }

    @Override
    public void doAllRead(String token) {
        User u = this.userRepository.findByUsername(jwtService.extractUsername(token)).orElseThrow();
        u.getNotification().getNotifications().stream().filter(n -> !n.isRead()).forEach(n -> n.setRead(true));
    }
}
