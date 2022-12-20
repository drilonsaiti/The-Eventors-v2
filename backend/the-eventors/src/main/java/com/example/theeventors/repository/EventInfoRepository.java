package com.example.theeventors.repository;

import com.example.theeventors.model.EventInfo;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EventInfoRepository extends JpaRepository<EventInfo,Long> {
}
