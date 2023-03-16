package com.example.theeventors.model.dto;

import com.example.theeventors.model.enumerations.NotificationTypes;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@Data
@NoArgsConstructor
public class NotificationsDto {
    Long id;
    String fromUser;
    String title;
    String message;
    String createAt;
    boolean read;
    NotificationTypes types;

    Long idEvent;
    Long idComment;
}
