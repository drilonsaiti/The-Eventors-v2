package com.example.theeventors.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ListingAllEventDto {
    Long id;

    String title;

    String coverImage;

    String location;

    String startDateTime;

    String agoCreated;
    String createdBy;
    String profileImage;

    Long categoryId;
}
