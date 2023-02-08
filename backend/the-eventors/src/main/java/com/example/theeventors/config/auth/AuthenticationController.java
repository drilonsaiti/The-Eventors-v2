package com.example.theeventors.config.auth;

import com.example.theeventors.config.JwtService;
import com.example.theeventors.model.User;
import com.example.theeventors.model.exceptions.UserNotFoundException;
import com.example.theeventors.repository.UserRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Optional;

@RestController
@RequestMapping("/api")
@RequiredArgsConstructor
public class AuthenticationController {

  private final AuthenticationService service;

  private final JwtService jwtService;

  @PostMapping("/register")
  public ResponseEntity<AuthenticationResponse> register(
      @RequestBody RegisterRequest request
  ) {
    return ResponseEntity.ok(service.register(request));
  }
  @PostMapping("/login")
  public ResponseEntity<String> authenticate(
          @RequestBody AuthenticationRequest request,HttpServletRequest req
          ) throws ServletException {
    System.out.println("LOGIN");
    try {
      req.getSession().setAttribute("username",request.getUsername());
      System.out.println(req.getRemoteUser());
      return ResponseEntity.ok(service.authenticate(request).getToken());
    }catch (BadCredentialsException | UserNotFoundException e){
      System.out.println(e.getMessage());
      return ResponseEntity.ok(e.getMessage());
    }
  }


}
