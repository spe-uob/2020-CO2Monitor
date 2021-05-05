package com.c02Monitor.apiserver.security;

import lombok.Data;

import java.io.Serializable;

@Data
public class AuthResponse  implements Serializable {
    private final String token;

    public AuthResponse(String token) {
        this.token = token;
    }

}
