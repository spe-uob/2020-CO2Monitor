package com.c02Monitor.apiserver.classes;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

public class Building {
    @JsonProperty("id")
    private long id;
    @JsonProperty("name")
    private String name;
    @JsonProperty("rooms")
    private List<Room> rooms;

    //for the json fake data
    public Building() {
        super();
    }

    public Building(long id, String name, List<Room> rooms) {
        this.id = id;
        this.name = name;
        this.rooms = rooms;
    }

    public long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public List<Room> getRooms() {
        return rooms;
    }
}
