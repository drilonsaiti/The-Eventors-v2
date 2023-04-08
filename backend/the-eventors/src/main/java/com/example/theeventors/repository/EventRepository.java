package com.example.theeventors.repository;

import com.example.theeventors.model.Event;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface EventRepository extends JpaRepository<Event,Long> {
    List<Event> findAllByEventInfo_CreatedBy(String username);
}
