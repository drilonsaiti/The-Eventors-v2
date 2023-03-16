package com.example.theeventors.web.rest;

import com.example.theeventors.model.Report;
import com.example.theeventors.model.dto.ReportByEventIdDto;
import com.example.theeventors.model.dto.ReportRequestDto;
import com.example.theeventors.model.enumerations.ReportType;
import com.example.theeventors.service.ReportService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@CrossOrigin
@RequestMapping("/api/reports")
public class ReportRestController {
    private final ReportService reportService;

    public ReportRestController(ReportService reportService) {
        this.reportService = reportService;
    }


    @GetMapping
    public ResponseEntity<List<ReportByEventIdDto>> getReports(){
        Map<Long, List<Report>> reportGrouping = this.reportService.findAll()
                .stream().collect(Collectors.groupingBy(Report::getEventId));
        return ResponseEntity.ok(this.reportService.mapToList(reportGrouping));
    }

    @GetMapping("/types")
    public ResponseEntity<List<String>> getReportList(){
        List<String> list = new ArrayList<>();
        for (ReportType r : ReportType.values()){
            list.add(r.label);
        }
        return ResponseEntity.ok(list);
    }


    @GetMapping("/{id}")
    public ResponseEntity<Report> getReports(@PathVariable Long id){
        return ResponseEntity.ok(this.reportService.findById(id));
    }

    @PostMapping("/event/{id}")
    public ResponseEntity<Report> createReport(@PathVariable Long id, @RequestBody ReportRequestDto dto){
        return ResponseEntity.ok(this.reportService.create(dto.getToken(),id, dto.getType()));
    }
}
