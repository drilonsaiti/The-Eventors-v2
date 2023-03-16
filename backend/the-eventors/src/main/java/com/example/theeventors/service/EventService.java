package com.example.theeventors.service;

import com.example.theeventors.model.*;
import com.example.theeventors.model.dto.*;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.maps.errors.ApiException;


import java.io.IOException;
import java.util.List;

public interface EventService {

    List<EventsDto> findAll();
    Event findById(Long id);
    EventsDto findEventById(Long id);
    Event create(EventDtoRequest eventDtoRequest,String username, Activity activity) throws IOException, InterruptedException, ApiException;

    Event update(Long id,EventDtoRequest eventDtoRequest) throws IOException, InterruptedException, ApiException;
    void delete(Long id);
    void addGoingUser(Long id,String username,MyActivity myActivity) ;
    void addInterestedUser(Long id,String username,MyActivity myActivity);
    void checkRemove(CheckRemoveDto dto);
    List<ListingEventDtoResponse> findAllHomeScreen(String username);
    void addComment(Long id,CommentAndReplies commentAndReplies,String username,MyActivity myActivity);
    void addRepliesToComment(Long id,Long idComment,String reply,String username,MyActivity myActivity);

    List<EventForSearchDto> findAllForSearch();
    List<ListingEventNearDto> findAllNear(Long id,PositionDto address) throws IOException, InterruptedException, ApiException;
    List<NearEventForMapDto> findAllNearEventsForMap(PositionDto address)throws IOException, InterruptedException, ApiException;
    List<ListingEventTopDto> findAllTop(Long id);
    List<ListingAllEventDto> findAllEvents(Long id);
}
