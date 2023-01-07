package com.example.theeventors.service.impl;

import com.example.theeventors.model.Guest;
import com.example.theeventors.model.exceptions.GuestNotFoundException;
import com.example.theeventors.repository.GuestRepository;
import com.example.theeventors.service.GuestService;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
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
        return this.guestRepository.findById(id).orElseThrow(() -> new GuestNotFoundException(id));
    }

    @Override
    public Guest update(Long id, String guests) {
        Guest guest = this.findById(id);
        guest.getWithUsername().clear();
        guest.getWithNameAndSurname().clear();
        this.guestRepository.save(guest);
        for (String s : guests.split(",")){
            if (s.startsWith("@"))
                guest.getWithUsername().add(s);
            else
                guest.getWithNameAndSurname().add(s);
        }
        return this.guestRepository.save(guest);
    }

    @Override
    public Guest create(String guests) {

        Guest g = new Guest();
        for (String s : guests.split(",")){
            if (s.startsWith("@"))
                g.getWithUsername().add(s);
            else
                g.getWithNameAndSurname().add(s);
        }
        return this.guestRepository.save(g);
    }

    @Override
    public void delete(Long id) {
        this.guestRepository.deleteById(id);
    }
}
