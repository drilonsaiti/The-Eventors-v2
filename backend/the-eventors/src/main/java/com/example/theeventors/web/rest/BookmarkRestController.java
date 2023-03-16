package com.example.theeventors.web.rest;

import com.example.theeventors.config.JwtService;
import com.example.theeventors.model.Event;
import com.example.theeventors.model.dto.MyActivityEventDto;
import com.example.theeventors.model.dto.TokenDto;
import com.example.theeventors.service.BookmarkService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin
@AllArgsConstructor
@RequestMapping("/api/bookmark")
public class BookmarkRestController {

    private final BookmarkService bookmarkService;

    private final JwtService jwtService;


    @GetMapping()
    public ResponseEntity<List<MyActivityEventDto>> getBookmark(@RequestParam String token, Model model){

        return ResponseEntity.ok(
                this.bookmarkService.listAllEventsInBookmark(this.bookmarkService.getActiveBookmark(jwtService.extractUsername(token)).getId()));

    }

    @GetMapping("check")
    public ResponseEntity<List<Long>> getEventInBookmark(@RequestParam String token, Model model){

        return ResponseEntity.ok(
                this.bookmarkService.getBookmakrs(token));

    }

    @DeleteMapping("/{id}/delete")
    public ResponseEntity deleteEventFromBookmark(@PathVariable Long id,@RequestBody TokenDto token){
        this.bookmarkService.deleteEventFromBookmark(id, token.getToken());
        return ResponseEntity.status(HttpStatus.OK).build();
    }

    @PostMapping("/add-event/{id}")
    public ResponseEntity addEventToBookmarks(@PathVariable Long id,@RequestBody TokenDto token){
        this.bookmarkService.addEventToBookmark(token.getToken(), id);
        return ResponseEntity.status(HttpStatus.CREATED).build();
    }

    @PostMapping("/check/{id}")
    public ResponseEntity checkBookmark(@PathVariable Long id,@RequestBody TokenDto token){
        this.bookmarkService.checkBookmark(token.getToken(), id);
        return ResponseEntity.status(HttpStatus.FOUND).build();
    }
}
