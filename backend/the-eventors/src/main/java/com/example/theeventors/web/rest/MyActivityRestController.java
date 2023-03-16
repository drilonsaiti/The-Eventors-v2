
package com.example.theeventors.web.rest;

import com.example.theeventors.model.Event;
import com.example.theeventors.model.MyActivity;
import com.example.theeventors.model.NotificationInfo;
import com.example.theeventors.model.dto.*;
import com.example.theeventors.repository.NotificationInfoRepository;
import com.example.theeventors.service.CommentAndRepliesService;
import com.example.theeventors.service.EventService;
import com.example.theeventors.service.MyActivityService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
@RestController
@CrossOrigin
@AllArgsConstructor
@RequestMapping("api/my-activity")
public class MyActivityRestController {
    private  final MyActivityService myActivityService;

    private final CommentAndRepliesService commService;

    private final EventService eventService;

    private final NotificationInfoRepository infoRepository;


    @GetMapping("/going")
    public ResponseEntity<List<MyActivityEventDto>> getMyGoing(@RequestParam String token){
        return ResponseEntity.ok(this.myActivityService.findAllMyGoingEvents(token));
    }
    @GetMapping("/interested")
    public ResponseEntity<List<MyActivityEventDto>> getMyInterested(@RequestParam String token){
        return ResponseEntity.ok(this.myActivityService.findAllMyInterestedEvents(token));
    }

    @GetMapping("/activity-profile")
    public ResponseEntity<List<MyActivityEventDto>> activityProfile(@RequestParam String token){
        return ResponseEntity.ok(this.myActivityService.findAllForActivityProfile(token));
    }

    @GetMapping("/activity-profile-user")
    public ResponseEntity<List<MyActivityEventDto>> activityProfileByUser(@RequestParam String username){
        return ResponseEntity.ok(this.myActivityService.findAllForActivityProfile(username));
    }

    @GetMapping("/my-events")
    public ResponseEntity<List<MyActivityEventDto>> getMyEvents(@RequestParam String token){

        return ResponseEntity.ok(this.myActivityService.findAllMyEvents(token,true));
    }

    @GetMapping("/my-events-user")
    public ResponseEntity<List<MyActivityEventDto>> getMyEventsByUser(@RequestParam String username){

        return ResponseEntity.ok(this.myActivityService.findAllMyEvents(username,false));
    }


    @GetMapping("/my-comments")
    public ResponseEntity<List<MyCommentDto>> getMyComments(@RequestParam String token){

        return ResponseEntity.ok(this.myActivityService.findAllComments(token));
    }

    @PostMapping("/check-interest")
    public ResponseEntity<String> checkInterest(@RequestBody CheckGoingInterestedDto check){
        System.out.println(this.myActivityService.checkGoing(check.getToken(),check.getId()));
        return ResponseEntity.ok(this.myActivityService.checkGoing(check.getToken(),check.getId()));
    }

    @PostMapping("/notifications")
    public ResponseEntity<List<NotificationsDto>> getNotifications(@RequestBody TokenDto token){
        return ResponseEntity.ok(this.myActivityService.getNotifications(token.getToken()));
    }

    @GetMapping("info")
    public ResponseEntity<List<NotificationInfo>> getInfo(){
        return ResponseEntity.ok(this.infoRepository.findAll().stream().sorted(Comparator.comparing(NotificationInfo::getCreateAt).reversed()).toList());

    }

    @PostMapping("/notifications/read")
    public ResponseEntity.BodyBuilder allRead(@RequestBody TokenDto token){
        this.myActivityService.doAllRead(token.getToken());
        return ResponseEntity.ok();
    }



   /* @GetMapping
    public ResponseEntity<MyActivityDto> getActivity(Model model, HttpServletRequest req){
        MyActivity activity = this.myActivityService.findByUsername(req.getRemoteUser());
        List<Event> going = new ArrayList<>();
        List<Event> interested = new ArrayList<>();
        activity.getMyGoingEvent().keySet().forEach(f -> going.add(this.eventService.findById(f)));
        activity.getMyInterestedEvent().keySet().forEach(f -> interested.add(this.eventService.findById(f)));
        List<MyCommentDto> comment = this.myActivityService.createAcivityForComments(activity.getMyComments());
        return ResponseEntity.ok(new MyActivityDto(going,interested,comment));
    }*/
}

