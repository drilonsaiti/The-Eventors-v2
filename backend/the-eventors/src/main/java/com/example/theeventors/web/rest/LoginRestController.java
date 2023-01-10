package com.example.theeventors.web.rest;

import com.example.theeventors.model.User;
import com.example.theeventors.model.exceptions.InvalidUserCredentialsException;
import com.example.theeventors.service.AuthService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin
@RequestMapping("/login")
public class LoginRestController {
    private final AuthService authService;

    public LoginRestController(AuthService authService) {
        this.authService = authService;
    }

    @PostMapping
    public ResponseEntity<User> login(HttpServletRequest request, Model model) {
    User user = this.authService.login(request.getParameter("username"),
            request.getParameter("password"));
    request.getSession().setAttribute("user",user);
    return ResponseEntity.ok(user);
    }
}
