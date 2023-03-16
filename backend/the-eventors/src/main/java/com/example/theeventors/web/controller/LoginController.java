
package com.example.theeventors.web.controller;

import com.example.theeventors.config.auth.AuthenticationRequest;
import com.example.theeventors.config.auth.AuthenticationResponse;
import com.example.theeventors.config.auth.AuthenticationService;
import com.example.theeventors.model.User;
import com.example.theeventors.model.exceptions.InvalidUserCredentialsException;
import com.example.theeventors.service.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/logined")
@AllArgsConstructor
public class LoginController {

    private final AuthService authService;
    private final AuthenticationService service;

    @GetMapping
    public String getLoginPage(Model model) {
        return "login";
    }

    @PostMapping
    public String login(HttpServletRequest request, Model model) {
        System.out.println(request.getParameter("username") + " " +
                request.getParameter("password"));
        request.getSession().setAttribute("username",request.getParameter("username"));
        try{

           AuthenticationResponse user = this.service.authenticate(new AuthenticationRequest(request.getParameter("username"),
                   request.getParameter("password")));
            System.out.println(user.getToken());
            request.getSession().setAttribute("user", user.getToken());
            return "redirect:/dashboard";
        }
        catch (InvalidUserCredentialsException | ServletException exception) {
            model.addAttribute("hasError", true);
            model.addAttribute("error", exception.getMessage());
            return "login";
        }
    }
}


