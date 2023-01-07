package com.example.theeventors.service;

import com.example.theeventors.model.ActivityPerEvents;

import jakarta.servlet.http.HttpServletRequest;

public interface ActivityPerEventsService {

    ActivityPerEvents countUsers(Long idEvent,HttpServletRequest req);
}
