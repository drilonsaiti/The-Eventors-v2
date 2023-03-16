package com.example.theeventors.service.impl;

import com.example.theeventors.model.CommentAndReplies;
import com.example.theeventors.model.Comments;
import com.example.theeventors.model.Event;
import com.example.theeventors.model.User;
import com.example.theeventors.model.dto.CommentResponseDto;
import com.example.theeventors.model.exceptions.CommentNotFoundException;
import com.example.theeventors.model.exceptions.EventNotFoundException;
import com.example.theeventors.repository.CommentsRepository;
import com.example.theeventors.repository.EventRepository;
import com.example.theeventors.repository.UserRepository;
import com.example.theeventors.service.CommentsService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@AllArgsConstructor
public class CommentsServiceImpl implements CommentsService {


    private final CommentsRepository commentsRepository;

    private final EventRepository eventRepository;

    private final UserRepository userRepository;

    @Override
    public List<Comments> findAll() {
        return this.commentsRepository.findAll();
    }

    @Override
    public Comments findById(Long id) {
        return this.commentsRepository.findById(id).orElseThrow(() -> new CommentNotFoundException(id));
    }

    @Override
    public List<CommentResponseDto> getCommentByEvent(Long id) {
        Event event = this.eventRepository.findById(id).orElseThrow(() -> new EventNotFoundException(id));
        return event.getComments().stream()
                .map(c -> {
                    User u = this.userRepository.findByUsername(c.getComment().getUsername()).get();
                   return new CommentResponseDto(c.getId(), c.getComment().getMessage(),
                        c.getComment().getCreatedAt(), c.getComment().getUsername(),
                        u.getProfileImage() != null ? u.getProfileImage().getImageBase64().replaceAll("data:application/octet-stream;base64,"
                                ,"") : ""
                        ,c.getComment().getIdEvent(),
                        c.getReplies().stream()
                                .map(r -> {
                                    User ur = this.userRepository.findByUsername(r.getUsername()).get();

                                  return  new CommentResponseDto(r.getId(), r.getMessage(),
                                        r.getCreatedAt(), r.getUsername(),ur.getProfileImage() != null ? ur.getProfileImage().getImageBase64().replaceAll("data:application/octet-stream;base64,"
                                            ,"") : "", r.getIdEvent());})
                                .toList());})
                .toList();
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
