package com.example.theeventors.service;



import com.example.theeventors.model.EventInfo;

import java.util.List;

public interface EventInfoService {
    List<EventInfo> findAll();
    EventInfo findById(Long id);
    EventInfo create(String title, String description, String location, String images, String createdBy);
    void delete(Long id);
}
