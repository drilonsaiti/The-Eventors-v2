package com.example.theeventors.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity
@NoArgsConstructor
public class EventAddress {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

     String location;
    double lat;
     double lng;

    public EventAddress(String location, double lat, double lng) {
        this.location = location;
        this.lat = lat;
        this.lng = lng;
    }
}
