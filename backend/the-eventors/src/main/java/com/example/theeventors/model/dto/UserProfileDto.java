package com.example.theeventors.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class UserProfileDto {

    String username;

    String profileImage;
    String fullName;
    String bio;
    int countEvents;
    int countFollowers;
    int countFollowing;
}
