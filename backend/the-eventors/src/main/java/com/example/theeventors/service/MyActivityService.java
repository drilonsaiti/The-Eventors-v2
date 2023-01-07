package com.example.theeventors.service;


import com.example.theeventors.model.MyActivity;
import com.example.theeventors.model.dto.MyCommentDto;

import java.util.List;

public interface MyActivityService {
    List<MyActivity> findAll();
    MyActivity findById(Long id);
    MyActivity findByUsername(String username);

    MyActivity create(String username);

    MyActivity findOrCreate(String username);
    void delete(Long id);
    List<MyCommentDto> createAcivityForComments(List<Long> comments);
}
