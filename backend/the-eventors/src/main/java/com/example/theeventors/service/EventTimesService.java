package com.example.theeventors.service;


import com.example.theeventors.model.EventTimes;

import java.time.LocalDateTime;
import java.util.List;

public interface EventTimesService {

    List<EventTimes> findAll();
    EventTimes findById(Long id);
    EventTimes create(LocalDateTime startTime, int duration);
    void delete(Long id);
}
