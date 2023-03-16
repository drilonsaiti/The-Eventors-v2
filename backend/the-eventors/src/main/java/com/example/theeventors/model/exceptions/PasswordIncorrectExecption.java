package com.example.theeventors.model.exceptions;

public class PasswordIncorrectExecption extends RuntimeException{

    public PasswordIncorrectExecption() {
        super("Password incorrect.");
    }
}