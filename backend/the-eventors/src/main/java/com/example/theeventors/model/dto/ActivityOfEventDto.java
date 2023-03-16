package com.example.theeventors.model.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ActivityOfEventDto {

    int going;
    int interested;
    int followers;
    int users;
    int anonymous;
}
