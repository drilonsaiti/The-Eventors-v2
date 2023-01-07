package com.example.theeventors.service;

import com.example.theeventors.model.User;

public interface AuthService {
    User login(String username, String password);

    User findByUsername(String username);

}

