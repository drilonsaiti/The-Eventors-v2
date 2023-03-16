package com.example.theeventors.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.Objects;

@AllArgsConstructor
@Data
public class ListingEventDtoResponse {

    Long id;

    String title;

    String coverImage;



    String location;


    String startAt;

    String agoCreated;
    String createdBy;

    String profileImage;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof ListingEventDtoResponse that)) return false;
        return getAgoCreated().equals(that.getAgoCreated());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getAgoCreated());
    }
}
