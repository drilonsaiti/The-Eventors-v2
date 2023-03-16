package com.example.theeventors.service;


import com.example.theeventors.model.CommentAndReplies;
import com.example.theeventors.model.MyActivity;
import com.example.theeventors.model.NotificationInfo;
import com.example.theeventors.model.dto.CheckRemoveDto;
import com.example.theeventors.model.dto.MyActivityEventDto;
import com.example.theeventors.model.dto.MyCommentDto;
import com.example.theeventors.model.dto.NotificationsDto;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

public interface MyActivityService {
    List<MyActivity> findAll();
    MyActivity findById(Long id);
    MyActivity findByUsername(String username);

    MyActivity create(String username);

    MyActivity findOrCreate(String username);

     List<MyActivityEventDto> findAllMyGoingEvents(String token);
     List<MyActivityEventDto> findAllMyInterestedEvents(String token);
    List<MyActivityEventDto> findAllForActivityProfile(String token);

     List<MyActivityEventDto> findAllMyEvents(String token,boolean isUser);
    List<MyCommentDto> findAllComments(String token);
    String getTimeAt(LocalDateTime time);

    boolean checkInterested(String token,Long id);
    String checkGoing(String token,Long id);

    void delete(Long id);

    List<NotificationsDto> getNotifications(String token);

    void doAllRead(String token);

}
