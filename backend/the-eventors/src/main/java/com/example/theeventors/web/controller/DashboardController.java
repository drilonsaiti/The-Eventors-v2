package com.example.theeventors.web.controller;


import com.example.theeventors.config.JwtService;
import com.example.theeventors.config.auth.AuthenticationService;
import com.example.theeventors.config.auth.RegisterRequest;
import com.example.theeventors.model.Category;
import com.example.theeventors.model.Event;
import com.example.theeventors.model.User;
import com.example.theeventors.model.enumerations.Role;
import com.example.theeventors.model.exceptions.InvalidArgumentsException;
import com.example.theeventors.model.exceptions.PasswordsDoNotMatchException;
import com.example.theeventors.repository.UserRepository;
import com.example.theeventors.service.*;
import jakarta.servlet.http.HttpServletRequest;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import java.util.concurrent.atomic.AtomicInteger;

@Controller
@RequestMapping("/dashboard")
@AllArgsConstructor

public class DashboardController {

    private final EventService eventService;
    private final JwtService jwtService;
    private final UserRepository userService;

    private final ReportService reportService;
    private final AuthenticationService service;

    private final MyActivityService myActivityService;
    private final CategoryService categoryService;


    @GetMapping
    public String getDashboard(HttpServletRequest req, Model model){
        System.out.println(req.getSession().getAttribute("user"));
        System.out.println(req.getParameter("username"));
        AtomicInteger sports = new AtomicInteger();
        AtomicInteger music = new AtomicInteger();
        AtomicInteger arts = new AtomicInteger();
        AtomicInteger speech = new AtomicInteger();
        AtomicInteger conference = new AtomicInteger();
        AtomicInteger seminar = new AtomicInteger();
        if (req.getSession().getAttribute("username") != null) {
            String username = req.getSession().getAttribute("username").toString();
            User u = this.userService.findByUsername(username).orElseThrow();
            if(u.getRole().equals(Role.ROLE_USER) || u.getRole().equals(Role.ROLE_EDITOR)) {
                this.eventService.findAll().forEach(e -> {
                    if (Objects.equals(e.category(), "Sports")) sports.getAndIncrement();
                    if (Objects.equals(e.category(), "Music")) music.getAndIncrement();
                    if (Objects.equals(e.category(), "Speech")) speech.getAndIncrement();
                    if (Objects.equals(e.category(), "Seminar")) seminar.getAndIncrement();
                    if (Objects.equals(e.category(), "Conference")) conference.getAndIncrement();
                    if (Objects.equals(e.category(), "Arts")) arts.getAndIncrement();
                });
                Map<String, Integer> map = new HashMap<>();
                map.put("Sports", sports.get());
                map.put("Music", music.get());
                map.put("Speech", speech.get());
                map.put("Seminar", seminar.get());
                map.put("Conference", conference.get());
                map.put("Arts", arts.get());
                model.addAttribute("categories", map);
                model.addAttribute("eventsSize", this.eventService.findAll().size());
                model.addAttribute("events", this.eventService.findAll().stream().limit(10).toList());
                model.addAttribute("username", u.getUsername());
                model.addAttribute("users", this.reportService.findAll());
                model.addAttribute("usersSize", this.userService.findAll().stream().filter(us -> us.getRole() == Role.ROLE_USER).toList().size());
                model.addAttribute("reportsSize", this.reportService.findAll().size());
                return "dashboard";
            }
            return "login";

        }
        return "login";

    }



    @GetMapping("change-role")
    public String showAdd(HttpServletRequest req,Model model) {
        if (req.getSession().getAttribute("username") != null) {
            String username = req.getSession().getAttribute("username").toString();
            User u = this.userService.findByUsername(username).orElseThrow();
            if (u.getRole().equals(Role.ROLE_USER) || u.getRole().equals(Role.ROLE_EDITOR)) {
                model.addAttribute("types", Role.values());
                return "change-role";
            }
            return "redirect:/dashboard";
        }
        return "login";

    }


    @PostMapping("change-role")

    public String changeRole(@RequestParam String email, @RequestParam Role type) {
        User u = this.userService.findByEmail(email).orElseThrow();
        u.setRole(type);
        this.userService.save(u);
        return "redirect:/dashboard";
    }

    @GetMapping("/register")
    public String getRegisterPage(HttpServletRequest req,@RequestParam(required = false) String error, Model model) {
        if(error != null && !error.isEmpty()) {
            model.addAttribute("hasError", true);
            model.addAttribute("error", error);
        }
        if (req.getSession().getAttribute("username") != null) {
            String username = req.getSession().getAttribute("username").toString();
            User u = this.userService.findByUsername(username).orElseThrow();
            if (u.getRole().equals(Role.ROLE_USER) || u.getRole().equals(Role.ROLE_EDITOR)) {
                model.addAttribute("bodyContent", "register");
                return "register";
            }return "redirect:/dashboard";
        }
        return "login";
    }

    @PostMapping("/register")
    public String register(@RequestParam String username,
                           @RequestParam String password,
                           @RequestParam String repeatedPassword,
                           @RequestParam String email,
                           @RequestParam Role role) {
        try{
            this.service.register(new RegisterRequest(username,password,repeatedPassword,email));
            User u = this.userService.findByUsername(username).orElseThrow();
            u.setRole(role);
            this.userService.save(u);
            this.myActivityService.create(username);
            return "redirect:/login";
        } catch (InvalidArgumentsException | PasswordsDoNotMatchException exception) {
            return "redirect:/register?error=" + exception.getMessage();
        }
    }

    @GetMapping("categories")
    public String getCategories(Model model) {
        model.addAttribute("categories",this.categoryService.findAll());
        return "categories";
    }

    @GetMapping("categories/add")
    public String showAdd() {

        return "add-category";
    }

    @GetMapping("categories/{id}/edit")
    public String showEdit(@PathVariable Long id,Model model) {
        Category category = this.categoryService.findById(id);
        model.addAttribute("category",category);
        return "add-category";
    }


    @PostMapping("categories")
    public String create(@RequestParam String imageUrl, @RequestParam String name,@RequestParam String description) {
        this.categoryService.create(imageUrl,name, description);
        return "redirect:/dashboard/categories";
    }

    @PostMapping("categories/{id}")

    public String update(@PathVariable Long id,@RequestParam String imageUrl, @RequestParam String name,@RequestParam String description) {
        this.categoryService.update(id,imageUrl, name, description);
        return "redirect:/dashboard/categories";
    }
    @PostMapping("categories/{id}/delete")

    public String delete(@PathVariable Long id) {
        this.categoryService.delete(id);
        return "redirect:/dashboard/categories";
    }

    @GetMapping("events/{id}/details")
    public String showDetails(@PathVariable Long id, Model model, HttpServletRequest req) {
        Event event = this.eventService.findById(id);
        model.addAttribute("event",event);
        model.addAttribute("imgList",event.getEventInfo().getImages());
        return "details-event";
    }

    @PostMapping("events/{id}/delete")
    public String deleteEvent(@PathVariable Long id) {
        this.eventService.delete(id);
        return "redirect:/dashboard";
    }
}
