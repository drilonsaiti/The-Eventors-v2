package com.example.theeventors.model;


import com.example.theeventors.model.enumerations.Role;
import jakarta.persistence.*;
import lombok.Builder;
import lombok.Data;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;


@Data
@Entity
@Table(name = "eventors_users")
@OnDelete(action = OnDeleteAction.CASCADE)
public class User implements UserDetails {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;
    private String username;

    private String password;

    private String fullName;

    private String email;

    private String verifyCode;

    private String bio;
    @OneToOne(cascade = CascadeType.ALL, orphanRemoval = true)
    private Image profileImage;

    @ElementCollection
    List<String> following;
    @ElementCollection
    List<String> followers;

    @OneToMany(mappedBy = "user", fetch = FetchType.EAGER,orphanRemoval = true)
    private List<Bookmark> bookmarks;
    @OneToOne(cascade = CascadeType.ALL, orphanRemoval = true)

    private Notification notification;
    /*@OneToMany(fetch = FetchType.EAGER,orphanRemoval = true)
    private List<Event> events;*/

    private boolean isAccountNonExpired = true;
    private boolean isAccountNonLocked = true;
    private boolean isCredentialsNonExpired = true;
    private boolean isEnabled = true;

    @Enumerated(value = EnumType.STRING)
    private Role role;


    public User() {
    }

    public User(String username, String password, String email) {
        this.username = username;
        this.password = password;
        this.fullName = "" ;
        this.email = email;
        this.bio = "";
        this.role = Role.ROLE_USER;
        this.followers = new ArrayList<>();
        this.following = new ArrayList<>();
        this.profileImage = null;
        this.verifyCode = "";
       // this.events = new ArrayList<>();
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return Collections.singletonList(role);
    }

    @Override
    public boolean isAccountNonExpired() {
        return isAccountNonExpired;
    }

    @Override
    public boolean isAccountNonLocked() {
        return isAccountNonLocked;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return isCredentialsNonExpired;
    }

    @Override
    public boolean isEnabled() {
        return isEnabled;
    }
}


