package com.example.theeventors.model.dto;

import com.example.theeventors.model.Report;
import lombok.Data;

import java.util.List;

@Data
public class ReportByEventIdDto {

    Long id;
    String name;
    List<Report> reportList;

    public ReportByEventIdDto(Long id, String name, List<Report> reportList) {
        this.id = id;
        this.name = name;
        this.reportList = reportList;
    }
}
