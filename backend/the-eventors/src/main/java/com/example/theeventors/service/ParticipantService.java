package com.example.theeventors.service;


import com.example.theeventors.model.Participant;

import java.util.List;

public interface ParticipantService {
    List<Participant> findAll();
    Participant findById(Long id);
    Participant create();
    void delete(Long id);
}
