package com.example.theeventors.service;

import com.example.theeventors.model.*;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;

import java.util.List;

public interface EventService {

    List<Event> findAll();
    Event findById(Long id);
    Event create(EventInfo eventInfo, EventTimes eventTimes,List<Guest> guests,Participant participant);
    void delete(Long id);
}
