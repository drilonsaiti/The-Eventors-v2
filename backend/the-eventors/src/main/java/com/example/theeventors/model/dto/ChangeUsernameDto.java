package com.example.theeventors.model.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class ChangeUsernameDto {

    String token;
    String password;
    String newUsername;
}
