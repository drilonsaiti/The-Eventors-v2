package com.example.theeventors.repository;

import com.example.theeventors.model.Bookmark;
import com.example.theeventors.model.Event;
import com.example.theeventors.model.User;
import com.example.theeventors.model.enumerations.BookmakrsStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface BookmarkRepository extends JpaRepository<Bookmark,Long> {
    Optional<Bookmark> findByUserAndStatus(User user, BookmakrsStatus status);

    List<Bookmark> findAllByEvents(Event event);
}
