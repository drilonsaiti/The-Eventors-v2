package com.example.theeventors.model;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Data
@NoArgsConstructor
@Entity
public class Notification {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;


    String username;
    @Column(length = 999)
    String tokenNotification;
    @OneToMany(fetch = FetchType.EAGER,orphanRemoval = true)
    List<NotificationInfo> notifications;

    public Notification(String username, String tokenNotification) {
        this.username = username;
        this.tokenNotification = tokenNotification;
        this.notifications = new ArrayList<>();
    }
}
