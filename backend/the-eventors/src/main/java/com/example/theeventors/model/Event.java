package com.example.theeventors.model;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.util.ArrayList;
import java.util.List;

@Entity
@Data
@NoArgsConstructor
@OnDelete(action = OnDeleteAction.CASCADE)
public class Event {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;
    @OneToOne(cascade = CascadeType.ALL, orphanRemoval = true)
    EventInfo eventInfo;

    @ManyToOne
    Category category;
    @OneToOne(cascade = CascadeType.ALL, orphanRemoval = true)
    EventTimes eventTimes;
    @OneToOne(cascade = CascadeType.ALL, orphanRemoval = true)
    Guest guests;
    @OneToOne(cascade = CascadeType.ALL, orphanRemoval = true)
    Activity activity;
    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
    List<Comments> comments;

    public Event(Category category,EventInfo eventInfo, EventTimes eventTimes, Guest guests, Activity activity) {
        this.category = category;
        this.eventInfo = eventInfo;
        this.eventTimes = eventTimes;
        this.guests = guests;
        this.activity = activity;
        this.comments = new ArrayList<>();
    }


}
