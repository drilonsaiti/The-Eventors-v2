package com.example.theeventors.service.impl;

import com.example.theeventors.config.JwtService;
import com.example.theeventors.config.auth.AuthenticationService;
import com.example.theeventors.model.Image;
import com.example.theeventors.model.MyActivity;
import com.example.theeventors.model.User;
import com.example.theeventors.model.dto.*;
import com.example.theeventors.model.enumerations.Role;
import com.example.theeventors.model.exceptions.*;
import com.example.theeventors.model.mapper.UserUsernameMapper;
import com.example.theeventors.repository.EventRepository;
import com.example.theeventors.repository.ImageRepository;
import com.example.theeventors.repository.MyActivityRepository;
import com.example.theeventors.repository.UserRepository;
import com.example.theeventors.service.UserService;
import com.sun.mail.util.MailSSLSocketFactory;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.*;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    private final UserUsernameMapper mapper;

    private final JwtService jwtService;
    private JavaMailSender mailSender;

    private final EventRepository eventRepository;
    private final ImageRepository imageRepository;


    @Override
    public UserDetails loadUserByUsername(String s) throws UsernameNotFoundException {
        return userRepository.findByUsername(s).orElseThrow(() -> new UsernameNotFoundException(s));
    }

    @Override
    public void followingUser(String usernameFollowing, String usernameFollow) {
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
    public int countFollowing(String token) {
        User u = this.userRepository.findByUsername(jwtService.extractUsername(token)).orElseThrow();
        return u.getFollowing().size();
    }

    @Override
    public List<UserUsernameDto> findAllDiscoverUsers(String token) {
        User u = this.userRepository.findByUsername(jwtService.extractUsername(token)).orElseThrow();
        List<User> add = new ArrayList<>();
        for (User us : this.userRepository.findAll()) {
            String following = us.getUsername();
            if (!u.getUsername().equals(following) && u.getFollowing().stream().noneMatch(f -> f.equals(following)) && (u.getRole() != Role.ROLE_ADMIN && u.getRole() != Role.ROLE_EDITOR)) {
                add.add(us);
            }
        }
        return add
                .stream()
                .map(mapper).collect(Collectors.toList());
    }


    @Override
    public User register(String username, String password, String repeatPassword, String email) {
        if (username == null || username.isEmpty() || password == null || password.isEmpty())
            throw new InvalidUsernameOrPasswordException();
        if (!password.equals(repeatPassword))
            throw new PasswordsDoNotMatchException();
        if (this.userRepository.findByUsername(username).isPresent())
            throw new UsernameAlreadyExistsException(username);
        if (this.userRepository.findByEmail(email).isPresent())
            throw new EmailAlreadyExistsException(email);
        User user = new User(username, passwordEncoder.encode(password), email);
        return userRepository.save(user);
    }

    @Override
    public UserUsernameDto findUser(String token) {
        String username = jwtService.extractUsername(token);
        return this.userRepository.findByUsername(username)
                .map(mapper).get();
    }

    @Override
    public UserProfileDto findUserProfile(String username) {
        User user = this.userRepository.findByUsername(username).orElseThrow(() -> new UserNotFoundException(username));
        String photo = user.getProfileImage() != null ? user.getProfileImage().getImageBase64().replaceAll("data:application/octet-stream;base64,"
                , "") : "";
        return new UserProfileDto(user.getUsername(), photo, user.getFullName(),user.getBio(),
                this.eventRepository.findAllByEventInfo_CreatedBy(username).size(), user.getFollowers().size(), user.getFollowing().size());

    }


    @Override
    public boolean isFollowing(String token, String username) {
        User user = this.userRepository.findByUsername(username).orElseThrow(() -> new UserNotFoundException(username));
        User following = this.userRepository.findByUsername(token).orElseThrow(() -> new UserNotFoundException(username));

        return following.getFollowing().stream().anyMatch(f -> f.equals(user.getUsername()));
    }

    @Override
    public void changeUsername(ChangeUsernameDto change) {
        User u = this.userRepository.findByUsername(jwtService.extractUsername(change.getToken())).orElseThrow(() -> new UsernameNotFoundException(jwtService.extractUsername(change.getToken())));

        if (passwordEncoder.matches(change.getPassword(), u.getPassword())) {
            System.out.println(passwordEncoder.matches(change.getPassword(), u.getPassword()));
            if (this.userRepository.findByUsername(change.getNewUsername()).isEmpty()) {
                u.setUsername(change.getNewUsername());
                this.userRepository.save(u);

            } else {
                throw new UsernameAlreadyExistsException(change.getNewUsername());
            }
        } else {
            throw new PasswordIncorrectExecption();
        }
    }

    @Override
    public void changePassword(ChangePasswordDto change) {
        User u = this.userRepository.findByUsername(jwtService.extractUsername(change.getToken())).orElseThrow(() -> new UsernameNotFoundException(jwtService.extractUsername(change.getToken())));
        if (passwordEncoder.matches(change.getOldPassword(), u.getPassword())) {
            if (change.getNewPassword().equals(change.getRepeatedPassword())) {
                u.setPassword(passwordEncoder.encode(change.getNewPassword()));
            } else {
                throw new PasswordsDoNotMatchException();
            }
        } else {
            throw new PasswordsDoNotMatchException();

        }
        this.userRepository.save(u);
    }

    @Override
    public void forgetPassword(ForgotPassword dto) {
        User u = null;
        if (dto.getToken() != "" && dto.getToken() != null) {
            u = userRepository.findByUsername(jwtService.extractUsername(dto.getToken()))
                    .orElseThrow(() -> new UsernameNotFoundException(jwtService.extractUsername(dto.getToken())));

            if (!u.getEmail().equals(dto.getEmail())) {
                throw new EmailDoesntExistsException();
            }

        } else {
            u = userRepository.findByEmail(dto.getEmail())
                    .orElseThrow(EmailDoesntExistsException::new);
        }
        if (!dto.getNewPassword().equals(dto.getRepeatedPassword())) {
            throw new PasswordsDoNotMatchException();
        }
        if (!u.getVerifyCode().equals(dto.getVerifyCode())) {
            throw new VerificationCodeDoNotMatchException();
        }


        u.setPassword(passwordEncoder.encode(dto.getNewPassword()));
        this.userRepository.save(u);
    }

    @Override
    public void changeEmail(ChangeEmailDto change) {
        User u = this.userRepository.findByUsername(jwtService.extractUsername(change.getToken())).orElseThrow(() -> new UsernameNotFoundException(jwtService.extractUsername(change.getToken())));
        if (passwordEncoder.matches(change.getPassword(), u.getPassword())) {
            if (change.getVerifyCode().equals(u.getVerifyCode())) {
                u.setEmail(change.getNewEmail());
                u.setVerifyCode("");
            } else {
                throw new VerificationCodeDoNotMatchException();
            }
        } else {
            throw new PasswordIncorrectExecption();
        }
        this.userRepository.save(u);
    }

    @Override
    public void deleteAccount(String token) {
        User u = this.userRepository.findByUsername(jwtService.extractUsername(token)).orElseThrow(() -> new UsernameNotFoundException(jwtService.extractUsername(token)));
        this.userRepository.delete(u);
    }


    @Override
    public void addProfileImage(AddProfileImageDto dto) throws IOException {
        User u = this.userRepository.findByUsername(jwtService.extractUsername(dto.getToken())).orElseThrow(() -> new UsernameNotFoundException(jwtService.extractUsername(dto.getToken())));
        Image cImage = imageRepository.save(Image.builder()
                .name(dto.getProfileImage().getOriginalFilename())
                .type(dto.getProfileImage().getContentType())
                .imageBase64(String.format("data:%s;base64,%s", dto.getProfileImage().getContentType(),
                        Base64.getEncoder().encodeToString(dto.getProfileImage().getBytes()))).build());
        u.setProfileImage(cImage);
        this.userRepository.save(u);

    }

    @Override
    public void removeProfileImage(TokenDto dto) {
        User u = this.userRepository.findByUsername(jwtService.extractUsername(dto.getToken())).orElseThrow(() -> new UsernameNotFoundException(jwtService.extractUsername(dto.getToken())));
        Image image = u.getProfileImage();
        u.setProfileImage(null);
        this.userRepository.save(u);
        this.imageRepository.delete(image);
    }

    @Override
    public String extractEmail(String extractUsername) {
        User u = this.userRepository.findByUsername(extractUsername).orElseThrow();
        return u.getEmail();
    }

    @Override
    public void sendVerificationEmail(VerificationDto dto) throws MessagingException, IOException, GeneralSecurityException {
        String rootPath = Thread.currentThread().getContextClassLoader().getResource("").getPath();
        String appConfigPath = rootPath + "application.properties";
        Properties appProps = new Properties();
        appProps.load(new FileInputStream(appConfigPath));
        MailSSLSocketFactory sf = new MailSSLSocketFactory();
        sf.setTrustAllHosts(true);
        appProps.put("mail.smtp .ssl.trust", "*");
        appProps.put("mail.smtp .ssl.socketFactory", sf);
        User u = null;
        if (dto.getToken() != null) {
            String username = jwtService.extractUsername(dto.getToken());
            u = this.userRepository.findByUsername(username).orElseThrow(() -> new UsernameNotFoundException(username));

        } else {
            u = this.userRepository.findByEmail(dto.getEmail()).orElseThrow(EmailDoesntExistsException::new);

        }
        String toAddress = u.getEmail();
        String fromAddress = "the.eventors.app@gmail.com";
        String senderName = "The eventors";
        String subject = "The eventors - The OTP verification code";
        String content = "Dear [[name]],<br/>"
                + "Below is your verification code:<br/>"
                + "<h3>[[code]]</h3>"
                + "Thank you,<br/>"
                + "The eventors.";
       /* SimpleMailMessage message = new SimpleMailMessage();

        message.setFrom(fromAddress);
        message.setTo(toAddress);
        content = content.replace("[[name]]", u.getUsername());
        Random rand = new Random();
        content = content.replace("[[code]]",String.format("%04d", rand.nextInt(9999)));
        message.setSubject(subject);
        message.setText(content);

        mailSender.send(message);*/
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message);

        helper.setFrom(fromAddress, senderName);
        helper.setTo(toAddress);
        helper.setSubject(subject);

        content = content.replace("[[name]]", u.getUsername());
        Random rand = new Random();
        String code = String.format("%04d", rand.nextInt(9999));
        content = content.replace("[[code]]", code);
        u.setVerifyCode(code);
        this.userRepository.save(u);
        helper.setText(content, true);

        mailSender.send(message);
    }

    @Override
    public void updateProfile(UpdateProfileDto dto) {
        String username = jwtService.extractUsername(dto.getToken());
        System.out.println(dto.getBio());
       User u = this.userRepository.findByUsername(username).orElseThrow(() -> new UsernameNotFoundException(username));
        if(dto.getFullName() != ""){
            u.setFullName(dto.getFullName());
        }

        if(dto.getBio() != ""){
            u.setBio(dto.getBio());
        }

        this.userRepository.save(u);
    }

    @Override
    public List<String> myFollowing(String token) {
        String username = jwtService.extractUsername(token);
        User u = this.userRepository.findByUsername(username).orElseThrow(() -> new UsernameNotFoundException(username));

        return u.getFollowing();
    }

    @Override
    public List<String> myFollowers(String token) {
        String username = jwtService.extractUsername(token);
        User u = this.userRepository.findByUsername(username).orElseThrow(() -> new UsernameNotFoundException(username));

        return u.getFollowers();
    }

    @Override
    public List<UserUsernameDto> findAllMyFollowing(String token) {
        String username = jwtService.extractUsername(token);
        User u = this.userRepository.findByUsername(username).orElseThrow(() -> new UsernameNotFoundException(username));
            List<User> add = new ArrayList<>();
            for (String us : u.getFollowing()) {
                User follow = this.userRepository.findByUsername(us).orElseThrow(() -> new UsernameNotFoundException(username));
                add.add(follow);
            }
            return add
                    .stream()
                    .map(mapper).collect(Collectors.toList());

    }

    @Override
    public List<UserUsernameDto> findAllMyFollowers(String token) {
        String username = jwtService.extractUsername(token);
        User u = this.userRepository.findByUsername(username).orElseThrow(() -> new UsernameNotFoundException(username));
        List<User> add = new ArrayList<>();
        for (String us : u.getFollowers()) {
            User follow = this.userRepository.findByUsername(us).orElseThrow(() -> new UsernameNotFoundException(username));
            add.add(follow);
        }
        return add
                .stream()
                .map(mapper).collect(Collectors.toList());

    }
}

