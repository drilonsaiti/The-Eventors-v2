package com.example.theeventors.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CommentResponseDto {

    Long id;
    String message;
    LocalDateTime createdAt;
    String username;

    String profileImage;
    Long idEvent;

    List<CommentResponseDto> replies;

    public CommentResponseDto(Long id, String message, LocalDateTime createdAt, String username,String profileImage, Long idEvent) {
        this.id = id;
        this.message = message;
        this.createdAt = createdAt;
        this.username = username;
        this.profileImage = profileImage;
        this.idEvent = idEvent;
        this.replies = new ArrayList<>();
    }
}
