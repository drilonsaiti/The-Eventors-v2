package com.example.theeventors.model.exceptions;


import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(HttpStatus.NOT_FOUND)
public class EventInfoNotFoundException extends RuntimeException{

    public EventInfoNotFoundException(Long id) {
        super(String.format("Information about event with id: %d was not found", id));
    }
}

