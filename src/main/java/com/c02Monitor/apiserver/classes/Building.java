package com.c02Monitor.apiserver.classes;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class Building {
    @JsonProperty("id")
    private @Id long id;
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
        for x in rooms{
            if x.getId() == roomId{
                tempRoom = x;
                Sensor[] tempSensors = x.getSensors();
                for y in tempSensors{
                    if y.getId() == sensorId{
                        y.addData(data)
                    }
                }
            }
        }
    }

    public AddSensor(long roomId, Sensor sensor){
        for x in rooms{
            if x.getId() == roomId{
                x.addSensor(sensor)
                }
            }
        }
    }
    public AddRoom(Room room){ 
       rooms.append(room)
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

    public Room getRoom(long id) {
        for x in getRooms(){
            if x.getId() == id{
                return x
            }
        }
        else return null
    }
}
