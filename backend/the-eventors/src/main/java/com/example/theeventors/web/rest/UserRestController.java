package com.example.theeventors.web.rest;

import com.example.theeventors.config.JwtService;
import com.example.theeventors.model.Event;
import com.example.theeventors.model.User;
import com.example.theeventors.model.dto.*;
import com.example.theeventors.model.exceptions.PasswordsDoNotMatchException;
import com.example.theeventors.model.exceptions.UsernameAlreadyExistsException;
import com.example.theeventors.service.EventService;
import com.example.theeventors.service.UserService;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.maps.GeoApiContext;
import com.google.maps.GeocodingApi;
import com.google.maps.errors.ApiException;
import com.google.maps.model.GeocodingResult;
import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpServletRequest;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.List;

@RestController
@CrossOrigin
@AllArgsConstructor
@RequestMapping("/api/users")
public class UserRestController {

    private final UserService userService;

    private final JwtService jwtService;

    private final EventService eventService;


    @GetMapping()
    public ResponseEntity<List<UserUsernameDto>> getUsers() {
        return ResponseEntity.ok(userService.findAll());
    }

    @GetMapping("discover")
    public ResponseEntity<List<UserUsernameDto>> getDiscoverUsers(@RequestParam String token) {
        return ResponseEntity.ok(userService.findAllDiscoverUsers(token));
    }

    @GetMapping("find")
    public ResponseEntity<UserUsernameDto> getUser(@RequestParam String token) {
        return ResponseEntity.ok(this.userService.findUser(token));
    }

    @PostMapping("add/profile-image")
    public ResponseEntity.BodyBuilder addProfileImage(@ModelAttribute AddProfileImageDto dto) throws IOException {
        this.userService.addProfileImage(dto);
        return ResponseEntity.status(HttpStatus.CREATED);
    }

    @PostMapping("remove/profile-image")
    public ResponseEntity.BodyBuilder removeProfileImage(@RequestBody TokenDto dto) throws IOException {
        this.userService.removeProfileImage(dto);
        return ResponseEntity.status(HttpStatus.OK);
    }

    @GetMapping("count-following")
    public ResponseEntity<Integer> getSizeFollowing(@RequestParam String token) {
        System.out.println("TOKEN " + token);
        return ResponseEntity.ok(userService.countFollowing(token));
    }

    @GetMapping("/token/refresh")
    public ResponseEntity<String> refreshToken(HttpServletRequest request, HttpServletRequest response) {
        System.out.println("TOKEN REFRESHHHH");
        final String authHeader = request.getHeader("Authorization");
        final String jwt;
        final String username;
        String accesToken = "";
        System.out.println(authHeader);
        if (authHeader != null || authHeader.startsWith("Bearer ")) {


            jwt = authHeader.substring(7);
            System.out.println(jwt);
            username = jwtService.extractUsername(jwt);

            UserDetails userDetails = this.userService.loadUserByUsername(username);
            if (jwtService.isTokenValid(jwt, userDetails)) {
                UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(
                        userDetails,
                        null,
                        userDetails.getAuthorities()
                );
                authToken.setDetails(
                        new WebAuthenticationDetailsSource().buildDetails(request)
                );
                request.getSession().setAttribute("username", username);
                SecurityContextHolder.getContext().setAuthentication(authToken);
                accesToken = jwtService.generateToken(userDetails);
            } else {
                accesToken = "Refresh token not valid";
            }
        } else {
            accesToken = "No authorization";

        }
        return ResponseEntity.ok(accesToken);

    }

    @PostMapping("token/expired")
    public ResponseEntity<Boolean> checkIsTokenExpired(@RequestBody TokenDto token) {
        System.out.println("TOKEN EXPIRED");
        System.out.println(jwtService.isTokenExpired(token.getToken()));
       return  ResponseEntity.ok(jwtService.isTokenExpired(token.getToken()));

    }

    @PostMapping("verification-code")
    public ResponseEntity.BodyBuilder sendVerificationCode(@RequestBody VerificationDto dto) throws MessagingException, IOException, GeneralSecurityException {
        System.out.println("==================VERIFICIATON=================");
        System.out.println(dto.getToken());
        this.userService.sendVerificationEmail(dto);
        return  ResponseEntity.ok();

    }

    @PostMapping("delete-account")
    public ResponseEntity.BodyBuilder sendVerificationCode(@RequestBody TokenDto dto) {

        this.userService.deleteAccount(dto.getToken());
        return  ResponseEntity.ok();

    }


}