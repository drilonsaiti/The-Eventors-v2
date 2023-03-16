package com.example.theeventors.model.mapper;

import com.example.theeventors.model.Event;
import com.example.theeventors.model.dto.EventForSearchDto;
import com.example.theeventors.model.dto.ListingEventDtoResponse;
import com.example.theeventors.service.MyActivityService;
import org.springframework.stereotype.Service;

import java.time.format.DateTimeFormatter;
import java.util.function.Function;

@Service
public class EventForSearchDtoMapper implements Function<Event, EventForSearchDto>{

        @Override
        public EventForSearchDto apply(Event event) {
            return new EventForSearchDto(event.getId(),event.getEventInfo().getTitle());
        }
    }

