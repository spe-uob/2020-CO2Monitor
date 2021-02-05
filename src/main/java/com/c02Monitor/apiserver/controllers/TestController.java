package com.c02Monitor.apiserver.controllers;


import com.c02Monitor.apiserver.classes.Building;

import com.c02Monitor.apiserver.classes.Data;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.io.InputStream;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

@RestController
@RequestMapping("/test")
public class TestController {

    @GetMapping
    public static List<Building> getRawJson(){
        ObjectMapper objectMapper = new ObjectMapper();
        TypeReference<List<Building>> typeReference = new TypeReference<List<Building>>(){};
        InputStream inputStream = TypeReference.class.getResourceAsStream("/json/buildings.json");
        List<Building> lst = new ArrayList<Building>();
        try {
            List<Building> buildings = objectMapper.readValue(inputStream, typeReference);
            lst.addAll(buildings);

        } catch (IOException e) {
            e.printStackTrace();
        }
        return lst;
    }

    public static List<Data> generateSensorData(int max){
        List<Data> dataLst = new ArrayList<Data>();

        Random rand = new Random();
//        int max = rand.nextInt(10);
        for (int i = 0; i < max; i++){
            LocalDateTime date = LocalDateTime.now();
            Data data = new Data(i, date.minusMinutes(i*5), rand.nextInt(100));
            dataLst.add(data);
        }
        return dataLst;
    }
}
