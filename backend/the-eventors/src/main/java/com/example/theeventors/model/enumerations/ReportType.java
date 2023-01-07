package com.example.theeventors.model.enumerations;

public enum ReportType {
    NUDITY("Nudity"),
    VIOLENCE("Violence"),
    HARASSMENT("Harassment"),
    SUICIDE_OR_SELFT_INJRUY("Suicide or self-injury"),
    FALSE_EVENT("False event"),
    SPAM("Spam"),
    HATE_SPEECH("Hate speech"),
    TERRORISM("Terrorism");

    public final String label;
    ReportType(String label) {
        this.label = label;
    }
}
