/*
package com.example.theeventors.web.rest;

import com.example.theeventors.model.Event;
import com.example.theeventors.service.BookmarkService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin
@RequestMapping("/bookmark")
public class BookmarkRestController {

    private final BookmarkService bookmarkService;

    public BookmarkRestController(BookmarkService bookmarkService) {
        this.bookmarkService = bookmarkService;
    }

    @GetMapping("bookmark")
    public ResponseEntity<List<Event>> getBookmark(HttpServletRequest req, Model model){

        return ResponseEntity.ok(
                this.bookmarkService.listAllEventsInBookmark(this.bookmarkService.getActiveBookmark(req.getRemoteUser()).getId()));

    }

    @DeleteMapping("/bookmark/{id}/delete")
    public ResponseEntity deleteEventFromBookmark(@PathVariable Long id,HttpServletRequest req){
        this.bookmarkService.deleteEventFromBookmark(id,req.getRemoteUser());
        return ResponseEntity.status(HttpStatus.OK).build();
    }

    @PostMapping("bookmark/add-event/{id}")
    public ResponseEntity addEventToBookmarks(@PathVariable Long id,HttpServletRequest req){
        this.bookmarkService.addEventToBookmark(req.getRemoteUser(),id);
        return ResponseEntity.status(HttpStatus.CREATED).build();
    }
}
*/
