package com.example.theeventors.service;

import com.example.theeventors.model.ActivityPerEvents;

import com.example.theeventors.model.dto.ActivityOfEventDto;
import jakarta.servlet.http.HttpServletRequest;

public interface ActivityPerEventsService {

    ActivityPerEvents countUsers(Long idEvent,String token);
    ActivityOfEventDto getActivity(Long id);
}
