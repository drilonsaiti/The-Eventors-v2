package com.example.theeventors.service;


import com.example.theeventors.model.EventAddress;
import com.google.maps.errors.ApiException;

import java.io.IOException;

public interface EventAddressService {

    EventAddress create(String location) throws IOException, InterruptedException, ApiException;
    EventAddress update(Long id,String location) throws IOException, InterruptedException, ApiException;
}
