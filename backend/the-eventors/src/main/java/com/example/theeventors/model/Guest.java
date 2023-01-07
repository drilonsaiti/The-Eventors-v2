package com.example.theeventors.model;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Entity
@Data
public class Guest {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    @ElementCollection
    List<String> withUsername;

    @ElementCollection
    List<String> withNameAndSurname;

    public Guest() {
        this.withUsername = new ArrayList<>();
        this.withNameAndSurname = new ArrayList<>();
    }

    public String getGuests(){
        StringBuilder sb = new StringBuilder();
        for (String s : this.withUsername){
            sb.append(s).append(",");
        }
        for (String s : this.withNameAndSurname){
            sb.append(s).append(",");
        }
        return sb.delete(sb.length()-1,sb.length()).toString();
    }
}
