package com.example.theeventors.web.controller;


import com.example.theeventors.model.Report;
import com.example.theeventors.service.ReportService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
public class ReportController {

    private final ReportService reportService;

    public ReportController(ReportService reportService) {
        this.reportService = reportService;
    }

    @GetMapping("/reports")
    public String getReports(Model model){
        Map<Long, List<Report>> reportGrouping = this.reportService.findAll()
                        .stream().collect(Collectors.groupingBy(Report::getEventId));
        model.addAttribute("reports",this.reportService.mapToList(reportGrouping).stream().sorted());
        return "reports";
    }

    @GetMapping("/reports/{id}")
    public String getReports(@PathVariable Long id, Model model){

        model.addAttribute("reports",this.reportService.findByEventId(id));
        return "details-report";
    }

    @PostMapping("/reports/event/{id}")
    public String createReport(@PathVariable Long id, @RequestParam String type){
        this.reportService.create("drilon",id,type);
        return "redirect:/events/"+id+"/details";
    }
}
