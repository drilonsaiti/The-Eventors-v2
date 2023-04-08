package com.example.theeventors.web.rest;

import com.example.theeventors.config.JwtService;
import com.example.theeventors.model.*;
import com.example.theeventors.model.dto.*;
import com.example.theeventors.model.enumerations.NotificationTypes;
import com.example.theeventors.model.enumerations.ReportType;
import com.example.theeventors.repository.EventRepository;
import com.example.theeventors.service.*;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.maps.errors.ApiException;
import jakarta.servlet.http.HttpServletRequest;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Comparator;
import java.util.List;

@RestController
@AllArgsConstructor
@CrossOrigin
@RequestMapping("/api/events")
public class EventRestController {
    private final EventService eventService;

    private final ActivityService activityService;

    private final NotificationInfoService notificationInfoService;
    private final CommentAndRepliesService commentAndRepliesService;

    private  final MyActivityService myActivityService;

    private final JwtService jwtService;



    @GetMapping
    public ResponseEntity<List<EventsDto>> getEvents(){
        return ResponseEntity.ok(this.eventService.findAll());
    }



    @GetMapping("/feed")
    public ResponseEntity<List<ListingEventDtoResponse>> getEventsForHomeScreen(@RequestParam String token){
        return ResponseEntity.ok(this.eventService.findAllHomeScreen(token).stream().sorted(Comparator.comparing(ListingEventDtoResponse::getAgoCreated)).toList());
    }

    @PostMapping("/all-near/{id}")
    public ResponseEntity<List<ListingEventNearDto>> getNearEvents(@PathVariable Long id,@RequestBody PositionDto address) throws IOException, InterruptedException, ApiException {

        return ResponseEntity.ok(eventService.findAllNear(id,address));
    }
    @PostMapping("/near")
    public ResponseEntity<List<ListingEventNearDto>> getAllNearEvents(@RequestBody PositionDto address) throws IOException, InterruptedException, ApiException {

        return ResponseEntity.ok(eventService.findAllNear(0L,address));
    }

    @GetMapping("/all-events/{id}")
    public ResponseEntity<List<ListingAllEventDto>> getAllEvents(@PathVariable Long id) {

        return ResponseEntity.ok(eventService.findAllEvents(id));
    }

    @PostMapping("/near-map")
    public ResponseEntity<List<NearEventForMapDto>> getAllNearEventsForMap(@RequestBody PositionDto address) throws IOException, InterruptedException, ApiException {

        return ResponseEntity.ok(eventService.findAllNearEventsForMap(address));
    }

    @GetMapping("/top")
    public ResponseEntity<List<ListingEventTopDto>> getAllTop() {

        return ResponseEntity.ok(eventService.findAllTop(0L));
    }

    @GetMapping("/all-top/{id}")
    public ResponseEntity<List<ListingEventTopDto>> getAllTopEvents(@PathVariable Long id) {

        return ResponseEntity.ok(eventService.findAllTop(id));
    }
    @GetMapping("/{id}/edit")
    public ResponseEntity<Event> showEdit(@PathVariable Long id) {
        return ResponseEntity.ok(this.eventService.findById(id));
    }

    @GetMapping("/details/{id}")
    public ResponseEntity<EventsDto> showDetails(@PathVariable Long id) {
        System.out.println("ITS CALLED");
        //this.activity.countUsers(id,token);
        return ResponseEntity.ok(this.eventService.findEventById(id));
    }


    @PostMapping
    public ResponseEntity<Event> create(@ModelAttribute EventDtoRequest eventDtoRequest, HttpServletRequest req) throws IOException, InterruptedException, ApiException {
        System.out.println("CREATE BEGIN");
       Event e = this.eventService.create(eventDtoRequest, (String) req.getSession().getAttribute("username")
                , this.activityService.create());
        return ResponseEntity.ok(e);
    }

    @GetMapping("/search")
    public ResponseEntity<List<EventForSearchDto>> getEventsSearched(){
        return ResponseEntity.ok(this.eventService.findAllForSearch());
    }

    @PostMapping("/{id}")
    public ResponseEntity<Event> update(@PathVariable Long id,@ModelAttribute EventDtoRequest eventDtoRequest, HttpServletRequest req) throws IOException, InterruptedException, ApiException {

        Event e = this.eventService.update(id,eventDtoRequest);

        return ResponseEntity.ok(e);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity.BodyBuilder delete(@PathVariable Long id,@RequestBody TokenDto token) {
        this.eventService.delete(id);
        return ResponseEntity.ok();
    }

    @PostMapping("/{id}/going")
    public ResponseEntity.BodyBuilder addGoingUser(@PathVariable Long id,@RequestBody NotificationInfoDto dto) throws FirebaseMessagingException {
        String username = jwtService.extractUsername(dto.getFrom());
        this.notificationInfoService.createGoing(id,dto,NotificationTypes.GOING);
        this.eventService.addGoingUser(id, username, this.myActivityService.findOrCreate(username));
        return ResponseEntity.ok();
    }
    @PostMapping("/{id}/interested")
    public ResponseEntity.BodyBuilder addInterestedUser(@PathVariable Long id, @RequestBody NotificationInfoDto dto) throws FirebaseMessagingException {
        String username = jwtService.extractUsername(dto.getFrom());
        this.notificationInfoService.createInterested(id,dto,NotificationTypes.INTERESTED);
        this.eventService.addInterestedUser(id, username, this.myActivityService.findOrCreate(username));
        return ResponseEntity.ok();
    }

    @PostMapping("/{id}/addComment")
    public ResponseEntity.BodyBuilder addComment(@PathVariable Long id,@RequestBody NotificationInfoDto dto) throws FirebaseMessagingException { //@RequestBody CommentRequestDto dto
        String username =  jwtService.extractUsername(dto.getFrom());

        CommentAndReplies comment = this.commentAndRepliesService.create(dto.getMessage(),username, id);
        this.notificationInfoService.createComment(id,comment.getId(),dto,NotificationTypes.COMMENT);
        this.eventService.addComment(id,comment,username,this.myActivityService.findOrCreate(username));

        return ResponseEntity.ok();

    }
    @PostMapping("/{id}/addReplies/{idComment}")
    public ResponseEntity.BodyBuilder addReply(@PathVariable Long id,@PathVariable Long idComment,@RequestBody NotificationInfoDto dto ) throws FirebaseMessagingException {
        String username =  jwtService.extractUsername(dto.getFrom());
        this.notificationInfoService.createReplies(id,idComment,dto,NotificationTypes.REPLAY);

        this.eventService.addRepliesToComment(id,idComment,dto.getMessage(),username,this.myActivityService.findOrCreate(username));
        return ResponseEntity.ok();

    }

    @PostMapping("/remove-interest")
    public ResponseEntity.BodyBuilder checkInterest(@RequestBody CheckRemoveDto check){
        this.eventService.checkRemove(check);
        return ResponseEntity.ok();
    }

}
