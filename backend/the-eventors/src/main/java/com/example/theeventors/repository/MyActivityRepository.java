package com.example.theeventors.repository;

import com.example.theeventors.model.MyActivity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository

public interface MyActivityRepository extends JpaRepository<MyActivity,Long> {
    MyActivity findByUsername(String username);


    @Query(value = "SELECT p.my_activity_id FROM public.my_activity_my_comments as p",nativeQuery = true)
    List<Long> find();
}
