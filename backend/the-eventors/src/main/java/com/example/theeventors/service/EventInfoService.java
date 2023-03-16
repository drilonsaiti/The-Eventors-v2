package com.example.theeventors.service;



import com.example.theeventors.model.EventInfo;
import com.example.theeventors.model.Image;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

public interface EventInfoService {
    List<EventInfo> findAll();
    EventInfo findById(Long id);
    EventInfo create(String title, String description , MultipartFile coverImage, MultipartFile [] images, String createdBy) throws IOException;

    EventInfo update(Long id, String title, String description  , MultipartFile coverImage, MultipartFile [] images, String createdBy) throws IOException;
    void delete(Long id);
}
