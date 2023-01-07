package com.example.theeventors.service;


import com.example.theeventors.model.CommentAndReplies;

import java.util.List;

public interface CommentAndRepliesService {
    List<CommentAndReplies> findAll();
    CommentAndReplies findById(Long id);
    CommentAndReplies create(String message, String username,Long idEvent);
    void delete(Long id);
}
