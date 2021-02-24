package com.c02Monitor.apiserver.classes;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;
import javax.persistence.*;
import javax.persistence.Column;
import javax.persistence.ElementCollection;

@Entity
public class Room {
    @Id
    private long id;
    private String name;
    @Column
    @ElementCollection()
    public List<Long> sensors;
    public Long building;

    public Room(long id, String name, List<Long> sensors, Long building) {
        this.id = id;
        this.name = name;
        this.sensors = sensors;
        this.building = building;
    }
    public void addSensor (Long sensor){
        this.sensors.add(sensor);
    }

    public long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public void delSensor(long id){
        for (Long x:sensors){
            if (x == id){
                sensors.remove(x);
            }
        }
    }

    public List<Long> getSensors() {
        return sensors;
    }

    
}
