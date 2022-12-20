package com.example.theeventors.model;

import com.example.theeventors.comperator.CommentsOrderByCreateAt;
import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

@Entity
@Data
@NoArgsConstructor
public class Comments {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    @ManyToOne
    CommentAndReplies comment;

    @ManyToMany
    List<CommentAndReplies> replies;

    public Comments(CommentAndReplies comment) {
        this.comment = comment;
        this.replies = new ArrayList<>();
    }
}
