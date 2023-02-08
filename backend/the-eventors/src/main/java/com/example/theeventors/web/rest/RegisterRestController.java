/*
package com.example.theeventors.web.rest;

import com.example.theeventors.model.User;
import com.example.theeventors.model.enumerations.Role;
import com.example.theeventors.model.exceptions.InvalidArgumentsException;
import com.example.theeventors.model.exceptions.PasswordsDoNotMatchException;
import com.example.theeventors.service.MyActivityService;
import com.example.theeventors.service.UserService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin
@RequestMapping("/register")
public class RegisterRestController {
    private final UserService userService;

    private final MyActivityService myActivityService;

    public RegisterRestController( UserService userService, MyActivityService myActivityService) {
        this.userService = userService;
        this.myActivityService = myActivityService;
    }
    @PostMapping
    public ResponseEntity.BodyBuilder register(@RequestParam String username,
                                               @RequestParam String password,
                                               @RequestParam String repeatedPassword,
                                               @RequestParam String name,
                                               @RequestParam String surname,
                                               @RequestParam Role role) {
        try{
            this.userService.register(username, password, repeatedPassword, name, surname, role);
            this.myActivityService.create(username);
            return ResponseEntity.ok();
        } catch (InvalidArgumentsException | PasswordsDoNotMatchException exception) {
            return ResponseEntity.internalServerError();
        }
    }
}
*/
