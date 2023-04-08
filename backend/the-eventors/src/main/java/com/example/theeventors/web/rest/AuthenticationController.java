package com.example.theeventors.web.rest;

import com.example.theeventors.config.JwtService;
import com.example.theeventors.config.auth.AuthenticationRequest;
import com.example.theeventors.config.auth.AuthenticationResponse;
import com.example.theeventors.config.auth.AuthenticationService;
import com.example.theeventors.config.auth.RegisterRequest;
import com.example.theeventors.model.User;
import com.example.theeventors.model.dto.*;
import com.example.theeventors.model.exceptions.*;
import com.example.theeventors.repository.UserRepository;
import com.example.theeventors.service.MyActivityService;
import com.example.theeventors.service.UserService;
import com.example.theeventors.service.impl.FirebaseMessagingService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthenticationController {

  private final AuthenticationService service;

  private final JwtService jwtService;

  private final UserService userService;

  private final FirebaseMessagingService messagingService;
  private final MyActivityService myActivityService;

  @PostMapping("/register")
  public ResponseEntity<AuthenticationResponse> register(
      @RequestBody RegisterRequest request
  ) {
    this.myActivityService.create(request.getUsername());
    return ResponseEntity.ok(service.register(request));
  }
  @PostMapping("/login")
  @ExceptionHandler(value = { BadCredentialsException.class, UserNotFoundException.class })
  public ResponseEntity<?> authenticate(
          @RequestBody AuthenticationRequest request, HttpServletRequest req, final RuntimeException ex
          ) throws ServletException {
    System.out.println("LOGIN");
    try {
      req.getSession().setAttribute("username",request.getUsername());
      System.out.println(req.getSession().getAttribute("username"));
      return ResponseEntity.ok(service.authenticate(request));
    }catch (BadCredentialsException | UserNotFoundException e){
      System.out.println("ERROR");
      return new ResponseEntity<>(e.getMessage(),HttpStatus.UNAUTHORIZED);
    }
  }

  @PostMapping("/extract-username")
  public ResponseEntity<String> getUsername(@RequestBody TokenDto token){
    return ResponseEntity.ok(jwtService.extractUsername(token.getToken()));
  }

  @PostMapping("/extract-email")
  public ResponseEntity<String> getEmail(@RequestBody TokenDto token){
    return ResponseEntity.ok(this.userService.extractEmail(jwtService.extractUsername(token.getToken())));
  }


  @PostMapping("/change-username")
  public ResponseEntity<?> changeUsername(@RequestBody ChangeUsernameDto change) throws ServletException {
    try {
      this.userService.changeUsername(change);
      return ResponseEntity.ok("Username has changed");

    }catch (UsernameNotFoundException | UsernameAlreadyExistsException | PasswordsDoNotMatchException e){
      return new ResponseEntity<>(e.getMessage(),HttpStatus.NOT_FOUND);
    }
  }


  @PostMapping("/change-password")
  public ResponseEntity<?> changePassword(@RequestBody ChangePasswordDto change) throws ServletException {
    try {
      this.userService.changePassword(change);
      return ResponseEntity.ok("Password has changed");

    }catch (UsernameNotFoundException | UsernameAlreadyExistsException | PasswordsDoNotMatchException e){
      return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
    }
  }

  @PostMapping("/change-email")
  public ResponseEntity<?> changeEmail(@RequestBody ChangeEmailDto change) throws ServletException {
    try {
      this.userService.changeEmail(change);
      return ResponseEntity.ok("Email has changed");
    }catch (UsernameNotFoundException | UsernameAlreadyExistsException | PasswordsDoNotMatchException |EmailDoesntExistsException |
            EmailAlreadyExistsException | PasswordIncorrectExecption | VerificationCodeDoNotMatchException e){

      return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
    }
  }
  @PostMapping("/forgot-password")
  public ResponseEntity<?> forgotPassword(@RequestBody ForgotPassword change) throws ServletException {
    try {
      this.userService.forgetPassword(change);
      return ResponseEntity.ok("Forget pass has changed");

    }catch (EmailDoesntExistsException | PasswordsDoNotMatchException |
            VerificationCodeDoNotMatchException e ){
      return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
    }
  }

  @PostMapping("/notification-token")
  public ResponseEntity.BodyBuilder setNotificationToken(@RequestBody NotificationTokenDto token){
    this.messagingService.addNotificationToken(token);
    return ResponseEntity.ok();
  }

}
