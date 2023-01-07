package com.example.theeventors.model;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.Comparator;

@Entity
@Data
@NoArgsConstructor
public class CommentAndReplies {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;
    String message;
    LocalDateTime createdAt;
    String username;

    Long idEvent;

    public CommentAndReplies(String message, String username,Long idEvent) {
        this.message = message;
        this.username = username;
        this.idEvent = idEvent;
        this.createdAt = LocalDateTime.now();
    }
}
