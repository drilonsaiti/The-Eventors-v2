package com.example.theeventors.web.rest;

import com.example.theeventors.model.Category;
import com.example.theeventors.model.Event;
import com.example.theeventors.service.HomeService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@CrossOrigin
@RequestMapping("/home")
public class HomeRestController {
    private final HomeService homeService;

    public HomeRestController(HomeService homeService) {
        this.homeService = homeService;
    }

    @GetMapping
    public ResponseEntity<List<Event>> getHome(Model model, HttpServletRequest req){
        System.out.println(req.getRemoteUser());
        return ResponseEntity.ok(this.homeService.findAll(req.getRemoteUser()));
    }
}
