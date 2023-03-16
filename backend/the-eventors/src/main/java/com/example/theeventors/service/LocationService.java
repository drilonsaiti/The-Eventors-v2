package com.example.theeventors.service;

import com.google.maps.errors.ApiException;

import java.io.IOException;

public interface LocationService {

    double getDistance(double eLat,double eLng,double lat,double lng) ;
}
