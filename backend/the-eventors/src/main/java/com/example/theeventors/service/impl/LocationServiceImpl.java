package com.example.theeventors.service.impl;

import com.example.theeventors.service.LocationService;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.maps.GeoApiContext;
import com.google.maps.GeocodingApi;
import com.google.maps.errors.ApiException;
import com.google.maps.model.GeocodingResult;
import org.springframework.stereotype.Service;

import java.io.IOException;

@Service
public class LocationServiceImpl implements LocationService {
    @Override
    public double getDistance(double eLat,double eLng,double lat,double lng)  {


        double dist = 0.0;
            double theta = eLng - lng;
            dist = Math.sin(Math.toRadians(eLat)) * Math.sin(Math.toRadians(lat)) + Math.cos(Math.toRadians(eLat)) * Math.cos(Math.toRadians(lat)) * Math.cos(Math.toRadians(theta));
            dist = Math.acos(dist);
            dist = Math.toDegrees(dist);
            dist = dist * 60 * 1.1515;
            dist = dist * 1.609344;


        return dist;
    }
}
