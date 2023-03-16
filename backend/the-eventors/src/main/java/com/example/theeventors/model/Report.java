package com.example.theeventors.model;

import com.example.theeventors.model.enumerations.ReportType;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Objects;


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

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Report report)) return false;
        return getId().equals(report.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId());
    }
}
