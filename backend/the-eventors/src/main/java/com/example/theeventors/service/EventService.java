package com.example.theeventors.service;

import com.example.theeventors.model.*;


import java.util.List;

public interface EventService {

    List<Event> findAll();
    Event findById(Long id);
    Event create(Long category,EventInfo eventInfo, EventTimes eventTimes, Guest guests, Activity activity);

    Event update(Long id,Long idCategory,EventInfo eventInfo, EventTimes eventTimes,Guest guests);
    void delete(Long id);
    void addGoingUser(Long id,String username,MyActivity myActivity);
    void addInterestedUser(Long id,String username,MyActivity myActivity);

    void addComment(Long id,CommentAndReplies commentAndReplies,String username,MyActivity myActivity);
    void addRepliesToComment(Long id,Long idComment,String reply,String username,MyActivity myActivity);

}
