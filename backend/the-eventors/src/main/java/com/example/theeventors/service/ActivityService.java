package com.example.theeventors.service;


import com.example.theeventors.model.Activity;

import java.util.List;

public interface ActivityService {
    List<Activity> findAll();
    Activity findById(Long id);
    Activity create();
    void delete(Long id);
}
