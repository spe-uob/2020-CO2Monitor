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
    public void addSensor (Sensor sensor){
        this.sensors.add(sensor);
    }
    public long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public void delSensor(long id){
        for (Sensor x:sensors){
            if (x.getId() == id){
                sensors.remove(x);
            }
        }
    }

    public List<Sensor> getSensors() {
        return sensors;
    }
    public Sensor getSensor(long id) {
        for( Sensor x: getSensors()){
            if(x.getId() == id){
                return x;
            }
        }
        return null;
    }
    
}
