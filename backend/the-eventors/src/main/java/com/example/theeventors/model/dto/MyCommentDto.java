package com.example.theeventors.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.time.LocalDateTime;


@Data
@AllArgsConstructor
public class MyCommentDto {
    String message;
    String commentCreatedAt;
    String username;
    Long idEvent;
    String createdBy;
    String title;
    String coverImage;
    String createdEvent;


}
