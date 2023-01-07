package com.example.theeventors.web.controller;


import com.example.theeventors.model.Category;
import com.example.theeventors.service.CategoryService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@PreAuthorize("hasRole('ROLE_ADMIN')")
public class CategoryController {

    private final CategoryService categoryService;

    public CategoryController(CategoryService categoryService) {
        this.categoryService = categoryService;
    }

    @GetMapping("categories")
    public String getCategories(Model model) {
        model.addAttribute("categories",this.categoryService.findAll());
        return "categories";
    }

    @GetMapping("categories/add")
    public String showAdd() {

        return "add-category";
    }

    @GetMapping("categories/{id}/edit")
    public String showEdit(@PathVariable Long id,Model model) {
        Category category = this.categoryService.findById(id);
        model.addAttribute("category",category);
        return "add-category";
    }


    @PostMapping("categories")
    public String create(@RequestParam String name,@RequestParam String description) {
        this.categoryService.create(name, description);
        return "redirect:/categories";
    }

    @PostMapping("categories/{id}")

    public String update(@PathVariable Long id, @RequestParam String name,@RequestParam String description) {
        this.categoryService.update(id, name, description);
        return "redirect:/categories";
    }
    @PostMapping("categories/{id}/delete")

    public String delete(@PathVariable Long id) {
        this.categoryService.delete(id);
        return "redirect:/categories";
    }

}
