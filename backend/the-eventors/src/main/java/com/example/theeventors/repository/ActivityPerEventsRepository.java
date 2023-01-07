package com.example.theeventors.repository;

import com.example.theeventors.model.ActivityPerEvents;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ActivityPerEventsRepository extends JpaRepository<ActivityPerEvents,Long> {
}
