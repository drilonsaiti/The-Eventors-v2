package com.example.theeventors.service.impl;

import com.example.theeventors.model.EventInfo;
import com.example.theeventors.model.Image;
import com.example.theeventors.model.exceptions.EventInfoNotFoundException;
import com.example.theeventors.model.exceptions.ImageNotFoundException;
import com.example.theeventors.repository.EventInfoRepository;
import com.example.theeventors.repository.ImageRepository;
import com.example.theeventors.service.EventInfoService;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

@Service
public class EventInfoServiceImpl implements EventInfoService {

    private final EventInfoRepository eventInfoRepository;
    private final ImageRepository imageRepository;

    public EventInfoServiceImpl(EventInfoRepository eventInfoRepository, ImageRepository imageRepository) {
        this.eventInfoRepository = eventInfoRepository;
        this.imageRepository = imageRepository;
    }

    @Override
    public List<EventInfo> findAll() {
        return this.eventInfoRepository.findAll();
    }

    @Override
    public EventInfo findById(Long id) {
        return this.eventInfoRepository.findById(id).orElseThrow(() -> new EventInfoNotFoundException(id));
    }

    @Override
    public EventInfo create(String title, String description , MultipartFile coverImage, MultipartFile [] images, String createdBy) throws IOException {
        Image cImage =  imageRepository.save(Image.builder()
                .name(coverImage.getOriginalFilename())
                .type(coverImage.getContentType())
                .imageBase64(String.format("data:%s;base64,%s", coverImage.getContentType(),
                        Base64.getEncoder().encodeToString(coverImage.getBytes()))).build());

        List<Image> imgs= new ArrayList<>();
        for (MultipartFile file : images) {
            imgs.add(imageRepository.save(Image.builder()
                    .name(file.getOriginalFilename())
                    .type(file.getContentType())
                    .imageBase64(String.format("data:%s;base64,%s", file.getContentType(),
                            Base64.getEncoder().encodeToString(file.getBytes()))).build()));
        }

        return this.eventInfoRepository.save(new EventInfo(title,description,cImage,imgs,createdBy));
    }

    @Override
    public EventInfo update(Long id, String title, String description , MultipartFile coverImage, MultipartFile [] images, String createdBy) throws IOException {
        EventInfo eventInfo = this.findById(id);

        Image cImage = this.imageRepository.findById(eventInfo.getCoverImage().getId()).orElseThrow(() -> new ImageNotFoundException(eventInfo.getCoverImage().getId()));
        cImage.setName(coverImage.getOriginalFilename());
        cImage.setType(coverImage.getContentType());
        cImage.setImageBase64(String.format("data:%s;base64,%s", coverImage.getContentType(),
                Base64.getEncoder().encodeToString(coverImage.getBytes())));

        eventInfo.setTitle(title);
        eventInfo.setDescription(description);
        eventInfo.setCoverImage(cImage);

        eventInfo.getImages().clear();
        System.out.println("Event infos get images length " + eventInfo.getImages().size());
        List<Image> imgs= new ArrayList<>();
        for (MultipartFile file : images) {
            imgs.add(imageRepository.save(Image.builder()
                    .name(file.getOriginalFilename())
                    .type(file.getContentType())
                    .imageBase64(String.format("data:%s;base64,%s", file.getContentType(),
                            Base64.getEncoder().encodeToString(file.getBytes()))).build()));
        }
        eventInfo.getImages().addAll(imgs);
        eventInfo.setCreatedBy(createdBy);
        return this.eventInfoRepository.save(eventInfo);
    }

    @Override
    public void delete(Long id) {
    this.eventInfoRepository.deleteById(id);
    }
}
