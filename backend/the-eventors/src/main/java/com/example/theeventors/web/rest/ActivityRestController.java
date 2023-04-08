package com.example.theeventors.web.rest;

import com.example.theeventors.model.CommentAndReplies;
import com.example.theeventors.model.dto.ActivityOfEventDto;
import com.example.theeventors.service.*;
import jakarta.servlet.http.HttpServletRequest;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin
@RequestMapping("/api/activity")
@AllArgsConstructor
public class ActivityRestController {

    private final EventService eventService;
    private final MyActivityService myActivityService;

    private final ActivityPerEventsService service;

    private final CommentAndRepliesService commentAndRepliesService;

    @GetMapping("{id}")
    public ResponseEntity<ActivityOfEventDto> getActivity(@PathVariable Long id) {
        return ResponseEntity.ok(this.service.getActivity(id));
    }
    @PostMapping("/{id}/going")
    public ResponseEntity.BodyBuilder addGoingUser(@PathVariable Long id, HttpServletRequest req) {
        this.eventService.addGoingUser(id,req.getRemoteUser(),this.myActivityService.findByUsername(req.getRemoteUser()));
        return ResponseEntity.ok();
    }
    @PostMapping("/{id}/interested")
    public ResponseEntity.BodyBuilder addInterestedUser(@PathVariable Long id,HttpServletRequest req) {
        this.eventService.addInterestedUser(id,req.getRemoteUser(),this.myActivityService.findByUsername(req.getRemoteUser()));
        return ResponseEntity.ok();
    }
    @PostMapping("/{id}/addComment")
    public ResponseEntity.BodyBuilder addComment(@PathVariable Long id, @RequestParam String message, HttpServletRequest req){
        CommentAndReplies comment = this.commentAndRepliesService.create(message,req.getRemoteUser(),id);
        this.eventService.addComment(id,comment,req.getRemoteUser(),this.myActivityService.findByUsername(req.getRemoteUser()));

        return ResponseEntity.ok();

    }
    @PostMapping("/{id}/addReplies/{idComment}")
    public ResponseEntity.BodyBuilder addReply(@PathVariable Long id,@PathVariable Long idComment, @RequestParam String reply,HttpServletRequest req){
        this.eventService.addRepliesToComment(id,idComment,reply,req.getRemoteUser(),this.myActivityService.findByUsername(req.getRemoteUser()));
        return ResponseEntity.ok();

    }
}
