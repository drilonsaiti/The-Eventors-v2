package com.example.theeventors.web.controller;

import com.example.theeventors.model.Image;
import com.example.theeventors.repository.ImageRepository;
import com.example.theeventors.service.EventService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.ui.Model;


import java.io.IOException;
import java.util.Base64;

@Controller
public class ImageController {

    @Autowired
    private final ImageRepository imageRepository;

    private final EventService eventService;

    public ImageController(ImageRepository imageRepository, EventService eventService) {
        this.imageRepository = imageRepository;
        this.eventService = eventService;
    }

    @GetMapping("image")
    public String getImage(Model model){
        model.addAttribute("imagesList",this.imageRepository.findAll());
        return "image";
    }

    @GetMapping("image/3")
    public String images(Model model){
        model.addAttribute("event",this.eventService.findById(3L));
        return "image";
    }

    @PostMapping("upload/image")
    public String uplaodImage(@RequestParam("image") MultipartFile [] files)
            throws IOException {

        for (MultipartFile file : files) {
            imageRepository.save(Image.builder()
                    .name(file.getOriginalFilename())
                    .type(file.getContentType())
                    .imageBase64(String.format("data:%s;base64,%s", file.getContentType(),
                            Base64.getEncoder().encodeToString(file.getBytes()))).build());
        }
        return "redirect:/image";
    }
}
