package com.example.theeventors.service.impl;

import com.example.theeventors.model.EventAddress;
import com.example.theeventors.repository.EventAddressRepositorty;
import com.example.theeventors.service.EventAddressService;
import com.google.maps.GeoApiContext;
import com.google.maps.GeocodingApi;
import com.google.maps.errors.ApiException;
import com.google.maps.model.GeocodingResult;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.io.IOException;

@AllArgsConstructor
@Service
public class EventAddressServiceImpl implements EventAddressService {
    private final EventAddressRepositorty addressRepositorty;

    @Override
    public EventAddress create(String location) throws IOException, InterruptedException, ApiException {
        GeoApiContext context = new GeoApiContext.Builder()
                .apiKey("AIzaSyC7l_4GjrSdkBAWNxvvZRCvbFuJ7dQ5Oe4")
                .build();
        GeocodingResult[] results = GeocodingApi.geocode(context,
                location).await();
        double lat = results[0].geometry.location.lat;
        double lng = results[0].geometry.location.lng;

        return this.addressRepositorty.save(new EventAddress(location,lat,lng));
    }

    @Override
    public EventAddress update(Long id, String location) throws IOException, InterruptedException, ApiException {
        EventAddress e = this.addressRepositorty.findById(id).orElseThrow();
        double lat = 0.0;
        double lng = 0.0;
        if (!e.getLocation().equals(location)){
            GeoApiContext context = new GeoApiContext.Builder()
                    .apiKey("AIzaSyC7l_4GjrSdkBAWNxvvZRCvbFuJ7dQ5Oe4")
                    .build();
            GeocodingResult[] results = GeocodingApi.geocode(context,
                    location).await();
             lat = results[0].geometry.location.lat;
             lng = results[0].geometry.location.lng;
            e.setLocation(location);
            e.setLat(lat);
            e.setLng(lng);
        }
        return this.addressRepositorty.save(e);

    }
}
