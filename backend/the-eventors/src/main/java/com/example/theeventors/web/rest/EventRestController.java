package com.example.theeventors.web.rest;

import com.example.theeventors.model.*;
import com.example.theeventors.model.enumerations.ReportType;
import com.example.theeventors.repository.EventRepository;
import com.example.theeventors.service.*;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

@RestController
@CrossOrigin
@RequestMapping("/events")
public class EventRestController {
    private final EventService eventService;
    private final EventInfoService eventInfoService;
    private final EventTimesService eventTimesService;
    private final GuestService guestService;
    private final ActivityService activityService;

    private final ActivityPerEventsService activity;

    public EventRestController(EventService eventService, EventInfoService eventInfoService, EventTimesService eventTimesService, GuestService guestService, ActivityService activityService,  ActivityPerEventsService activity) {
        this.eventService = eventService;
        this.eventInfoService = eventInfoService;
        this.eventTimesService = eventTimesService;
        this.guestService = guestService;
        this.activityService = activityService;
        this.activity = activity;

    }

    @GetMapping
    public ResponseEntity<List<Event>> getEvents(){
        return ResponseEntity.ok(this.eventService.findAll());
    }
    @GetMapping("/{id}/edit")
    @PreAuthorize("hasRole('ROLE_ADMIN')")

    public ResponseEntity<Event> showEdit(@PathVariable Long id, Model model) {
        return ResponseEntity.ok(this.eventService.findById(id));
    }

    @GetMapping("/{id}/details")
    public ResponseEntity<Event> showDetails(@PathVariable Long id, Model model, HttpServletRequest req) {
        this.activity.countUsers(id,req);
        return ResponseEntity.ok(this.eventService.findById(id));
    }


    @PostMapping
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity.BodyBuilder create(@RequestParam String title, @RequestParam String description, @RequestParam String location,
                                             @RequestParam MultipartFile coverImage, @RequestParam MultipartFile [] images,
                                             @RequestParam String guests, @RequestParam LocalDateTime startDateTime,
                                             @RequestParam String duration, @RequestParam Long category, HttpServletRequest req) throws IOException {
        this.eventService.create(category,this.eventInfoService.create(title,description,location,coverImage,images,req.getRemoteUser())
                ,this.eventTimesService.create(startDateTime,duration)
                ,this.guestService.create(guests), this.activityService.create());
        return ResponseEntity.ok();
    }

    @PostMapping("/{id}")
    @PreAuthorize("hasRole('ROLE_ADMIN')")

    public ResponseEntity.BodyBuilder update(@PathVariable Long id, @RequestParam String title, @RequestParam String description,@RequestParam String location,
                         @RequestParam MultipartFile coverImage,@RequestParam LocalDateTime startDateTime,
                         @RequestParam MultipartFile [] images,@RequestParam String guests,
                         @RequestParam String duration,@RequestParam Long category,HttpServletRequest req) throws IOException {

        EventInfo eventInfo = this.eventService.findById(id).getEventInfo();
        eventInfo = this.eventInfoService.update(eventInfo.getId(),title,description,location,coverImage,images,req.getRemoteUser());
        EventTimes eventTimes = this.eventService.findById(id).getEventTimes();
        eventTimes = this.eventTimesService.update(eventTimes.getId(),startDateTime,duration);
        Guest guest = this.eventService.findById(id).getGuests();
        guest = this.guestService.update(guest.getId(),guests);
        this.eventService.update(id, category,eventInfo,eventTimes,guest);
        return ResponseEntity.ok();
    }
    @DeleteMapping("/{id}")
    public ResponseEntity.BodyBuilder delete(@PathVariable Long id) {
        this.eventService.delete(id);
        return ResponseEntity.ok();
    }


}
