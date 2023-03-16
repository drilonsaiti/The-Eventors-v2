package com.example.theeventors.service;

import com.example.theeventors.model.Bookmark;
import com.example.theeventors.model.Event;
import com.example.theeventors.model.dto.MyActivityEventDto;

import java.util.List;

public interface BookmarkService {
    List<MyActivityEventDto> listAllEventsInBookmark(Long bookmarkId);
    Bookmark getActiveBookmark(String username);
    Bookmark addEventToBookmark(String username, Long eventId);

    Bookmark deleteEventFromBookmark(Long id,String username);

    boolean checkBookmark(String token,Long id);

    List<Long> getBookmakrs(String token);


}
