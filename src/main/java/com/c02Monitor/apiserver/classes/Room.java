package com.c02Monitor.apiserver.classes;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.FetchType;
import javax.persistence.CascadeType;
import javax.persistence.Embeddable;
import javax.persistence.Embedded;
@Entity
public class Room {
    private long id;
    private String name;
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
    @Id
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
