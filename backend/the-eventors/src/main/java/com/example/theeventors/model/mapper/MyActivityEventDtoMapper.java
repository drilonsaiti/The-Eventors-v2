/*
package com.example.theeventors.model.mapper;

import com.example.theeventors.model.Event;
import com.example.theeventors.model.MyActivity;
import com.example.theeventors.model.dto.EventsDto;
import com.example.theeventors.model.dto.MyActivityEventDto;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.function.Function;

public class MyActivityEventDtoMapper implements Function<Event, MyActivityEventDto> {



    @Override
    public MyActivityEventDto apply(Event event) {
        long days = ChronoUnit.DAYS.between(LocalDate.now(), event.getEventTimes().getCreatedTime());
        return new MyActivityEventDto(event.getEventInfo().getTitle(),event.getEventInfo().getCreatedBy(),
                days >=7 ? ChronoUnit.WEEKS.between(LocalDate.now(), event.getEventTimes().getCreatedTime()) + "w" : String.format("%dd ",days),
                event.getEventInfo().getCoverImage().getImageBase64());
    }
}
*/
