package com.example.theeventors.web.controller;


import com.example.theeventors.model.Event;
import com.example.theeventors.model.MyActivity;
import com.example.theeventors.model.dto.MyCommentDto;
import com.example.theeventors.service.CommentAndRepliesService;
import com.example.theeventors.service.EventService;
import com.example.theeventors.service.MyActivityService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.ArrayList;
import java.util.List;

@Controller
public class MyActivityController {
    private  final MyActivityService myActivityService;

    private final CommentAndRepliesService commService;

    private final EventService eventService;
    public MyActivityController(MyActivityService myActivityService, CommentAndRepliesService commService, EventService eventService) {
        this.myActivityService = myActivityService;
        this.commService = commService;
        this.eventService = eventService;
    }

    @GetMapping("my-activity")
    public String getActivity(Model model, HttpServletRequest req){
        MyActivity activity = this.myActivityService.findByUsername(req.getRemoteUser());
        List<Event> going = new ArrayList<>();
        List<Event> interested = new ArrayList<>();
        System.out.println("ACTIVITY : " + activity);
        activity.getMyGoingEvent().keySet().forEach(f -> going.add(this.eventService.findById(f)));
        model.addAttribute("going",going);
        activity.getMyInterestedEvent().keySet().forEach(f -> interested.add(this.eventService.findById(f)));
        List<MyCommentDto> comment = this.myActivityService.createAcivityForComments(activity.getMyComments());

        model.addAttribute("interested",interested);
        model.addAttribute("comments",comment);

        return "my-activity";
    }
}
