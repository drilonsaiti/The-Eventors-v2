package com.example.theeventors.model.dto;

import com.example.theeventors.model.Category;
import com.example.theeventors.model.Image;
import jakarta.persistence.CascadeType;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;
import java.util.List;

@AllArgsConstructor
@Data
public class EventDtoRequest {

    String title;
    String description;
    String location;

    MultipartFile coverImage;
    MultipartFile[] images;

    String startTime;
    String duration;

    String category;
    String guests;

}
