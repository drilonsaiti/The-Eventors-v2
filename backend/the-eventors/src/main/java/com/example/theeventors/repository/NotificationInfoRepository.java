package com.example.theeventors.repository;

import com.example.theeventors.model.Notification;
import com.example.theeventors.model.NotificationInfo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface NotificationInfoRepository extends JpaRepository<NotificationInfo,Long> {
}
