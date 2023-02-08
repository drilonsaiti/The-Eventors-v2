package com.example.theeventors.model;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;


import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Entity
@Data
@NoArgsConstructor
public class MyActivity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;
    String username;
    @ElementCollection
    Map<Long, LocalDateTime> myGoingEvent;
    @ElementCollection
    Map<Long, LocalDateTime> myInterestedEvent;

    @ElementCollection
    Map<Long,Long> myComments;

    public MyActivity(String username) {
        this.username = username;
        this.myGoingEvent = new HashMap<>();
        this.myInterestedEvent = new HashMap<>();
        this.myComments = new HashMap<>();
    }
}
