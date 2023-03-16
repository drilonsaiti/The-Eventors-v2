package com.example.theeventors.repository;

import com.example.theeventors.model.Notification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface NotificationRepository extends JpaRepository<Notification,Long> {

    Notification findByUsername(String username);
}
