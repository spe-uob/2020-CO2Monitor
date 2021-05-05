package com.c02Monitor.apiserver.service;


import com.c02Monitor.apiserver.entity.User;
import com.c02Monitor.apiserver.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserService implements UserDetailsService {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private PasswordEncoder passwordEncoder;

    public User loadUserByUsername(String userName) throws UsernameNotFoundException {
        return userRepository.findByUsername(userName).orElseThrow(() -> new UsernameNotFoundException("Not found"));
    }
    public User create (User user){
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        return userRepository.save(user);
    }
}