package com.example.theeventors.web.rest;

import com.example.theeventors.model.Category;
import com.example.theeventors.model.dto.UserDto;
import com.example.theeventors.model.dto.UserUsernameDto;
import com.example.theeventors.service.UserService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@CrossOrigin
@AllArgsConstructor
@RequestMapping("/api/users")
public class UserRestController {

    private final UserService userService;

    @GetMapping
    public ResponseEntity<List<UserUsernameDto>> getCategories() {
        return ResponseEntity.ok(userService.findAll());
    }

}
