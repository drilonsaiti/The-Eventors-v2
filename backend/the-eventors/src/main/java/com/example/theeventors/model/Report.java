package com.example.theeventors.model;

import com.example.theeventors.model.enumerations.ReportType;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@Entity
@NoArgsConstructor
public class Report {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;
    String username;
    Long eventId;
    ReportType type;

    public Report(String username, Long eventId, ReportType type) {
        this.username = username;
        this.eventId = eventId;
        this.type = type;
    }
}
