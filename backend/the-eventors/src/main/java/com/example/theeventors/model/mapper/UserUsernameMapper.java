package com.example.theeventors.model.mapper;


import com.example.theeventors.model.Event;
import com.example.theeventors.model.User;
import com.example.theeventors.model.dto.EventsDto;
import com.example.theeventors.model.dto.UserUsernameDto;
import org.springframework.stereotype.Service;

import java.util.function.Function;

@Service
public class UserUsernameMapper implements Function<User, UserUsernameDto> {
    @Override
    public UserUsernameDto apply(User u) {

        String photo = u.getProfileImage() != null ? u.getProfileImage().getImageBase64().replaceAll("data:application/octet-stream;base64,","") : "";
        return new UserUsernameDto(
                u.getUsername(),
                photo
        );
    }
}
