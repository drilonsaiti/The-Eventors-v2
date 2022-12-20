package com.example.theeventors.service.impl;

import com.example.theeventors.model.Guest;
import com.example.theeventors.repository.GuestRepository;
import com.example.theeventors.service.GuestService;

import java.util.List;

public class GuestServiceImpl implements GuestService {

    private final GuestRepository guestRepository;

    public GuestServiceImpl(GuestRepository guestRepository) {
        this.guestRepository = guestRepository;
    }

    @Override
    public List<Guest> findAll() {
        return this.guestRepository.findAll();
    }

    @Override
    public Guest findById(Long id) {
        return this.guestRepository.findById(id).orElseThrow();
    }

    @Override
    public Guest create(String username, String name, String surname) {
        return this.guestRepository.save(new Guest(username,name,surname));
    }

    @Override
    public void delete(Long id) {
        this.guestRepository.deleteById(id);
    }
}
