/*
package com.example.theeventors.web.rest;

import com.example.theeventors.model.Report;
import com.example.theeventors.model.dto.ReportByEventIdDto;
import com.example.theeventors.service.ReportService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@CrossOrigin
@RequestMapping("reports")
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

    @GetMapping("/{id}")
    public ResponseEntity<Report> getReports(@PathVariable Long id){
        return ResponseEntity.ok(this.reportService.findById(id));
    }

    @PostMapping("/event/{id}")
    public ResponseEntity<Report> createReport(@PathVariable Long id, @RequestParam String type, HttpServletRequest req){
        return ResponseEntity.ok(this.reportService.create(req.getRemoteUser(),id,type));
    }
}
*/
