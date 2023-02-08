package com.example.theeventors.model.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;


public record EventsDto (

    String title,
    String description,
    String location,

    String createdBy,

    //MultipartFile coverImage,
    //MultipartFile [] images,
    String guest,
    LocalDateTime startDateTime,
    String duration,
    String category
){}
