package com.example.theeventors.service.impl;

import com.example.theeventors.config.JwtService;
import com.example.theeventors.model.Event;
import com.example.theeventors.model.NotificationInfo;
import com.example.theeventors.model.dto.NotificationInfoDto;
import com.example.theeventors.model.enumerations.NotificationTypes;
import com.example.theeventors.repository.EventRepository;
import com.example.theeventors.repository.NotificationInfoRepository;
import com.example.theeventors.repository.NotificationRepository;
import com.example.theeventors.service.NotificationInfoService;
import com.google.firebase.messaging.FirebaseMessagingException;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
@AllArgsConstructor
public class NotificationInfoServiceImpl implements NotificationInfoService {

    final NotificationInfoRepository repository;
    final NotificationRepository notificationRepository;

    final FirebaseMessagingService messagingService;
    final JwtService jwtService;

    final EventRepository eventRepository;
    @Override
    public NotificationInfo createGoing(Long id,NotificationInfoDto dto, NotificationTypes types) throws FirebaseMessagingException {
        String token = this.notificationRepository.findByUsername(dto.getTo()).getTokenNotification();
        String usernameFrom = this.jwtService.extractUsername(dto.getFrom());
        NotificationInfo info = this.repository.save(new NotificationInfo(
                dto.getTo(),
                token,
                usernameFrom,
                dto.getTitle(),
               " will come to your event ("+dto.getMessage()+")",
                LocalDateTime.now(),
                types,
                id,
                null
        ));

        this.messagingService.sendNotification(info);
        return info;
    }

    @Override
    public NotificationInfo createInterested(Long id,NotificationInfoDto dto, NotificationTypes types) throws FirebaseMessagingException {
        String token = this.notificationRepository.findByUsername(dto.getTo()).getTokenNotification();
        String usernameFrom = this.jwtService.extractUsername(dto.getFrom());
        NotificationInfo info = this.repository.save(new NotificationInfo(
                dto.getTo(),
                token,
                usernameFrom,
                dto.getTitle(),
                 " is interested for your event ("+dto.getMessage()+")",
                LocalDateTime.now(),
                types,
                id,
                null
        ));

        this.messagingService.sendNotification(info);
        return info;
    }

    @Override
    public NotificationInfo createComment(Long idEvent,Long idComment,NotificationInfoDto dto, NotificationTypes types) throws FirebaseMessagingException {
        String token = this.notificationRepository.findByUsername(dto.getTo()).getTokenNotification();
        String usernameFrom = this.jwtService.extractUsername(dto.getFrom());
        NotificationInfo info = this.repository.save(new NotificationInfo(
                dto.getTo(),
                token,
                usernameFrom,
                dto.getTitle(),
                " comment on your event ("+dto.getMessage()+")",
                LocalDateTime.now(),
                types,
                idEvent,
                idComment
        ));

        this.messagingService.sendNotification(info);
        return info;
    }

    @Override
    public NotificationInfo createReplies(Long id,Long idComment,NotificationInfoDto dto, NotificationTypes types) throws FirebaseMessagingException {
        String token = this.notificationRepository.findByUsername(dto.getTo()).getTokenNotification();
        String usernameFrom = this.jwtService.extractUsername(dto.getFrom());
        Event e = this.eventRepository.findById(id).orElseThrow();
        NotificationInfo info = this.repository.save(new NotificationInfo(
                dto.getTo(),
                token,
                usernameFrom,
                dto.getTitle(),
                " replies to your comment on "+e.getEventInfo().getTitle(), //and comment here
                LocalDateTime.now(),
                types,
                id,
                idComment
        ));

        this.messagingService.sendNotification(info);
        return info;
    }

    @Override
    public NotificationInfo createFollow(NotificationInfoDto dto, NotificationTypes types) throws FirebaseMessagingException {
        String token = this.notificationRepository.findByUsername(dto.getTo()).getTokenNotification();
        String usernameFrom = this.jwtService.extractUsername(dto.getFrom());
        NotificationInfo info = this.repository.save(new NotificationInfo(
                dto.getTo(),
                token,
                usernameFrom,
                dto.getTitle(),
                " started following you",
                LocalDateTime.now(),
                types,
                null,
                null
        ));

        this.messagingService.sendNotification(info);
        return info;
    }

    @Override
    public void setRead(Long id) {
       NotificationInfo info = this.repository.findById(id).orElseThrow();
       info.setRead(true);
       this.repository.save(info);
    }
}
