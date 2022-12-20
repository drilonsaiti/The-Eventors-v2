package com.example.theeventors.service.impl;

import com.example.theeventors.model.*;
import com.example.theeventors.repository.EventRepository;
import com.example.theeventors.service.EventService;

import java.util.List;

public class EventServiceImpl implements EventService {

    private final EventRepository eventRepository;

    public EventServiceImpl(EventRepository eventRepository) {
        this.eventRepository = eventRepository;
    }


    @Override
    public List<Event> findAll() {
        return this.eventRepository.findAll();
    }

    @Override
    public Event findById(Long id) {
        return this.eventRepository.findById(id).orElseThrow();
    }

    @Override
    public Event create(EventInfo eventInfo, EventTimes eventTimes, List<Guest> guests, Participant participant) {
        return this.eventRepository.save(new Event(eventInfo,eventTimes,guests,participant));
    }

    @Override
    public void delete(Long id) {
        this.eventRepository.deleteById(id);
    }
}
