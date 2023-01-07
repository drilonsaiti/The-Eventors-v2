package com.example.theeventors.repository;

import com.example.theeventors.model.Guest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository

public interface GuestRepository extends JpaRepository<Guest,Long> {
}
