package com.example.theeventors.model.exceptions;


import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(HttpStatus.NOT_FOUND)
public class BookmarkNotFoundException extends RuntimeException{

    public BookmarkNotFoundException(Long id) {
        super(String.format("Activity with id: %d was not found", id));
    }
}

