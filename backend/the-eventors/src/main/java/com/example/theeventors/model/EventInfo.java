package com.example.theeventors.model;


import jakarta.persistence.*;
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

    @OneToOne(cascade = CascadeType.ALL, orphanRemoval = true)
    Image coverImage;
    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
    List<Image> images;
    String createdBy;

    public EventInfo(String title, String description, String location, Image coverImage,List<Image> images, String createdBy) {
        this.title = title;
        this.description = description;
        this.location = location;
        this.coverImage = coverImage;
        this.images = images;
        this.createdBy = createdBy;
    }
}
