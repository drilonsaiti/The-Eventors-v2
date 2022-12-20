package com.example.theeventors.comperator;

import com.example.theeventors.model.CommentAndReplies;

import java.util.Comparator;

public  class CommentsOrderByCreateAt {

    public static Comparator<CommentAndReplies> byCreatedAt = Comparator.comparing(CommentAndReplies::getCreatedAt).reversed();
}
