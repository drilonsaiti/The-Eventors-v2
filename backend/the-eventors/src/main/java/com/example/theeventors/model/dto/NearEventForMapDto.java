package com.example.theeventors.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class NearEventForMapDto {

    Long id;
    String title;
    String location;
    double distance;

    String startDateTime;

}
