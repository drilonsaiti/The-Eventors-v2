package com.example.theeventors.model;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;
@Entity
@Data

public class Participant {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;
    @ElementCollection
    List<String> going;
    @ElementCollection
    List<String> interested;

    public Participant() {
        this.going = new ArrayList<>();
        this.interested = new ArrayList<>();
    }
}
