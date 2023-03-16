package com.example.theeventors.web.rest;

import com.example.theeventors.model.dto.CommentResponseDto;
import com.example.theeventors.service.CommentsService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@AllArgsConstructor
@CrossOrigin
@RequestMapping("/api/comment")
public class CommentRestController {

    private final CommentsService commentsService;
    @GetMapping("/{idEvent}")
    public ResponseEntity<List<CommentResponseDto>> getCommentsByEventId(@PathVariable Long idEvent){
        return ResponseEntity.ok(commentsService.getCommentByEvent(idEvent));
    }
}
