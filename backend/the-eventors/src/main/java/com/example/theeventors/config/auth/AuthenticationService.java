package com.example.theeventors.config.auth;


import com.example.theeventors.config.JwtService;
import com.example.theeventors.model.User;
import com.example.theeventors.model.exceptions.InvalidUserCredentialsException;
import com.example.theeventors.model.exceptions.UserNotFoundException;
import com.example.theeventors.repository.UserRepository;
import com.example.theeventors.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuthenticationService {
  private final UserRepository repository;
  private final PasswordEncoder passwordEncoder;
  private final JwtService jwtService;
  private final AuthenticationManager authenticationManager;

  private final UserService userService;

  public AuthenticationResponse register(RegisterRequest request) {
    var user = this.userService.register(request.getUsername(), request.getPassword(), request.getRepeatPassword(), request.getEmail());

    var jwtToken = jwtService.generateToken(user);
    var jwtRefreshToken = jwtService.generateRefreshToken(user);
    return AuthenticationResponse.builder()
            .token(jwtToken).refreshToken(jwtRefreshToken)
            .build();
  }

  public AuthenticationResponse authenticate(AuthenticationRequest request) throws ServletException {

    UserDetails user = repository.findByUsername(request.getUsername())
            .orElseThrow(() -> new UserNotFoundException(request.getUsername()));

    if (!passwordEncoder.matches(request.getPassword(),user.getPassword())){
      throw new BadCredentialsException("Password is incorrect");
    }
    authenticationManager.authenticate(
        new UsernamePasswordAuthenticationToken(
            request.getUsername(),
            request.getPassword()
        )
    );

    var jwtToken = jwtService.generateToken(user);
    var jwtRefreshToken = jwtService.generateRefreshToken(user);
    return AuthenticationResponse.builder()
        .token(jwtToken).refreshToken(jwtRefreshToken)
        .build();
  }

}
