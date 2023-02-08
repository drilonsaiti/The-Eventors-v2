package com.example.theeventors.service;

import com.example.theeventors.model.Bookmark;
import com.example.theeventors.model.Event;

import java.util.List;

public interface BookmarkService {
    List<Event> listAllEventsInBookmark(Long bookmarkId);
    Bookmark getActiveBookmark(String username);
    Bookmark addEventToBookmark(String username, Long eventId);

    Bookmark deleteEventFromBookmark(Long id,String username);

}
