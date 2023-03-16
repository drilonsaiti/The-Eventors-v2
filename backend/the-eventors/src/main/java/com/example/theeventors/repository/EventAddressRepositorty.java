package com.example.theeventors.repository;

import com.example.theeventors.model.EventAddress;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EventAddressRepositorty extends JpaRepository<EventAddress,Long> {
}
