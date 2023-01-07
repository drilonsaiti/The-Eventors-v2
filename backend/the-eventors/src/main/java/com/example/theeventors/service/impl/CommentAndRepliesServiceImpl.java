package com.example.theeventors.service.impl;

import com.example.theeventors.model.CommentAndReplies;
import com.example.theeventors.model.exceptions.CommentNotFoundException;
import com.example.theeventors.repository.CommentAndRepliesRepository;
import com.example.theeventors.service.CommentAndRepliesService;
import org.springframework.stereotype.Service;
import java.util.List;


@Service

public class CommentAndRepliesServiceImpl implements CommentAndRepliesService {

    private final CommentAndRepliesRepository crRepository;

    public CommentAndRepliesServiceImpl(CommentAndRepliesRepository crRepository) {
        this.crRepository = crRepository;
    }

    @Override
    public List<CommentAndReplies> findAll() {
        return this.crRepository.findAll();
    }

    @Override
    public CommentAndReplies findById(Long id) {
        return this.crRepository.findById(id).orElseThrow(() -> new CommentNotFoundException(id));
    }

    @Override
    public CommentAndReplies create(String message, String username,Long idEvent) {
        return this.crRepository.save(new CommentAndReplies(message,username,idEvent));
    }

    @Override
    public void delete(Long id) {
        this.crRepository.deleteById(id);
    }
}
