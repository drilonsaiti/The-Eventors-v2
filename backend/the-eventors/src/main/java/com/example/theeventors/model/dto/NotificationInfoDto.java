package com.example.theeventors.model.dto;

import com.example.theeventors.model.enumerations.NotificationTypes;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class NotificationInfoDto {
    String to;
    String from;
    String title;
    String message;

}
