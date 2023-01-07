package com.example.theeventors.service;


import com.example.theeventors.model.EventTimes;

import java.time.LocalDateTime;
import java.util.List;

public interface EventTimesService {

    List<EventTimes> findAll();
    EventTimes findById(Long id);
    EventTimes create(LocalDateTime startTime, String duration);

    EventTimes update(Long id,LocalDateTime startTime,String duration);
    void delete(Long id);
}
