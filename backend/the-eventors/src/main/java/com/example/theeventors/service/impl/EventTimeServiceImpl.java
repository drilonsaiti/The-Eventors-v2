package com.example.theeventors.service.impl;

import com.example.theeventors.model.EventTimes;
import com.example.theeventors.repository.EventTimesRepository;
import com.example.theeventors.service.EventTimesService;

import java.time.LocalDateTime;
import java.util.List;

public class EventTimeServiceImpl implements EventTimesService {

    private final EventTimesRepository eventTimesRepository;

    public EventTimeServiceImpl(EventTimesRepository eventTimesRepository) {
        this.eventTimesRepository = eventTimesRepository;
    }

    @Override
    public List<EventTimes> findAll() {
        return this.eventTimesRepository.findAll();
    }

    @Override
    public EventTimes findById(Long id) {
        return this.eventTimesRepository.findById(id).orElseThrow();
    }

    @Override
    public EventTimes create(LocalDateTime startTime, int duration) {
        return this.eventTimesRepository.save(new EventTimes(startTime,duration));
    }

    @Override
    public void delete(Long id) {
        this.eventTimesRepository.deleteById(id);
    }
}
