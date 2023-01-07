package com.example.theeventors.service.impl;

import com.example.theeventors.model.User;
import com.example.theeventors.model.exceptions.InvalidArgumentsException;
import com.example.theeventors.model.exceptions.InvalidUserCredentialsException;
import com.example.theeventors.repository.UserRepository;
import com.example.theeventors.service.AuthService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class AuthServiceImpl implements AuthService {

    private final UserRepository userRepository;

    public AuthServiceImpl(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public User login(String username, String password) {
        if (username==null || username.isEmpty() || password==null || password.isEmpty()) {
            throw new InvalidArgumentsException();
        }
        return userRepository.findByUsernameAndPassword(username,
                password).orElseThrow(InvalidUserCredentialsException::new);
    }

    @Override
    public User findByUsername(String username) {
        return this.userRepository.findByUsername(username).orElseThrow(() -> new UsernameNotFoundException(String.format("Username with %s doesn't exists",username)));
    }

}

