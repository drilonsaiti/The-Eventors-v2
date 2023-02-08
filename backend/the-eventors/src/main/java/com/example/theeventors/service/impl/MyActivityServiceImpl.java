package com.example.theeventors.service.impl;

import com.example.theeventors.model.CommentAndReplies;
import com.example.theeventors.model.Event;
import com.example.theeventors.model.MyActivity;
import com.example.theeventors.model.dto.MyCommentDto;
import com.example.theeventors.model.exceptions.ActivityNotFoundException;
import com.example.theeventors.model.exceptions.CommentNotFoundException;
import com.example.theeventors.model.exceptions.EventNotFoundException;
import com.example.theeventors.repository.CommentAndRepliesRepository;
import com.example.theeventors.repository.EventRepository;
import com.example.theeventors.repository.MyActivityRepository;
import com.example.theeventors.service.MyActivityService;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class MyActivityServiceImpl implements MyActivityService {

    private final MyActivityRepository myActivityRepository;
    private final EventRepository eventRepository;
    private final CommentAndRepliesRepository commRepository;

    public MyActivityServiceImpl(MyActivityRepository myActivityRepository, EventRepository eventRepository, CommentAndRepliesRepository commRepository) {
        this.myActivityRepository = myActivityRepository;
        this.eventRepository = eventRepository;
        this.commRepository = commRepository;
    }

    @Override
    public List<MyActivity> findAll() {
        return this.myActivityRepository.findAll();
    }

    @Override
    public MyActivity findById(Long id) {
        return this.myActivityRepository.findById(id).orElseThrow(() -> new ActivityNotFoundException(id));
    }

    @Override
    public MyActivity findByUsername(String username) {
        return this.myActivityRepository.findByUsername(username);
    }

    @Override
    public MyActivity create(String username) {
        return this.myActivityRepository.save(new MyActivity(username));
    }

    @Override
    public MyActivity findOrCreate(String username) {
        if (this.myActivityRepository.findByUsername(username) != null){
            return this.myActivityRepository.findByUsername(username);
        }else{
            return this.create(username);
        }
    }

    @Override
    public void delete(Long id) {
        this.myActivityRepository.deleteById(id);
    }

    @Override
    public List<MyCommentDto> createAcivityForComments(Map<Long,Long> comments) {
        List<MyCommentDto> list = new ArrayList<>();
        if (comments.size() != 0) {
            for (Map.Entry<Long, Long> s : comments.entrySet()) {
                CommentAndReplies c = this.commRepository.findById(s.getKey()).orElseThrow(() -> new CommentNotFoundException(s.getKey()));
                Event event = this.eventRepository.findById(c.getIdEvent()).orElseThrow(() -> new EventNotFoundException(c.getIdEvent()));
                list.add(new MyCommentDto(c.getMessage(), c.getCreatedAt(), c.getUsername(), c.getIdEvent(), event.getEventInfo().getCreatedBy(), event.getEventInfo().getTitle(), event.getEventTimes().getCreatedTime()));
            }
        }
        return list;
    }
}
