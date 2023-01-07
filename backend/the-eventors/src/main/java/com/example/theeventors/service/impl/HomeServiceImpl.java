package com.example.theeventors.service.impl;

import com.example.theeventors.model.Event;
import com.example.theeventors.model.User;
import com.example.theeventors.repository.EventRepository;
import com.example.theeventors.repository.UserRepository;
import com.example.theeventors.service.HomeService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class HomeServiceImpl implements HomeService {

    private final UserRepository userRepository;
    private final EventRepository eventRepository;

    public HomeServiceImpl(UserRepository userRepository, EventRepository eventRepository) {
        this.userRepository = userRepository;
        this.eventRepository = eventRepository;
    }

    @Override
    public List<Event> findAll(String username) {
        User user = this.userRepository.findByUsername(username).orElseThrow(() -> new UsernameNotFoundException(username));
        List<Event> events = new ArrayList<>();
        for (String s : user.getFollowing()){
            events.addAll(this.eventRepository.findAllByEventInfo_CreatedBy(s));
        }
        return events;
    }
}
