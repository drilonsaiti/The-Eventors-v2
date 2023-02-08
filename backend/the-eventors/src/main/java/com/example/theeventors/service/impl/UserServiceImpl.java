package com.example.theeventors.service.impl;

import com.example.theeventors.model.User;
import com.example.theeventors.model.dto.UserUsernameDto;
import com.example.theeventors.model.enumerations.Role;
import com.example.theeventors.model.exceptions.InvalidUsernameOrPasswordException;
import com.example.theeventors.model.exceptions.PasswordsDoNotMatchException;
import com.example.theeventors.model.exceptions.UsernameAlreadyExistsException;
import com.example.theeventors.model.mapper.UserUsernameMapper;
import com.example.theeventors.repository.EventRepository;
import com.example.theeventors.repository.UserRepository;
import com.example.theeventors.service.UserService;
import lombok.AllArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

   private final UserUsernameMapper mapper;

    @Override
    public UserDetails loadUserByUsername(String s) throws UsernameNotFoundException {
        return userRepository.findByUsername(s).orElseThrow(()->new UsernameNotFoundException(s));
    }

    @Override
    public void followingUser(String usernameFollowing,String usernameFollow) {
        User user = this.userRepository.findByUsername(usernameFollowing).orElseThrow(() -> new UsernameNotFoundException(usernameFollowing));
        User userFollow = this.userRepository.findByUsername(usernameFollow).orElseThrow(() -> new UsernameNotFoundException(usernameFollow));
        user.getFollowing().add(usernameFollow);
        userFollow.getFollowers().add(usernameFollowing);
        this.userRepository.save(user);
        this.userRepository.save(userFollow);

    }

    @Override
    public void unFollowingUser(String usernameFollowing, String usernameFollow) {
        User user = this.userRepository.findByUsername(usernameFollowing).orElseThrow(() -> new UsernameNotFoundException(usernameFollowing));
        User userFollow = this.userRepository.findByUsername(usernameFollow).orElseThrow(() -> new UsernameNotFoundException(usernameFollow));

        user.getFollowing().removeIf(f -> f.equals(usernameFollow));
        userFollow.getFollowers().removeIf(f -> f.equals(usernameFollowing));

        this.userRepository.save(user);
        this.userRepository.save(userFollow);

    }

    @Override
    public List<UserUsernameDto> findAll() {
        return this.userRepository.findAll()
                .stream()
                .map(mapper).collect(Collectors.toList());
    }


    @Override
    public User register(String username, String password, String repeatPassword, String name, String surname, Role userRole) {
        if (username==null || username.isEmpty()  || password==null || password.isEmpty())
            throw new InvalidUsernameOrPasswordException();
        if (!password.equals(repeatPassword))
            throw new PasswordsDoNotMatchException();
        if(this.userRepository.findByUsername(username).isPresent())
            throw new UsernameAlreadyExistsException(username);
        User user = new User(username,passwordEncoder.encode(password),name,surname,userRole);
        return userRepository.save(user);
    }


}

