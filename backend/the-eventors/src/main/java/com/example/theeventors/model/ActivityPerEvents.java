package com.example.theeventors.model;

import lombok.Data;
import lombok.NoArgsConstructor;
import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;

@Data
@Entity
public class ActivityPerEvents {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;
    @ElementCollection
    List<String> followers;
    @ElementCollection
    List<String> users;
    @ElementCollection
    List<String> anonymous;


    public ActivityPerEvents() {
        this.followers = new ArrayList<>();
        this.users = new ArrayList<>();
        this.anonymous = new ArrayList<>();
    }
}
