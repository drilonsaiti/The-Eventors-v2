package com.example.theeventors.service.impl;

import com.example.theeventors.model.MyParticipant;
import com.example.theeventors.repository.MyParticipantRepository;
import com.example.theeventors.service.MyParticipantService;

import java.util.List;

public class MyParticipantServiceImpl implements MyParticipantService {

    private final MyParticipantRepository myParticipantRepository;

    public MyParticipantServiceImpl(MyParticipantRepository myParticipantRepository) {
        this.myParticipantRepository = myParticipantRepository;
    }

    @Override
    public List<MyParticipant> findAll() {
        return this.myParticipantRepository.findAll();
    }

    @Override
    public MyParticipant findById(Long id) {
        return this.myParticipantRepository.findById(id).orElseThrow();
    }

    @Override
    public MyParticipant create(String username) {
        return this.myParticipantRepository.save(new MyParticipant(username));
    }

    @Override
    public void delete(Long id) {
        this.myParticipantRepository.deleteById(id);
    }
}
