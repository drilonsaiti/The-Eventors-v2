package com.example.theeventors.model.mapper;

import com.example.theeventors.model.Event;
import com.example.theeventors.model.User;
import com.example.theeventors.model.dto.ListingEventDtoResponse;
import com.example.theeventors.repository.UserRepository;
import com.example.theeventors.service.MyActivityService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.format.DateTimeFormatter;
import java.util.function.Function;

@Service
@AllArgsConstructor
public class ListingEventDtoResponseMapper implements Function<Event, ListingEventDtoResponse> {
    final static DateTimeFormatter CUSTOM_FORMATTER = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm");

    private final MyActivityService service;

    private final UserRepository userRepository;


    @Override
    public ListingEventDtoResponse apply(Event event) {
        User u = this.userRepository.findByUsername(event.getEventInfo().getCreatedBy()).orElseThrow();
        String photo = u.getProfileImage() != null ? u.getProfileImage().getImageBase64().replaceAll("data:application/octet-stream;base64,","") : "";

        return new ListingEventDtoResponse(
                event.getId(),
                event.getEventInfo().getTitle(),
                event.getEventInfo().getCoverImage().getImageBase64().replaceAll("data:application/octet-stream;base64,"
                        ,""),
                event.getAddress().getLocation(),
                event.getEventTimes().getStartTime().format(CUSTOM_FORMATTER),
                service.getTimeAt(event.getEventTimes().getCreatedTime()),
                event.getEventInfo().getCreatedBy(),
                photo
                );
    }
}
