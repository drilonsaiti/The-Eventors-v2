package com.example.theeventors.model.mapper;

import com.example.theeventors.model.Event;
import com.example.theeventors.model.User;
import com.example.theeventors.model.dto.EventsDto;
import com.example.theeventors.model.exceptions.UserNotFoundException;
import com.example.theeventors.repository.UserRepository;
import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;
import java.util.function.Function;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
@AllArgsConstructor
@Data
public class EventsDtoMapper implements Function<Event, EventsDto> {
    final static DateTimeFormatter CUSTOM_FORMATTER = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm");

    private final UserRepository userRepository;


    @Override
    public EventsDto apply(Event event) {
        List<String> images = new ArrayList<>();
        event.getEventInfo().getImages().forEach(i -> images.add(i.getImageBase64().replaceAll("data:application/octet-stream;base64,"
                ,"")));
        Pattern pattern = Pattern.compile("^[0-9]+\s{0,}[hdwmy]");
        Matcher m = pattern.matcher("20hours");
        StringBuilder line = new StringBuilder();
        while (m.find()){
            String [] parts = m.group().split("");
            for (String part : parts) {
                char c = part.charAt(0);

                if (!Character.isSpaceChar(c)) {
                    if (Character.isAlphabetic(c)) {
                        line.append(" ");
                        line.append(c);
                        break;
                    } else {
                        line.append(part);
                    }
                }
            }
        }

        List<String> going = new ArrayList<>();

        event.getActivity().getGoing().forEach(i -> {
            User u = this.userRepository.findByUsername(i).orElseThrow(() -> new UserNotFoundException(i));
            String imageBase64 = u.getProfileImage() != null
                    ? u.getProfileImage().getImageBase64().replace("data:application/octet-stream;base64,", "")
                    : "";

            going.add(imageBase64);
        });

        List<String> interested = new ArrayList<>();

        event.getActivity().getInterested().forEach(i -> {
           User u = this.userRepository.findByUsername(i).orElseThrow(() -> new UserNotFoundException(i));
            String imageBase64 = u.getProfileImage() != null
                    ? u.getProfileImage().getImageBase64().replace("data:application/octet-stream;base64,", "")
                    : "";

            interested.add(imageBase64);
        });

        List<String> guest = new ArrayList<>();
        guest.addAll(event.getGuests().getWithUsername());
        guest.addAll(event.getGuests().getWithNameAndSurname());

        LocalDateTime time = event.getEventTimes().getStartTime();
        String duration = line.toString();
        if(duration.contains("h")){
            System.out.println(duration.split(" ")[0]);
            time = time.plus(Long.parseLong(duration.split(" ")[0]), ChronoUnit.HOURS);
        }else if(duration.contains("d")){
            time =   time.plus(Long.parseLong(duration.split(" ")[0]), ChronoUnit.DAYS);

        }else if(duration.contains("w")){
            time =  time.plus(Long.parseLong(duration.split(" ")[0]), ChronoUnit.WEEKS);

        }else if(duration.contains("m")){
            time =   time.plus(Long.parseLong(duration.split(" ")[0]), ChronoUnit.MONTHS);

        }else {
            time =  time.plus(Long.parseLong(duration.split(" ")[0]), ChronoUnit.YEARS);
        }



        return new EventsDto(
                event.getId(),
                event.getEventInfo().getTitle(),
                event.getEventInfo().getDescription(),
                event.getAddress().getLocation(),
                event.getEventInfo().getCreatedBy(),
                event.getEventInfo().getCoverImage().getImageBase64().replaceAll("data:application/octet-stream;base64,"
                        ,""),
                images,
                going.stream().filter(g -> !g.isEmpty()).limit(4).toList(),
                interested.stream().filter(g -> !g.isEmpty()).limit(4).toList(),
                guest,
                event.getEventTimes().getStartTime().format(CUSTOM_FORMATTER),
                time.toString(),
                line.toString(),
                event.getCategory().getName(),
                event.getCategory().getId()
        );
    }
}
