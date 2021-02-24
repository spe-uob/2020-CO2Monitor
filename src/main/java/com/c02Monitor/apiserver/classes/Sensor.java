package com.c02Monitor.apiserver.classes;

import com.fasterxml.jackson.annotation.JsonProperty;
import java.util.List;
import javax.persistence.*;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
@Entity
public class Sensor {
    @Id
    private long id;
    private String description;
    @Column
    @ElementCollection()
    public List<Long> data;
    public Long room;
    public Long building;

    public Sensor(long id, String description, List<Long> data, long room, long building) {
        this.id = id;
        this.description = description;
        this.data = data;
        this.room = room;
        this.building = building;
    }

    public void addData (Long data){
        this.data.add(data);
    }

    public long getId() {
        return id;
    }

    public String getDescription() {
        return description;
    }

    public List<Long> getData() {
        return data;
    }

    public void delDatum(long id){
        for (Long x:data){
            if (x == id){
                data.remove(x);
            }
        }
    }

    public void setData(List<Long> data){
        this.data = data;
    }

    public Long getDatum(long id) {
        for (Long x : getData()){
            if (x == id){
                return x;
            }
        }
        return null;
    }
}
