package com.example.theeventors.service.impl;

import com.example.theeventors.model.CommentAndReplies;
import com.example.theeventors.model.Comments;
import com.example.theeventors.repository.CommentsRepository;
import com.example.theeventors.service.CommentsService;

import java.util.List;

public class CommentsServiceImpl implements CommentsService {


    private final CommentsRepository commentsRepository;

    public CommentsServiceImpl(CommentsRepository commentsRepository) {
        this.commentsRepository = commentsRepository;
    }

    @Override
    public List<Comments> findAll() {
        return this.commentsRepository.findAll();
    }

    @Override
    public Comments findById(Long id) {
        return this.commentsRepository.findById(id).orElseThrow();
    }

    @Override
    public Comments create(CommentAndReplies commentAndReplies) {
        return this.commentsRepository.save(new Comments(commentAndReplies));
    }

    @Override
    public void delete(Long id) {
        this.commentsRepository.deleteById(id);
    }
}
