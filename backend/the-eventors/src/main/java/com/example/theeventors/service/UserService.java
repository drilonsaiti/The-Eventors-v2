package com.example.theeventors.service;

import com.example.theeventors.model.User;
import com.example.theeventors.model.dto.*;
import com.example.theeventors.model.enumerations.Role;
import jakarta.mail.MessagingException;
import org.springframework.security.core.userdetails.UserDetailsService;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.List;

public interface UserService extends UserDetailsService {

    User register(String username, String password, String repeatPassword, String email);

    void followingUser(String usernameFollowing,String usernameFollow);
    void unFollowingUser(String usernameFollowing,String usernameFollow);

    List<UserUsernameDto> findAll();
    int countFollowing(String token);
    List<UserUsernameDto> findAllDiscoverUsers(String token);

    UserUsernameDto findUser(String token);

    UserProfileDto findUserProfile(String username);

    boolean isFollowing(String token,String username);

    void changeUsername(ChangeUsernameDto change);

    void changePassword(ChangePasswordDto change);
    void changeEmail(ChangeEmailDto change);
    void forgetPassword(ForgotPassword dto);
    void deleteAccount(String token);


    void addProfileImage(AddProfileImageDto dto) throws IOException;

    void removeProfileImage(TokenDto dto);

    String extractEmail(String extractUsername);
     void sendVerificationEmail(VerificationDto dto) throws MessagingException, IOException, GeneralSecurityException;

    void updateProfile(UpdateProfileDto dto);
}

