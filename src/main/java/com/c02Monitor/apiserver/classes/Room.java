package com.c02Monitor.apiserver.classes;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

public class Room {
    @JsonProperty("id")
    private long id;
    @JsonProperty("name")
    private String name;
    @JsonProperty("sensors")
    private List<Sensor> sensors;

    //for the json fake data
    public Room() {
        super();
    }

    public Room(long id, String name, List<Sensor> sensors) {
        this.id = id;
        this.name = name;
        this.sensors = sensors;
    }
    public long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public List<Sensor> getSensors() {
        return sensors;
    }
}
