package com.example.theeventors.service.impl;

import com.example.theeventors.model.Event;
import com.example.theeventors.model.Report;
import com.example.theeventors.model.dto.ReportByEventIdDto;
import com.example.theeventors.model.enumerations.ReportType;
import com.example.theeventors.model.exceptions.EventNotFoundException;
import com.example.theeventors.model.exceptions.ReportNotFoundException;
import com.example.theeventors.repository.EventRepository;
import com.example.theeventors.repository.ReportRepository;
import com.example.theeventors.service.ReportService;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

@Service
public class ReportServiceImpl implements ReportService {

    private final ReportRepository reportRepository;
    private final EventRepository eventRepository;

    public ReportServiceImpl(ReportRepository reportRepository, EventRepository eventRepository) {
        this.reportRepository = reportRepository;
        this.eventRepository = eventRepository;
    }


    @Override
    public List<Report> findAll() {
        return this.reportRepository.findAll();
    }

    @Override
    public Report findById(Long id) {
        return this.reportRepository.findById(id).orElseThrow(() -> new ReportNotFoundException(id));
    }

    @Override
    public List<Report> findByEventId(Long id) {
        return this.reportRepository.findAllByEventId(id);
    }

    @Override
    public Report create(String username, Long idEvent, String type) {
        ReportType reportType =  Arrays.stream(ReportType.values()).filter(r -> r.label.equals(type)).toList().get(0);
        return this.reportRepository.save(new Report(username,idEvent,reportType));
    }

    @Override
    public List<ReportByEventIdDto> mapToList(Map<Long, List<Report>> map) {
        List<ReportByEventIdDto> reports = new ArrayList<>();
        for (Map.Entry<Long,List<Report>> m : map.entrySet()){
            Event event = this.eventRepository.findById(m.getKey()).orElseThrow(() -> new EventNotFoundException(m.getKey()));
            reports.add(new ReportByEventIdDto(m.getKey(),event.getEventInfo().getTitle(),m.getValue()));
        }
        return reports;
    }
}
