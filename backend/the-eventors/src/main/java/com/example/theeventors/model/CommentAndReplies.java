package com.example.theeventors.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
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


    public CommentAndReplies(String message, String username) {
        this.message = message;
        this.username = username;
        this.createdAt = LocalDateTime.now();
    }
}
