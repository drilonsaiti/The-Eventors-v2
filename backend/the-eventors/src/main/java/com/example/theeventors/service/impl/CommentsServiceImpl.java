package com.example.theeventors.service.impl;

import com.example.theeventors.model.CommentAndReplies;
import com.example.theeventors.model.Comments;
import com.example.theeventors.model.exceptions.CommentNotFoundException;
import com.example.theeventors.repository.CommentsRepository;
import com.example.theeventors.service.CommentsService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
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
        return this.commentsRepository.findById(id).orElseThrow(() -> new CommentNotFoundException(id));
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
