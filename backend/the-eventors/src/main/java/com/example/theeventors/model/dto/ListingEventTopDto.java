package com.example.theeventors.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ListingEventTopDto {
    Long id;

    String title;

    String coverImage;

    String location;


    int going;
    int interested;

    String startDateTime;

    String agoCreated;
    String createdBy;
    String profileImage;

    Long categoryId;
}
