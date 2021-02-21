package com.c02Monitor.apiserver.classes;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

public class Room {
    @JsonProperty("id")
    private long id;
    @JsonProperty("name")
    private String name;
    @JsonProperty("devices")
    private List<Device> devices;

    //for the json fake data
    public Room() {
        super();
    }

    public Room(long id, String name, List<device> devices) {
        this.id = id;
        this.name = name;
        this.devices = devices;
    }
    public adddevice (device device){
        this.devices.append(device);
    }
    public long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public List<device> getdevices() {
        return devices;
    }
}
