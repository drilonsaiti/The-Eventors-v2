package com.example.theeventors.model.exceptions;

public class VerificationCodeDoNotMatchException extends RuntimeException{

    public VerificationCodeDoNotMatchException() {
        super("Verification code do not match.");
    }
}
