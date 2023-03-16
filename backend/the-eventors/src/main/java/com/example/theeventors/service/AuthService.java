package com.example.theeventors.service;

import com.example.theeventors.model.User;

public interface AuthService {

    User findByUsername(String username);
    public User login(String username, String password);
}

