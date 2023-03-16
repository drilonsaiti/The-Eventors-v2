package com.example.theeventors.model;

import com.example.theeventors.model.enumerations.NotificationTypes;
import lombok.Data;
import lombok.NoArgsConstructor;
import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.Objects;

@Data
@NoArgsConstructor
@Entity
public class NotificationInfo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;
    String toUser;
    @Column(length = 999)
    String receiverToken;
    String fromUser;
    String title;
    String message;
    LocalDateTime createAt;
    boolean read;
    NotificationTypes types;

    Long idEvent;
    Long idComment;

    public NotificationInfo(String to, String receiverToken, String from, String title, String message, LocalDateTime createAt, NotificationTypes types,Long idEvent,Long idComment) {
        this.toUser = to;
        this.receiverToken = receiverToken;
        this.fromUser = from;
        this.title = title;
        this.message = message;
        this.createAt = createAt;
        this.read = false;
        this.types = types;
        this.idEvent = idEvent;
        this.idComment = idComment;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof NotificationInfo that)) return false;
        return getCreateAt().equals(that.getCreateAt());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getCreateAt());
    }
}
