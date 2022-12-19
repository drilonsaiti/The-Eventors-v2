package com.example.theeventors.model;

import java.util.List;

public class Event {
    Long id;
    EventInfo eventInfo;
    EventTimes eventTimes;
    List<Guest> guests;
    Participant participant;
    List<Comment> comments;
}
