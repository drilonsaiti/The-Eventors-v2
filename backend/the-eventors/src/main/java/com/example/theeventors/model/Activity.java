package com.example.theeventors.model;

import jakarta.persistence.*;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;
@Entity
@Data

public class Activity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;
    @ElementCollection
    List<String> going;
    @ElementCollection
    List<String> interested;
    @OneToOne(cascade = CascadeType.ALL, orphanRemoval = true)
    ActivityPerEvents activity;

    public Activity() {
        this.going = new ArrayList<>();
        this.interested = new ArrayList<>();
        this.activity = new ActivityPerEvents();
    }
}
