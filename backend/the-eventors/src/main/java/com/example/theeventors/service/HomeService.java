package com.example.theeventors.service;

import com.example.theeventors.model.Event;

import java.util.List;

public interface HomeService {

    List<Event> findAll(String username);
}
