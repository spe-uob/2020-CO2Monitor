package com.c02Monitor.apiserver.controllers;

import com.c02Monitor.apiserver.security.AuthRequest;
import com.c02Monitor.apiserver.security.AuthResponse;
import com.c02Monitor.apiserver.utils.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.AuthenticationException;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/auth")
public class AuthController {
    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private JwtUtil jwtTokenUtil;

    @GetMapping("")
    public ResponseEntity<?> keyChecker(){
        return new ResponseEntity<>("Valid Key", HttpStatus.ACCEPTED);
    }

    @PostMapping("")
    public ResponseEntity<?> createAuthenticationToken(@RequestBody AuthRequest authenticationRequest) throws Exception {
        try {
            var authentication = authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(authenticationRequest.getUsername(), authenticationRequest.getPassword())
            );
            final String token = jwtTokenUtil.createToken(authentication);
            return ResponseEntity.ok(new AuthResponse(token));
        }
        catch (AuthenticationException e) {
            return new ResponseEntity<>("Invalid username/password supplied", HttpStatus.UNAUTHORIZED);
        }
    }
}
