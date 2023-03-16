package com.example.theeventors.service.impl;

import com.example.theeventors.config.JwtService;
import com.example.theeventors.model.Bookmark;
import com.example.theeventors.model.Event;
import com.example.theeventors.model.User;
import com.example.theeventors.model.dto.MyActivityEventDto;
import com.example.theeventors.model.enumerations.BookmakrsStatus;
import com.example.theeventors.model.exceptions.BookmarkNotFoundException;
import com.example.theeventors.model.exceptions.EventAlreadyInShoppingCartException;
import com.example.theeventors.model.exceptions.EventNotFoundException;
import com.example.theeventors.model.exceptions.UserNotFoundException;
import com.example.theeventors.repository.BookmarkRepository;
import com.example.theeventors.repository.EventRepository;
import com.example.theeventors.repository.UserRepository;
import com.example.theeventors.service.BookmarkService;
import com.example.theeventors.service.MyActivityService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class BookmarkServiceImpl implements BookmarkService {
    final static DateTimeFormatter CUSTOM_FORMATTER = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm");

    private final BookmarkRepository bookmarkRepository;
    private final UserRepository userRepository;
    private final EventRepository eventRepository;

    private final MyActivityService myActivityService;
    private final JwtService jwtService;



    @Override
    public List<MyActivityEventDto> listAllEventsInBookmark(Long bookmarkId) {
        if(this.bookmarkRepository.findById(bookmarkId).isEmpty())
            throw new BookmarkNotFoundException(bookmarkId);
        List<Event> events = this.bookmarkRepository.findById(bookmarkId).get().getEvents();
        List<MyActivityEventDto> bookmarks = new ArrayList<>();
        events.forEach(e -> bookmarks.add(new MyActivityEventDto(e.getEventInfo().getTitle(), e.getEventInfo().getCreatedBy(), myActivityService.getTimeAt(e.getEventTimes().getCreatedTime()),
                e.getEventInfo().getCoverImage().getImageBase64().replaceAll("data:application/octet-stream;base64,",""),"bookmarks",e.getEventTimes().getStartTime().format(CUSTOM_FORMATTER),e.getId())));

        return bookmarks;
    }

    @Override
    public Bookmark getActiveBookmark(String username) {
        User user = this.userRepository.findByUsername(username)
                .orElseThrow(() -> new UserNotFoundException(username));

        return this.bookmarkRepository
                .findByUserAndStatus(user, BookmakrsStatus.CREATED)
                .orElseGet(() -> {
                    Bookmark bookmark = new Bookmark(user);
                    return this.bookmarkRepository.save(bookmark);
                });

    }

    @Override
    public Bookmark addEventToBookmark(String token, Long eventId) {
        String username = jwtService.extractUsername(token);
        Bookmark bookmark = this.getActiveBookmark(username);
        Event product = this.eventRepository.findById(eventId)
                .orElseThrow(() -> new EventNotFoundException(eventId));
        if(bookmark.getEvents()
                .stream().filter(i -> i.getId().equals(eventId))
                .toList().size() > 0)
            throw new EventAlreadyInShoppingCartException(eventId, username);
        bookmark.getEvents().add(product);
        return this.bookmarkRepository.save(bookmark);

    }

    @Override
    public Bookmark deleteEventFromBookmark(Long id, String token) {
        String username = jwtService.extractUsername(token);

        Bookmark bookmark = this.getActiveBookmark(username);
        Event event = this.eventRepository.findById(id).orElseThrow(() -> new EventNotFoundException(id));
        bookmark.getEvents().remove(event);
        this.bookmarkRepository.save(bookmark);
        return bookmark;
    }

    @Override
    public boolean checkBookmark(String token, Long id) {
        String username = jwtService.extractUsername(token);
        Bookmark bookmark = this.getActiveBookmark(username);
        Event event = this.eventRepository.findById(id).orElseThrow(() -> new EventNotFoundException(id));

        return bookmark.getEvents().contains(event);
    }

    @Override
    public List<Long> getBookmakrs(String token) {
        Long id = this.getActiveBookmark(jwtService.extractUsername(token)).getId();
        if(this.bookmarkRepository.findById(id).isEmpty())
            throw new BookmarkNotFoundException(id);
        List<Event> events = this.bookmarkRepository.findById(id).get().getEvents();
        List<Long> bookmarks = new ArrayList<>();
        events.forEach(e -> bookmarks.add(e.getId()));
        return bookmarks;
    }
}
