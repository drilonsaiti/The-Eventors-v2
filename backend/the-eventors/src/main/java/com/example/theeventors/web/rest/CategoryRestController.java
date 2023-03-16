package com.example.theeventors.web.rest;

import com.example.theeventors.model.Category;
import com.example.theeventors.service.CategoryService;
import com.example.theeventors.service.UserService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin
@RequestMapping("/api/categories")
public class CategoryRestController {

    private final CategoryService categoryService;

    private final UserService userService;

    public CategoryRestController(CategoryService categoryService, UserService userService) {
        this.categoryService = categoryService;
        this.userService = userService;
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
    public ResponseEntity<Category> create(@RequestParam String imageUrl,@RequestParam String name,@RequestParam String description) {
        return ResponseEntity.ok(this.categoryService.create(imageUrl,name, description));
    }

    @PostMapping("/{id}")

    public ResponseEntity<Category> update(@PathVariable Long id,@RequestParam String imageUrl, @RequestParam String name,@RequestParam String description) {
        return ResponseEntity.ok(this.categoryService.update(id,imageUrl, name, description));
    }
    @DeleteMapping("/{id}")
    public ResponseEntity<Boolean> delete(@PathVariable Long id) {
        return ResponseEntity.ok(this.categoryService.delete(id));
    }
}
