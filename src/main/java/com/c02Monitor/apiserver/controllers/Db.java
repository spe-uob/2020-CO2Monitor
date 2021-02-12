package com.c02Monitor.apiserver.classes;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

public class Db {// Controller for interacting with a local mongodb instance
    private BuildingRepository repository;

    public addBuilding(Building x){
        repository.save(x)
    }

    

}
