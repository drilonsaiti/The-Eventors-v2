package com.example.theeventors.repository;

import com.example.theeventors.model.CommentAndReplies;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository

public interface CommentAndRepliesRepository extends JpaRepository<CommentAndReplies,Long> {

    void deleteAllByIdEvent(Long id);
}
