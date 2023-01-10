package com.example.theeventors.web.rest;

import com.example.theeventors.model.Event;
import com.example.theeventors.model.MyActivity;
import com.example.theeventors.model.dto.MyActivityDto;
import com.example.theeventors.model.dto.MyCommentDto;
import com.example.theeventors.service.CommentAndRepliesService;
import com.example.theeventors.service.EventService;
import com.example.theeventors.service.MyActivityService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;
@RestController
@CrossOrigin
@RequestMapping("my-activity")
public class MyActivityRestController {
    private  final MyActivityService myActivityService;

    private final CommentAndRepliesService commService;

    private final EventService eventService;
    public MyActivityRestController(MyActivityService myActivityService, CommentAndRepliesService commService, EventService eventService) {
        this.myActivityService = myActivityService;
        this.commService = commService;
        this.eventService = eventService;
    }

    @GetMapping
    public ResponseEntity<MyActivityDto> getActivity(Model model, HttpServletRequest req){
        MyActivity activity = this.myActivityService.findByUsername(req.getRemoteUser());
        List<Event> going = new ArrayList<>();
        List<Event> interested = new ArrayList<>();
        activity.getMyGoingEvent().keySet().forEach(f -> going.add(this.eventService.findById(f)));
        activity.getMyInterestedEvent().keySet().forEach(f -> interested.add(this.eventService.findById(f)));
        List<MyCommentDto> comment = this.myActivityService.createAcivityForComments(activity.getMyComments());
        return ResponseEntity.ok(new MyActivityDto(going,interested,comment));
    }
}
