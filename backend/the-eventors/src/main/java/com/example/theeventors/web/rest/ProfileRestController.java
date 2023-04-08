
package com.example.theeventors.web.rest;

import com.example.theeventors.config.JwtService;
import com.example.theeventors.model.User;
import com.example.theeventors.model.dto.*;
import com.example.theeventors.model.enumerations.NotificationTypes;
import com.example.theeventors.service.AuthService;
import com.example.theeventors.service.NotificationInfoService;
import com.example.theeventors.service.UserService;
import com.google.firebase.messaging.FirebaseMessagingException;
import jakarta.servlet.http.HttpServletRequest;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin
@RequestMapping("/api/profile")
@AllArgsConstructor
public class ProfileRestController {

    private final AuthService userService;
    private final UserService service;

    private final JwtService jwtService;
    private final NotificationInfoService notificationInfoService;



    @GetMapping
    public ResponseEntity<UserProfileDto> getProfile(@RequestParam String username) {
        System.out.println(username);
        return ResponseEntity.ok(this.service.findUserProfile(username));
    }

    @GetMapping("/{username}")
    public ResponseEntity<User> getProfileUser(@PathVariable String username, HttpServletRequest req ){
        User user = this.userService.findByUsername(username);
        User following = this.userService.findByUsername(req.getRemoteUser());
        boolean isFollowing = following.getFollowing().stream().anyMatch(f -> f.equals(username));
        return ResponseEntity.ok(user);
    }

    @PostMapping("/isFollowing")
    public ResponseEntity<Boolean> isFollowing(@RequestBody CheckIsFollowingDto check, HttpServletRequest req ){
        return ResponseEntity.ok(this.service.isFollowing(check.getToken(),check.getUsername()));
    }



    @PostMapping("/follow")
    public ResponseEntity.BodyBuilder doFollow(@RequestBody NotificationInfoDto dto) throws FirebaseMessagingException { //notification following
        String usernameFollowing = jwtService.extractUsername(dto.getFrom());
        this.notificationInfoService.createFollow(dto, NotificationTypes.FOLLOW);
        this.service.followingUser(usernameFollowing,dto.getTo());
        return ResponseEntity.ok();
    }
    @PostMapping("/unfollow")
    public ResponseEntity.BodyBuilder doUnfollow( @RequestBody FollowRequestDto dto){
        String usernameFollowing = jwtService.extractUsername(dto.getToken());
        this.service.unFollowingUser(usernameFollowing, dto.getUsername());
        return ResponseEntity.ok();
    }

    @PostMapping("/edit")
    public ResponseEntity.BodyBuilder editProfile( @RequestBody UpdateProfileDto dto){
        this.service.updateProfile(dto);
        return ResponseEntity.ok();
    }

    @GetMapping("my-following")
    public ResponseEntity<List<UserUsernameDto>> getMyFollowingUsers(@RequestParam String token) {
        return ResponseEntity.ok(this.service.findAllMyFollowing(token));
    }

    @GetMapping("my-followers")
    public ResponseEntity<List<UserUsernameDto>> getMyFollowersUsers(@RequestParam String token) {
        return ResponseEntity.ok(this.service.findAllMyFollowers(token));
    }
}

