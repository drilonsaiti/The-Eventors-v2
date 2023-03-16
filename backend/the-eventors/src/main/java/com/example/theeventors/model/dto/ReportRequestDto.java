package com.example.theeventors.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ReportRequestDto {

    String token;
    String type;
}
