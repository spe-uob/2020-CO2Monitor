package com.c02Monitor.apiserver.controllers;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;


public class ParentController {

    @ExceptionHandler({SQLException.class, DataAccessException.class})
    public String handleException() {
        return "databaseError";
    }
    @ResponseStatus(value = HttpStatus.NOT_FOUND)
    public class NotFoundException extends RuntimeException {
        public NotFoundException() {
            super();
        }
        public NotFoundException(String message, Throwable cause) {
            super(message, cause);
        }
        public NotFoundException(String message) {
            super(message);
        }
        public NotFoundException(Throwable cause) {
            super(cause);
        }
    }

}
