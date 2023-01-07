package com.example.theeventors.service.impl;

import com.example.theeventors.model.ActivityPerEvents;
import com.example.theeventors.model.Event;
import com.example.theeventors.model.User;
import com.example.theeventors.model.exceptions.EventNotFoundException;
import com.example.theeventors.repository.ActivityPerEventsRepository;
import com.example.theeventors.repository.EventRepository;
import com.example.theeventors.repository.UserRepository;
import com.example.theeventors.service.ActivityPerEventsService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class ActivityPerEventsServiceImpl implements ActivityPerEventsService {

    private final ActivityPerEventsRepository repository;
    private final EventRepository eventRepository;
    private final UserRepository userRepository;

    public ActivityPerEventsServiceImpl(ActivityPerEventsRepository repository, EventRepository eventRepository, UserRepository userRepository) {
        this.repository = repository;
        this.eventRepository = eventRepository;
        this.userRepository = userRepository;
    }


    @Override
    public ActivityPerEvents countUsers(Long idEvent,HttpServletRequest req) {
        String username = req.getRemoteUser();
        Event event = this.eventRepository.findById(idEvent).orElseThrow(() -> new EventNotFoundException(idEvent));
        ActivityPerEvents activity = event.getActivity().getActivity();

        if ( username != null){
            User user = this.userRepository.findByUsername(username).orElseThrow(() -> new UsernameNotFoundException(String.format("Username with %s doesn't exists",username)));

            if (user.getFollowing().stream().anyMatch(u -> u.equals(event.getEventInfo().getCreatedBy()))
            && !activity.getFollowers().contains(username)){
                    activity.getFollowers().add(username);
            }else if(!activity.getUsers().contains(username)){
                activity.getUsers().add(username);
            }
        }else if(!activity.getAnonymous().contains(req.getRemoteAddr())){
            activity.getAnonymous().add(req.getRemoteAddr());
        }
        return this.repository.save(activity);
    }
}
