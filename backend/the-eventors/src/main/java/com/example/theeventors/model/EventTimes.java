package com.example.theeventors.model;


import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
@Entity
@Data
@NoArgsConstructor
public class EventTimes {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;
    LocalDateTime startTime;
    String duration;
    LocalDateTime createdTime;

    public EventTimes(LocalDateTime startTime, String duration) {
        this.startTime = startTime;
        this.duration = duration;
        this.createdTime = LocalDateTime.now();
    }
}
