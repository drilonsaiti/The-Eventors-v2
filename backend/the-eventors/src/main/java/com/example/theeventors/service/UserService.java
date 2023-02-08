package com.example.theeventors.service;

import com.example.theeventors.model.User;
import com.example.theeventors.model.dto.UserUsernameDto;
import com.example.theeventors.model.enumerations.Role;
import org.springframework.security.core.userdetails.UserDetailsService;

import java.util.List;

public interface UserService extends UserDetailsService {

    User register(String username, String password, String repeatPassword, String name, String surname, Role role);

    void followingUser(String usernameFollowing,String usernameFollow);
    void unFollowingUser(String usernameFollowing,String usernameFollow);

    List<UserUsernameDto> findAll();

}

