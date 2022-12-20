package com.example.theeventors.service;


import com.example.theeventors.model.CommentAndReplies;
import com.example.theeventors.model.Comments;

import java.util.List;

public interface CommentsService {

    List<Comments> findAll();
    Comments findById(Long id);
    Comments create(CommentAndReplies commentAndReplies);
    void delete(Long id);
}
