package com.example.theeventors.model.dto;

import lombok.Data;

import java.time.LocalDateTime;


@Data
public class MyCommentDto {
    String message;
    LocalDateTime createdAt;
    String username;
    Long idEvent;
    String createdBy;
    String title;
    LocalDateTime createdEvent;

    public MyCommentDto(String message, LocalDateTime createdAt, String username, Long idEvent, String createdBy, String title, LocalDateTime createdEvent) {
        this.message = message;
        this.createdAt = createdAt;
        this.username = username;
        this.idEvent = idEvent;
        this.createdBy = createdBy;
        this.title = title;
        this.createdEvent = createdEvent;
    }
}
