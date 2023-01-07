package com.example.theeventors.repository;

import com.example.theeventors.model.Comments;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository

public interface CommentsRepository extends JpaRepository<Comments,Long> {
}
