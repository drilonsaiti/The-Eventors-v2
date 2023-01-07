package com.example.theeventors.service.impl;

import com.example.theeventors.model.Activity;
import com.example.theeventors.model.exceptions.ActivityNotFoundException;
import com.example.theeventors.repository.ActivityRepository;
import com.example.theeventors.service.ActivityService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ActivityServiceImpl implements ActivityService {

    private final ActivityRepository activityRepository;

    public ActivityServiceImpl(ActivityRepository activityRepository) {
        this.activityRepository = activityRepository;
    }

    @Override
    public List<Activity> findAll() {
        return this.activityRepository.findAll();
    }

    @Override
    public Activity findById(Long id) {
        return this.activityRepository.findById(id).orElseThrow(() -> new ActivityNotFoundException(id));
    }

    @Override
    public Activity create() {
        return this.activityRepository.save(new Activity());
    }

    @Override
    public void delete(Long id) {
        this.activityRepository.deleteById(id);
    }
}
