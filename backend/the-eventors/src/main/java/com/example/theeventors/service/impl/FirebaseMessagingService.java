package com.example.theeventors.service.impl;

import com.example.theeventors.model.NotificationInfo;
import com.example.theeventors.model.User;
import com.example.theeventors.model.dto.NotificationTokenDto;
import com.example.theeventors.model.enumerations.NotificationTypes;
import com.example.theeventors.repository.NotificationRepository;
import com.example.theeventors.repository.UserRepository;
import com.google.firebase.messaging.*;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
@AllArgsConstructor
public class FirebaseMessagingService {

    private final FirebaseMessaging firebaseMessaging;
    private final NotificationRepository notificationRepository;

    private final UserRepository userRepository;


    public void addNotificationToken(NotificationTokenDto dto){
        com.example.theeventors.model.Notification n = this.notificationRepository.findByUsername(dto.getUsername());
        if(n == null || !n.getTokenNotification().equals(dto.getNotificationToken())) {
            User u = this.userRepository.findByUsername(dto.getUsername()).orElseThrow();

            com.example.theeventors.model.Notification notification =  this.notificationRepository.save(new com.example.theeventors.model.Notification(dto.getUsername(), dto.getNotificationToken()));
            u.setNotification(notification);
            this.userRepository.save(u);
        }
    }


    public String sendNotification(NotificationInfo note ) throws FirebaseMessagingException {
        Map<String,String> data = new HashMap<>();
        data.put("click_action","FLUTTER_NOTIFICATION_CLICK");
        data.put("sound","default");
        data.put("status","done");
        if(note.getTypes() == NotificationTypes.GOING || note.getTypes() == NotificationTypes.INTERESTED){
            data.put("screen","DetailsEventScreen(id:"+note.getIdEvent()+")");
        }
        Notification notification = Notification
                .builder()
                .setTitle(note.getTitle())
                .setBody(note.getFromUser() + note.getMessage())

                .build();

        Message message = Message
                .builder()
                .setToken(note.getReceiverToken())

                .setNotification(notification)
                .putAllData(data)
                .build();
        User u = this.userRepository.findByUsername(note.getToUser()).orElseThrow();
        u.getNotification().getNotifications().add(note);
        this.userRepository.save(u);
        return firebaseMessaging.send(message);
    }

}
