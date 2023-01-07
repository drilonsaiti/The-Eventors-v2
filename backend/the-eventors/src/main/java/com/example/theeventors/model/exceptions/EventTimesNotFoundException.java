package com.example.theeventors.model.exceptions;


import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(HttpStatus.NOT_FOUND)
public class EventTimesNotFoundException extends RuntimeException{

    public EventTimesNotFoundException(Long id) {
        super(String.format("Information about times for event with id: %d was not found", id));
    }
}

