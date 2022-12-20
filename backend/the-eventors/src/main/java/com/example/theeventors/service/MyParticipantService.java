package com.example.theeventors.service;


import com.example.theeventors.model.MyParticipant;

import java.util.List;

public interface MyParticipantService {
    List<MyParticipant> findAll();
    MyParticipant findById(Long id);
    MyParticipant create(String username);
    void delete(Long id);
}
