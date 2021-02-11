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

    public AddData(long roomId, long sensorId, Data data){ // Must be a neater way of doing this.
        tempRoom = new Room();
        tempSensor = new Sensor();
        for x in rooms{
            if x.id == roomId{
                tempRoom = x;
                for y in tempRoom.sensors{
                    if y.id == sensorId{
                        y.data.append(data)
                    }
                }
            }
        }
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
