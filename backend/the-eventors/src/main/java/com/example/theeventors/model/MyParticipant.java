package com.example.theeventors.model;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;
@Entity
@Data
@NoArgsConstructor
public class MyParticipant {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;
    String username;
    @ManyToMany
    List<Event> myGoingEvent;
    @ManyToMany
    List<Event> myInterestedEvent;

    public MyParticipant(String username) {
        this.username = username;
        this.myGoingEvent = new ArrayList<>();
        this.myInterestedEvent = new ArrayList<>();
    }
}
