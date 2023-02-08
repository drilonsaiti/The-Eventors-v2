package com.example.theeventors.model.mapper;

import com.example.theeventors.model.Event;
import com.example.theeventors.model.dto.EventsDto;
import org.springframework.stereotype.Service;

import java.util.function.Function;

@Service
public class EventsDtoMapper implements Function<Event, EventsDto> {
    @Override
    public EventsDto apply(Event event) {
        return new EventsDto(
                event.getEventInfo().getTitle(),
                event.getEventInfo().getDescription(),
                event.getEventInfo().getLocation(),
                event.getEventInfo().getCreatedBy(),
                event.getGuests().toString(),
                event.getEventTimes().getStartTime(),
                event.getEventTimes().getDuration(),
                event.getCategory().getName()
        );
    }
}
