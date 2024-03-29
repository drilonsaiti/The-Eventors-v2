package com.example.theeventors.config.auth;

import com.example.theeventors.model.enumerations.Role;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class RegisterRequest {

  private String username;

  private String password;

  private String repeatPassword;

  private String email;


}
