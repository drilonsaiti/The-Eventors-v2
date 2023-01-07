package com.example.theeventors.model.exceptions;


import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(HttpStatus.NOT_FOUND)
public class ImageNotFoundException extends RuntimeException{

    public ImageNotFoundException(Long id) {
        super(String.format("Image with id: %d was not found", id));
    }
}

