package com.example.theeventors.service;

import com.example.theeventors.model.NotificationInfo;
import com.example.theeventors.model.dto.NotificationInfoDto;
import com.example.theeventors.model.enumerations.NotificationTypes;
import com.google.firebase.messaging.FirebaseMessagingException;

public interface NotificationInfoService {

    NotificationInfo createGoing(Long id,NotificationInfoDto dto, NotificationTypes types) throws FirebaseMessagingException;
    NotificationInfo createInterested(Long id,NotificationInfoDto dto, NotificationTypes types) throws FirebaseMessagingException;
    NotificationInfo createComment(Long id,Long idComment,NotificationInfoDto dto, NotificationTypes types) throws FirebaseMessagingException;
    NotificationInfo createReplies(Long id,Long idComment,NotificationInfoDto dto, NotificationTypes types) throws FirebaseMessagingException;
    NotificationInfo createFollow(NotificationInfoDto dto, NotificationTypes types) throws FirebaseMessagingException;


    void setRead(Long id);
}
