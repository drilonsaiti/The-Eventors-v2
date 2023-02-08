package com.example.theeventors.model.exceptions;


import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(HttpStatus.PRECONDITION_FAILED)

public class EventAlreadyInShoppingCartException extends RuntimeException{
    public EventAlreadyInShoppingCartException(Long id, String username) {
        super(String.format("Product with id: %d already exists in shopping cart for user with username %s", id, username));
    }

}
