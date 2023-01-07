package com.example.theeventors.model.exceptions;


import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(HttpStatus.NOT_FOUND)
public class GuestNotFoundException extends RuntimeException{

    public GuestNotFoundException(Long id) {
        super(String.format("Guest with id: %d was not found", id));
    }
}

