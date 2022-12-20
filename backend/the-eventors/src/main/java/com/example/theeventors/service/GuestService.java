package com.example.theeventors.service;


import com.example.theeventors.model.Guest;

import java.time.LocalDateTime;
import java.util.List;

public interface GuestService {

    List<Guest> findAll();
    Guest findById(Long id);
    Guest create(String username, String name, String surname);
    void delete(Long id);
}
