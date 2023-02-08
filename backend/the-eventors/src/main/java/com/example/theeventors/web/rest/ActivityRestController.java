/*
package com.example.theeventors.web.rest;

import com.example.theeventors.model.CommentAndReplies;
import com.example.theeventors.service.CommentAndRepliesService;
import com.example.theeventors.service.EventService;
import com.example.theeventors.service.MyActivityService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin
@RequestMapping("/events")
public class ActivityRestController {

    private final EventService eventService;
    private final MyActivityService myActivityService;

    private final CommentAndRepliesService commentAndRepliesService;

    public ActivityRestController(EventService eventService, MyActivityService myActivityService, CommentAndRepliesService commentAndRepliesService) {
        this.eventService = eventService;
        this.myActivityService = myActivityService;
        this.commentAndRepliesService = commentAndRepliesService;
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
*/
