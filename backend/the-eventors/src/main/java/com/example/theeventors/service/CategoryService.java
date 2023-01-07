package com.example.theeventors.service;



import com.example.theeventors.model.Category;

import java.util.List;

public interface CategoryService {

    List<Category> findAll();
    Category findById(Long id);
    Category create(String name, String description);

    Category update(Long id,String name, String description);
    void delete(Long id);
}
