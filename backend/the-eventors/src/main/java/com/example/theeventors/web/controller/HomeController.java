package com.example.theeventors.web.controller;

import com.example.theeventors.service.HomeService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    private final HomeService homeService;

    public HomeController(HomeService homeService) {
        this.homeService = homeService;
    }

    @GetMapping("/home")
    public String getHome(Model model, HttpServletRequest req){
        model.addAttribute("events",this.homeService.findAll(req.getRemoteUser()));
        return "home";
    }
}
