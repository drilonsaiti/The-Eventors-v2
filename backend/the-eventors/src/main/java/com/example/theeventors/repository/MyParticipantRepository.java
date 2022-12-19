package com.example.theeventors.repository;

import com.example.theeventors.model.MyParticipant;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MyParticipantRepository extends JpaRepository<MyParticipant,Long> {
}
