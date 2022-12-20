package com.example.theeventors.service.impl;

import com.example.theeventors.model.Category;
import com.example.theeventors.repository.CategoryRepository;
import com.example.theeventors.service.CategoryService;

import java.util.List;

public class CategoryServiceImpl implements CategoryService {

    private final CategoryRepository categoryRepository;

    public CategoryServiceImpl(CategoryRepository categoryRepository) {
        this.categoryRepository = categoryRepository;
    }

    @Override
    public List<Category> findAll() {
        return this.categoryRepository.findAll();
    }

    @Override
    public Category findById(Long id) {
        return this.categoryRepository.findById(id).orElseThrow();
    }

    @Override
    public Category create(String name, String description) {
        return this.categoryRepository.save(new Category(name,description));
    }

    @Override
    public void delete(Long id) {
        this.categoryRepository.deleteById(id);
    }
}
