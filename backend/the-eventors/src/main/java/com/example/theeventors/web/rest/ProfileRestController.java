package com.example.theeventors.web.rest;

import com.example.theeventors.model.User;
import com.example.theeventors.service.AuthService;
import com.example.theeventors.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin
@RequestMapping("/profile")
public class ProfileRestController {

    private final AuthService userService;
    private final UserService service;

    public ProfileRestController(AuthService userService, UserService service) {
        this.userService = userService;
        this.service = service;
    }

    @GetMapping
    public ResponseEntity<User> getProfile(HttpServletRequest req, Model model){
       return ResponseEntity.ok(this.userService.findByUsername(req.getRemoteUser()));


    }

    @GetMapping("/{username}")
    public ResponseEntity<Boolean> getProfileUser(@PathVariable String username, HttpServletRequest req, Model model ){
        User user = this.userService.findByUsername(username);
        User following = this.userService.findByUsername(req.getRemoteUser());
        boolean isFollowing = following.getFollowing().stream().anyMatch(f -> f.equals(username));
        System.out.println(isFollowing);
        model.addAttribute("user",user);
        model.addAttribute("isFollowing",isFollowing);
        return "profile";
    }

    @PostMapping("/follow/{username}")
    public String makeFollow(@PathVariable String username, HttpServletRequest req, Model model ){
        String usernameFollowing = req.getRemoteUser();
        this.service.followingUser(usernameFollowing,username);
        return "redirect:/profile";
    }
    @PostMapping("/unfollow/{username}")
    public String makeUnfollow(@PathVariable String username, HttpServletRequest req, Model model ){
        String usernameFollowing = req.getRemoteUser();
        this.service.unFollowingUser(usernameFollowing,username);
        return "redirect:/profile";
    }
}
