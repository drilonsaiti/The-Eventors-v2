package com.example.theeventors.model;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
public class Category {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    String imageUrl;
    String name;
    String description;

    public Category( String imageUrl,String name, String description) {
        this.name = name;
        this.description = description;
    }
}
