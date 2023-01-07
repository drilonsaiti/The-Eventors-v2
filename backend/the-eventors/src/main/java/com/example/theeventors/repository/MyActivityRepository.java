package com.example.theeventors.repository;

import com.example.theeventors.model.MyActivity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository

public interface MyActivityRepository extends JpaRepository<MyActivity,Long> {
    MyActivity findByUsername(String username);

    @Query(value = "SELECT p.my_activity_id FROM public.my_activity_my_going_event as p",nativeQuery = true)
    Long find();
}
