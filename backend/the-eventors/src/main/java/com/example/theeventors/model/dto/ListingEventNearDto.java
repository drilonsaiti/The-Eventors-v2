package com.example.theeventors.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Comparator;
import java.util.Objects;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ListingEventNearDto implements Comparator<ListingEventNearDto>{
    Long id;

    String title;

    String coverImage;

    String location;

    double lat;
    double lng;

    double distance;

    String startDateTime;

    String agoCreated;
    String createdBy;
    String profileImage;

    Long categoryId;

    public static Comparator<ListingEventNearDto> byDistance = Comparator.comparing(ListingEventNearDto::getDistance) ;

    @Override
    public int compare(ListingEventNearDto o1, ListingEventNearDto o2) {
        if(o1.getDistance() > o2.getDistance())
            return -1;
        else if(o1.getDistance() < o2.getDistance())
            return 1;
        return 0;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof ListingEventNearDto that)) return false;
        return Double.compare(that.getDistance(), getDistance()) == 0;
    }

    @Override
    public int hashCode() {
        return Objects.hash(getDistance());
    }

    @Override
    public String toString() {
        return "ListingEventNearDto{" +
                "title='" + title + '\'' +
                ", distance=" + distance +
                '}';
    }
}
