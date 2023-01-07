package com.example.theeventors.service.impl;

import com.example.theeventors.model.EventTimes;
import com.example.theeventors.model.exceptions.EventTimesNotFoundException;
import com.example.theeventors.repository.EventTimesRepository;
import com.example.theeventors.service.EventTimesService;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
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
        return this.eventTimesRepository.findById(id).orElseThrow(() -> new EventTimesNotFoundException(id));
    }

    @Override
    public EventTimes create(LocalDateTime startTime, String duration) {
        return this.eventTimesRepository.save(new EventTimes(startTime,duration));
    }

    @Override
    public EventTimes update(Long id,LocalDateTime startTime, String duration) {
        EventTimes eventTimes = this.findById(id);
        eventTimes.setDuration(duration);
        eventTimes.setStartTime(startTime);
        return this.eventTimesRepository.save(eventTimes);
    }

    @Override
    public void delete(Long id) {
        this.eventTimesRepository.deleteById(id);
    }
}
