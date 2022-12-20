package com.example.theeventors.service.impl;

import com.example.theeventors.model.EventInfo;
import com.example.theeventors.repository.EventInfoRepository;
import com.example.theeventors.service.EventInfoService;

import java.util.List;

public class EventInfoServiceImpl implements EventInfoService {

    private final EventInfoRepository eventInfoRepository;

    public EventInfoServiceImpl(EventInfoRepository eventInfoRepository) {
        this.eventInfoRepository = eventInfoRepository;
    }

    @Override
    public List<EventInfo> findAll() {
        return this.eventInfoRepository.findAll();
    }

    @Override
    public EventInfo findById(Long id) {
        return this.eventInfoRepository.findById(id).orElseThrow();
    }

    @Override
    public EventInfo create(String title, String description, String location, String images, String createdBy) {
        return this.eventInfoRepository.save(new EventInfo(title,description,location,images,createdBy));
    }

    @Override
    public void delete(Long id) {
    this.eventInfoRepository.deleteById(id);
    }
}
