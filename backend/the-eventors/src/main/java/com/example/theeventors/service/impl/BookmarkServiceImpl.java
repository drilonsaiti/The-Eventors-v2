package com.example.theeventors.service.impl;

import com.example.theeventors.model.Bookmark;
import com.example.theeventors.model.Event;
import com.example.theeventors.model.User;
import com.example.theeventors.model.enumerations.BookmakrsStatus;
import com.example.theeventors.model.exceptions.BookmarkNotFoundException;
import com.example.theeventors.model.exceptions.EventAlreadyInShoppingCartException;
import com.example.theeventors.model.exceptions.EventNotFoundException;
import com.example.theeventors.model.exceptions.UserNotFoundException;
import com.example.theeventors.repository.BookmarkRepository;
import com.example.theeventors.repository.EventRepository;
import com.example.theeventors.repository.UserRepository;
import com.example.theeventors.service.BookmarkService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class BookmarkServiceImpl implements BookmarkService {

    private final BookmarkRepository bookmarkRepository;
    private final UserRepository userRepository;
    private final EventRepository eventRepository;

    public BookmarkServiceImpl(BookmarkRepository bookmarkRepository, UserRepository userRepository, EventRepository eventRepository) {
        this.bookmarkRepository = bookmarkRepository;
        this.userRepository = userRepository;
        this.eventRepository = eventRepository;
    }

    @Override
    public List<Event> listAllEventsInBookmark(Long bookmarkId) {
        if(this.bookmarkRepository.findById(bookmarkId).isEmpty())
            throw new BookmarkNotFoundException(bookmarkId);
        return this.bookmarkRepository.findById(bookmarkId).get().getEvents();

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
    public Bookmark addEventToBookmark(String username, Long eventId) {
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
    public Bookmark deleteEventFromBookmark(Long id, String username) {
        Bookmark bookmark = this.getActiveBookmark(username);
        Event event = this.eventRepository.findById(id).orElseThrow(() -> new EventNotFoundException(id));
        bookmark.getEvents().remove(event);
        this.bookmarkRepository.save(bookmark);
        return bookmark;
    }
}
