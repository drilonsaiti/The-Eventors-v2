package com.example.theeventors.service.impl;

import com.example.theeventors.model.Category;
import com.example.theeventors.model.exceptions.CategoryNotFoundException;
import com.example.theeventors.repository.CategoryRepository;
import com.example.theeventors.service.CategoryService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
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
        return this.categoryRepository.findById(id).orElseThrow(() -> new CategoryNotFoundException(id));
    }

    @Override
    public Category create(String name, String description) {
        return this.categoryRepository.save(new Category(name,description));
    }

    @Override
    public Category update(Long id, String name, String description) {
        Category category = this.findById(id);
        category.setName(name);
        category.setDescription(description);
        return this.categoryRepository.save(category);
    }

    @Override
    public Boolean delete(Long id) {

        this.categoryRepository.deleteById(id);
        return true;
    }
}
