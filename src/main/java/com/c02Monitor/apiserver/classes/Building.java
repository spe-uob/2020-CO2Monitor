package com.c02Monitor.apiserver.classes;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;
import java.util.ArrayList;
import javax.persistence.Entity;
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

    public void AddData(long roomId, long sensorId, Data data){ // Must be a neater way of doing this.
        for (Room x: rooms){
            if( x.getId() == roomId){
                List<Sensor> tempSensors = x.getSensors();
                for(Sensor y: tempSensors){
                    if(y.getId() == sensorId){
                        y.addData(data);
                    }
                }
            }
        }
    }

    public void AddSensor(long roomId, Sensor sensor){
        for (Room x: rooms){
            if (x.getId() == roomId){
                x.addSensor(sensor);
                }
            }
        }
    
    public void AddRoom(Room room){ 
       rooms.add(room);
    }

    public long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public List<Room> getRooms(){
        return rooms;
    }

    public Room getRoom(long id) {
        for (Room x:  getRooms()){
            if( x.getId() == id){
                return x;
            }
        }
        return null;
    }
    public void setName(String name){
        this.name = name;
    }
    public void setId(long id){
        this.id = id;
    }
    public void setRooms(List<Room> rooms){
        this.rooms = rooms;
    }
    public void setRoom(Room room, long id, String name){
        Boolean match = false;
        for (Room x: rooms){
            if (x.getId() == id){
                x = room;
                match = true;
            }

        }
        if (!match){
            List<Sensor> newSensors = new ArrayList<Sensor>();;
            Room newRoom = new Room(id, name, newSensors);
            this.AddRoom(newRoom);
        }
    }
    
    public void setRoom(Room room, long id){ // overload for no name
        String name = "DefaultBuildingName";
        setRoom(room, id, name);
    }

}

