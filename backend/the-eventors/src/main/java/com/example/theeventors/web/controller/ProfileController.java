/*
package com.example.theeventors.web.controller;

import com.example.theeventors.model.User;
import com.example.theeventors.service.AuthService;
import com.example.theeventors.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class ProfileController {
    private final AuthService userService;
    private final UserService service;

    public ProfileController(AuthService userService, UserService service) {
        this.userService = userService;
        this.service = service;
    }

    @GetMapping("/profile")
    public String getProfile(HttpServletRequest req, Model model){
        String username = req.getRemoteUser();
        System.out.println(username);
        User user = this.userService.findByUsername(username);

        model.addAttribute("user",user);

        return "profile";
    }

    @GetMapping("/profile/{username}")
    public String getProfileUser(@PathVariable String username, HttpServletRequest req, Model model ){
        User user = this.userService.findByUsername(username);
        User following = this.userService.findByUsername(req.getRemoteUser());
        boolean isFollowing = following.getFollowing().stream().anyMatch(f -> f.equals(username));
        System.out.println(isFollowing);
        model.addAttribute("user",user);
        model.addAttribute("isFollowing",isFollowing);
        return "profile";
    }

    @PostMapping("/profile/follow/{username}")
    public String makeFollow(@PathVariable String username, HttpServletRequest req, Model model ){
        String usernameFollowing = req.getRemoteUser();
        this.service.followingUser(usernameFollowing,username);
        return "redirect:/profile";
    }
    @PostMapping("/profile/unfollow/{username}")
    public String makeUnfollow(@PathVariable String username, HttpServletRequest req, Model model ){
        String usernameFollowing = req.getRemoteUser();
        this.service.unFollowingUser(usernameFollowing,username);
        return "redirect:/profile";
    }
   */
/* @GetMapping("/profile/settings")
    public String getSettings(HttpServletRequest req,Model model){
        String username = req.getRemoteUser();

        Optional<User> user = this.userService.findByUsername(username);

        model.addAttribute("user",user);

        model.addAttribute("title","Settings");
        model.addAttribute("bodyContent","settings");

        return "master-template";

    }

    @PostMapping("/profile/{username}")
    public String update(@PathVariable String username,
                         @RequestParam String usernameOfUser,
                         @RequestParam String nameOfUser,
                         @RequestParam String surnameOfUser,
                         @RequestParam String emailOfUser){
        this.userService.update(username,usernameOfUser, nameOfUser, surnameOfUser, emailOfUser);
        return "redirect:/profile";

    }

    @PostMapping("/user/delete/{username}")
    public String delete(@PathVariable String username){
        this.userService.delete(username);
        return "redirect:/home";
    }*//*

}
*/
