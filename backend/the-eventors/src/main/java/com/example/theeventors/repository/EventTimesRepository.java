package com.example.theeventors.repository;

import com.example.theeventors.model.EventTimes;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository

public interface EventTimesRepository extends JpaRepository<EventTimes,Long> {
}
