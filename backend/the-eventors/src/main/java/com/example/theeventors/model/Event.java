package com.example.theeventors.model;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Entity
@Data
@NoArgsConstructor
public class Event {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;
    @ManyToOne
    EventInfo eventInfo;
    @ManyToOne
    EventTimes eventTimes;
    @ManyToMany
    List<Guest> guests;
    @ManyToOne
    Participant participant;
    @ManyToMany
    List<Comments> comments;

    public Event(EventInfo eventInfo, EventTimes eventTimes, List<Guest> guests,Participant participant) {
        this.eventInfo = eventInfo;
        this.eventTimes = eventTimes;
        this.guests = guests;
        this.participant = participant;
        this.comments = new ArrayList<>();
    }
}
