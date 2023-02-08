/*
package com.example.theeventors.web.rest;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@CrossOrigin
@RequestMapping("/logout")
public class LogoutRestController {

    @GetMapping
    public ResponseEntity.BodyBuilder logout(HttpServletRequest request) {
        request.getSession().invalidate();
         return ResponseEntity.ok();
    }
}
*/
