package com.example.theeventors.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.web.multipart.MultipartFile;


@Data
@AllArgsConstructor
public class MyActivityEventDto {
    String title;
    String createdBy;
    String timeAt;
    String coverImage;
    String startDateTime;

    String status;
    Long id;
}
