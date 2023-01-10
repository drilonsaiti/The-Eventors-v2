/*
package com.example.theeventors.web.controller;

import com.example.theeventors.model.*;
import com.example.theeventors.model.enumerations.ReportType;
import com.example.theeventors.repository.EventRepository;
import com.example.theeventors.service.*;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.LocalDateTime;

@Controller
public class EventController {

    private final EventService eventService;
    private final EventInfoService eventInfoService;
    private final EventTimesService eventTimesService;
    private final GuestService guestService;
    private final ActivityService activityService;
    private final CommentAndRepliesService commentAndRepliesService;

    private final ActivityPerEventsService activity;

    private final MyActivityService myActivityService;

    private final CategoryService categoryService;
    private final EventRepository eventRepository;


    public EventController(EventService eventService, EventInfoService eventInfoService, EventTimesService eventTimesService, GuestService guestService, ActivityService activityService, CommentAndRepliesService commentAndRepliesService, ActivityPerEventsService activity, MyActivityService myActivityService, CategoryService categoryService,
                           EventRepository eventRepository) {
        this.eventService = eventService;
        this.eventInfoService = eventInfoService;
        this.eventTimesService = eventTimesService;
        this.guestService = guestService;
        this.activityService = activityService;
        this.commentAndRepliesService = commentAndRepliesService;
        this.activity = activity;
        this.myActivityService = myActivityService;
        this.categoryService = categoryService;
        this.eventRepository = eventRepository;
    }

    @GetMapping("events")
    public String getEvents(Model model) {
        model.addAttribute("events",this.eventService.findAll());
        return "events";
    }

    @GetMapping("events/add")
    @PreAuthorize("hasRole('ROLE_ADMIN')")

    public String showAdd(Model model) {
        model.addAttribute("categories",this.categoryService.findAll());
        return "add-event";
    }

    @GetMapping("events/{id}/edit")
    @PreAuthorize("hasRole('ROLE_ADMIN')")

    public String showEdit(@PathVariable Long id, Model model) {
        Event event = this.eventService.findById(id);
        model.addAttribute("event",event);
        return "add-event";
    }

    @GetMapping("events/{id}/details")
    public String showDetails(@PathVariable Long id, Model model, HttpServletRequest req) {
        Event event = this.eventService.findById(id);
        this.activity.countUsers(id,req);
        model.addAttribute("event",event);
        model.addAttribute("reportsType", ReportType.values());
        model.addAttribute("imgList",event.getEventInfo().getImages());
        return "details-event";
    }


    @PostMapping("events")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String create(@RequestParam String title, @RequestParam String description, @RequestParam String location,@RequestParam MultipartFile coverImage,
                         @RequestParam MultipartFile [] images, @RequestParam String guests,@RequestParam LocalDateTime startDateTime,
                         @RequestParam String duration, @RequestParam Long category, HttpServletRequest req) throws IOException {
        EventInfo eventInfo = this.eventInfoService.create(title,description,location,coverImage,images,req.getRemoteUser());
        EventTimes eventTimes = this.eventTimesService.create(startDateTime,duration);
        Activity activity = this.activityService.create();
        Guest guest = this.guestService.create(guests);
        this.eventService.create(category,eventInfo,eventTimes,guest, activity);
        return "redirect:/events";
    }

    @PostMapping("events/{id}")
    @PreAuthorize("hasRole('ROLE_ADMIN')")

    public String update(@PathVariable Long id, @RequestParam String title, @RequestParam String description,@RequestParam String location,
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
        return "redirect:/events";
    }
    @PostMapping("events/{id}/delete")
    public String delete(@PathVariable Long id) {
        this.eventService.delete(id);
        return "redirect:/events";
    }

    @PostMapping("events/{id}/going")
    public String addGoingUser(@PathVariable Long id,HttpServletRequest req) {
        this.eventService.addGoingUser(id,req.getRemoteUser(),this.myActivityService.findByUsername(req.getRemoteUser()));
        return "redirect:/events/"+id+"/details";
    }
    @PostMapping("events/{id}/interested")
    public String addInterestedUser(@PathVariable Long id,HttpServletRequest req) {
        this.eventService.addInterestedUser(id,req.getRemoteUser(),this.myActivityService.findByUsername(req.getRemoteUser()));
        return "redirect:/events/"+id+"/details";
    }

    @PostMapping("events/{id}/addComment")
    public String addComment(@PathVariable Long id,@RequestParam String message,HttpServletRequest req){
        CommentAndReplies comment = this.commentAndRepliesService.create(message,req.getRemoteUser(),id);
        this.eventService.addComment(id,comment,req.getRemoteUser(),this.myActivityService.findByUsername(req.getRemoteUser()));

        return "redirect:/events/"+id+"/details";

    }

    @PostMapping("events/{id}/addReplies/{idComment}")
    public String addReply(@PathVariable Long id,@PathVariable Long idComment, @RequestParam String reply,HttpServletRequest req){
        this.eventService.addRepliesToComment(id,idComment,reply,req.getRemoteUser(),this.myActivityService.findByUsername(req.getRemoteUser()));
        return "redirect:/events/"+id+"/details";

    }
}
*/
