package com.example.theeventors.web.controller;

import com.example.theeventors.model.enumerations.Role;
import com.example.theeventors.model.exceptions.InvalidArgumentsException;
import com.example.theeventors.model.exceptions.PasswordsDoNotMatchException;
import com.example.theeventors.service.AuthService;
import com.example.theeventors.service.MyActivityService;
import com.example.theeventors.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/register")
public class RegisterController {

    private final UserService userService;

    private final MyActivityService myActivityService;

    public RegisterController( UserService userService, MyActivityService myActivityService) {
        this.userService = userService;
        this.myActivityService = myActivityService;
    }

    @GetMapping
    public String getRegisterPage(@RequestParam(required = false) String error, Model model) {
        if(error != null && !error.isEmpty()) {
            model.addAttribute("hasError", true);
            model.addAttribute("error", error);
        }
        model.addAttribute("bodyContent","register");
        return "register";
    }

    @PostMapping
    public String register(@RequestParam String username,
                           @RequestParam String password,
                           @RequestParam String repeatedPassword,
                           @RequestParam String name,
                           @RequestParam String surname,
                           @RequestParam Role role) {
        try{
            this.userService.register(username, password, repeatedPassword, name, surname, role);
            this.myActivityService.create(username);
            return "redirect:/login";
        } catch (InvalidArgumentsException | PasswordsDoNotMatchException exception) {
            return "redirect:/register?error=" + exception.getMessage();
        }
    }
}


