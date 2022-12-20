package com.example.theeventors.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
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
    int duration;
    LocalDateTime createdTime;

    public EventTimes(LocalDateTime startTime, int duration) {
        this.startTime = startTime;
        this.duration = duration;
        this.createdTime = LocalDateTime.now();
    }
}
