package com.example.theeventors.service.impl;

import com.example.theeventors.model.*;
import com.example.theeventors.model.exceptions.ActivityNotFoundException;
import com.example.theeventors.model.exceptions.CategoryNotFoundException;
import com.example.theeventors.model.exceptions.EventNotFoundException;
import com.example.theeventors.repository.*;
import com.example.theeventors.service.EventService;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class EventServiceImpl implements EventService {

    private final EventRepository eventRepository;
    private final ActivityRepository activityRepository;
    private final CommentsRepository commentsRepository;
    private final CommentAndRepliesRepository commentAndRepliesRepository;
    private final MyActivityRepository myActivityRepository;
    private final CategoryRepository categoryRepository;

    public EventServiceImpl(EventRepository eventRepository,
                            ActivityRepository activityRepository,
                            CommentsRepository commentsRepository,
                            CommentAndRepliesRepository commentAndRepliesRepository, MyActivityRepository myActivityRepository, CategoryRepository categoryRepository) {
        this.eventRepository = eventRepository;
        this.activityRepository = activityRepository;
        this.commentsRepository = commentsRepository;
        this.commentAndRepliesRepository = commentAndRepliesRepository;

        this.myActivityRepository = myActivityRepository;
        this.categoryRepository = categoryRepository;
    }


    @Override
    public List<Event> findAll() {
        return this.eventRepository.findAll();
    }

    @Override
    public Event findById(Long id) {
        return this.eventRepository.findById(id).orElseThrow(() -> new EventNotFoundException(id));
    }

    @Override
    public Event create(Long categoryId,EventInfo eventInfo, EventTimes eventTimes, Guest guests, Activity activity) {
        Category category = this.categoryRepository.findById(categoryId).orElseThrow(() -> new CategoryNotFoundException(categoryId));
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
        myActivity.getMyComments().add(commentAndReplies.getId());
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

        myActivity.getMyComments().add(commentAndReplies.getId());
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
    public void delete(Long id) {
        List<MyActivity> activities = this.myActivityRepository.findAll();
        List<MyActivity> activity = activities.stream().filter(u -> u.getMyGoingEvent().keySet().stream().anyMatch(b -> b == id) ||
                u.getMyInterestedEvent().keySet().stream().anyMatch(b -> b == id)).toList();
        for (MyActivity ac :  activity){
            if (ac.getMyInterestedEvent().keySet().stream().anyMatch(a -> a == id)){
                ac.getMyInterestedEvent().remove(id);
                this.myActivityRepository.save(ac);
            }else{
                ac.getMyGoingEvent().remove(id);
                this.myActivityRepository.save(ac);
            }
        }
        this.eventRepository.deleteById(id);

    }

}
