package com.example.theeventors.model.dto;


import lombok.Data;

import java.util.List;
import java.util.Objects;


public record EventsDto (

        Long id,
        String title,
        String description,
        String location,

        String createdBy,

        String coverImage,
        List<String> images,
        List<String> going,
        List<String> interested,
        List<String> guest,
        String startDateTime,

        String endDateTime,
        String duration,
        String category,
        Long categoryId


){
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof EventsDto eventsDto)) return false;
        return id.equals(eventsDto.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}
