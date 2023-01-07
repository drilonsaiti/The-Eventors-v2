package com.example.theeventors.service;

import com.example.theeventors.model.Report;
import com.example.theeventors.model.dto.ReportByEventIdDto;

import java.util.List;
import java.util.Map;

public interface ReportService {

    List<Report> findAll();
    Report findById(Long id);
    List<Report> findByEventId(Long id);

    Report create(String username, Long idEvent, String type);

    List<ReportByEventIdDto> mapToList(Map<Long,List<Report>> map);

}
