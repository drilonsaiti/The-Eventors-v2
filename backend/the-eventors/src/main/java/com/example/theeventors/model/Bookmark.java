package com.example.theeventors.model;

import com.example.theeventors.model.enumerations.BookmakrsStatus;
import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Data
@Entity
@NoArgsConstructor

public class Bookmark {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private LocalDateTime dateCreated;

    @ManyToOne
    private User user;

    @ManyToMany
    private List<Event> events;

    @Enumerated(EnumType.STRING)
    private BookmakrsStatus status;


    public Bookmark(User user) {
        this.dateCreated = LocalDateTime.now();
        this.user = user;
        this.events = new ArrayList<>();
        this.status = BookmakrsStatus.CREATED;
    }

}
