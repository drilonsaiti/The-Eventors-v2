package com.example.theeventors.web.rest;

import com.example.theeventors.model.Category;
import com.example.theeventors.model.enumerations.Role;
import com.example.theeventors.model.exceptions.InvalidArgumentsException;
import com.example.theeventors.model.exceptions.PasswordsDoNotMatchException;
import com.example.theeventors.service.CategoryService;
import com.example.theeventors.service.MyActivityService;
import com.example.theeventors.service.UserService;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin
@RequestMapping("/categories")
public class CategoryRestController {

    private final CategoryService categoryService;

    public CategoryRestController(CategoryService categoryService) {
        this.categoryService = categoryService;
    }

    @GetMapping
    public ResponseEntity<List<Category>> getCategories() {
        return ResponseEntity.ok(categoryService.findAll());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Category> getCategory(@PathVariable Long id) {
        return ResponseEntity.ok(categoryService.findById(id));
    }

    @PostMapping
    public ResponseEntity<Category> create(@RequestParam String name,@RequestParam String description) {
        return ResponseEntity.ok(this.categoryService.create(name, description));
    }

    @PostMapping("/{id}")

    public ResponseEntity<Category> update(@PathVariable Long id, @RequestParam String name,@RequestParam String description) {
        return ResponseEntity.ok(this.categoryService.update(id, name, description));
    }
    @DeleteMapping("/{id}")
    public ResponseEntity<Boolean> delete(@PathVariable Long id) {
        return ResponseEntity.ok(this.categoryService.delete(id));
    }
}
