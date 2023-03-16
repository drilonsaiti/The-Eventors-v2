/*
package com.example.theeventors.model.mapper;

import com.example.theeventors.model.Event;
import com.example.theeventors.model.dto.ListingEventDtoResponse;
import com.example.theeventors.model.dto.ListingEventNearDto;
import com.example.theeventors.service.LocationService;
import com.example.theeventors.service.MyActivityService;
import com.google.maps.errors.ApiException;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.time.format.DateTimeFormatter;
import java.util.function.Function;

@Service
@AllArgsConstructor
public class ListingEventNearMapper implements Function<Event, ListingEventNearDto> {
    final static DateTimeFormatter CUSTOM_FORMATTER = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm");

    private final MyActivityService service;

    private final LocationService locationService;



    @SneakyThrows
    @Override
    public ListingEventNearDto apply(Event event) {
        return new ListingEventNearDto(
                event.getId(),
                event.getEventInfo().getTitle(),
                event.getEventInfo().getCoverImage().getImageBase64().replaceAll("data:application/octet-stream;base64,"
                        ,""),
                event.getEventInfo().getLocation(),
                locationService.getDistance(event.getEventInfo().getLocation());

        event.getEventTimes().getStartTime().format(CUSTOM_FORMATTER),
                service.getTimeAt(event.getEventTimes().getCreatedTime()),
                event.getEventInfo().getCreatedBy()

                );
    }
}
*/
