package com.example.theeventors.repository;

import com.example.theeventors.model.CommentAndReplies;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CommentAndRepliesRepository extends JpaRepository<CommentAndReplies,Long> {
}
