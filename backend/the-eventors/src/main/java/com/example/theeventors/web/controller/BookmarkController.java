package com.example.theeventors.web.controller;

import com.example.theeventors.service.BookmarkService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class BookmarkController {

    private final BookmarkService bookmarkService;

    public BookmarkController(BookmarkService bookmarkService) {
        this.bookmarkService = bookmarkService;
    }

    @GetMapping("bookmark")
    public String getBookmark(HttpServletRequest req, Model model){
        model.addAttribute("bookmarks",
                this.bookmarkService.listAllEventsInBookmark(this.bookmarkService.getActiveBookmark(req.getRemoteUser()).getId()));

        return "bookmark";
    }

    @DeleteMapping("/bookmark/{id}/delete")
    public String deleteEventFromBookmark(@PathVariable Long id,HttpServletRequest req){
        this.bookmarkService.deleteEventFromBookmark(id,req.getRemoteUser());
        return "redirect:/bookmark";
    }

    @PostMapping("bookmark/add-event/{id}")
    public String addEventToBookmarks(@PathVariable Long id,HttpServletRequest req){
        this.bookmarkService.addEventToBookmark(req.getRemoteUser(),id);
        return "redirect:/events";
    }
}
