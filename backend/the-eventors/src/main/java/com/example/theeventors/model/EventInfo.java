package com.example.theeventors.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Entity
@Data
@NoArgsConstructor
public class EventInfo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;
    String title;
    String description;
    String location;
    String images;
    String createdBy;

    public EventInfo(String title, String description, String location, String images, String createdBy) {
        this.title = title;
        this.description = description;
        this.location = location;
        this.images = images;
        this.createdBy = createdBy;
    }
}
