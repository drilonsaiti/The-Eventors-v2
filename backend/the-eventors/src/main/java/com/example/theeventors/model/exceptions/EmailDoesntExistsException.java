package com.example.theeventors.model.exceptions;

public class EmailDoesntExistsException extends RuntimeException{
    public EmailDoesntExistsException() {
        super(String.format("Email doesn't exists"));
    }
}
