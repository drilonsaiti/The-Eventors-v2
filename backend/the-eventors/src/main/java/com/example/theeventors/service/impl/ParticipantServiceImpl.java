package com.example.theeventors.service.impl;

import com.example.theeventors.model.Participant;
import com.example.theeventors.repository.ParticipantRepository;
import com.example.theeventors.service.ParticipantService;

import java.util.List;

public class ParticipantServiceImpl implements ParticipantService {

    private final ParticipantRepository participantRepository;

    public ParticipantServiceImpl(ParticipantRepository participantRepository) {
        this.participantRepository = participantRepository;
    }

    @Override
    public List<Participant> findAll() {
        return this.participantRepository.findAll();
    }

    @Override
    public Participant findById(Long id) {
        return this.participantRepository.findById(id).orElseThrow();
    }

    @Override
    public Participant create() {
        return this.participantRepository.save(new Participant());
    }

    @Override
    public void delete(Long id) {
        this.participantRepository.deleteById(id);
    }
}
