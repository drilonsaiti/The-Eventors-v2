package com.example.theeventors.service.impl;

import com.example.theeventors.config.JwtService;
import com.example.theeventors.model.ActivityPerEvents;
import com.example.theeventors.model.Event;
import com.example.theeventors.model.User;
import com.example.theeventors.model.dto.ActivityOfEventDto;
import com.example.theeventors.model.exceptions.EventNotFoundException;
import com.example.theeventors.repository.ActivityPerEventsRepository;
import com.example.theeventors.repository.EventRepository;
import com.example.theeventors.repository.UserRepository;
import com.example.theeventors.service.ActivityPerEventsService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.AllArgsConstructor;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class ActivityPerEventsServiceImpl implements ActivityPerEventsService {

    private final ActivityPerEventsRepository repository;
    private final EventRepository eventRepository;
    private final UserRepository userRepository;

    private final JwtService jwtService;


    @Override
    public ActivityPerEvents countUsers(Long idEvent,String token) {
        System.out.println("ACTIVITYYYYYYYY " + token);
        String username = "";
        if(token.length() > 20) {
            username = jwtService.extractUsername(token);
        }else{
            username = token;
        }
        Event event = this.eventRepository.findById(idEvent).orElseThrow(() -> new EventNotFoundException(idEvent));
        ActivityPerEvents activity = event.getActivity().getActivity();

        if ( username != null){
            String finalUsername = username;
            User user = this.userRepository.findByUsername(username).orElseThrow(() -> new UsernameNotFoundException(String.format("Username with %s doesn't exists", finalUsername)));
            boolean flag = user.getFollowing().stream().anyMatch(u -> u.equals(event.getEventInfo().getCreatedBy()));
            if (flag
            && !activity.getFollowers().contains(username)){
                    activity.getFollowers().add(username);
                return this.repository.save(activity);

            }else if(!flag && !activity.getUsers().contains(username)){
                activity.getUsers().add(username);
                return this.repository.save(activity);

            }
        }else
            if(!activity.getAnonymous().contains(token)){
            activity.getAnonymous().add(token);
            return this.repository.save(activity);
        }
            return activity;
    }


    public ActivityOfEventDto getActivity(Long id){
        Event event = this.eventRepository.findById(id).orElseThrow(() -> new EventNotFoundException(id));
        return new ActivityOfEventDto(event.getActivity().getGoing().size(),
                event.getActivity().getInterested().size(),
                event.getActivity().getActivity().getFollowers().size(),
                event.getActivity().getActivity().getUsers().size(),
                event.getActivity().getActivity().getAnonymous().size());
    }
}
