package com.example.theeventors.repository;

import com.example.theeventors.model.Report;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReportRepository extends JpaRepository<Report,Long> {

    List<Report> findAllByEventId(Long id);
    void deleteByEventId(Long id);
}
