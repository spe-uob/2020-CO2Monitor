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
public class Sensor {
    @JsonProperty("id")
    private long id;
    @JsonProperty("description")
    private String description;
    @JsonProperty("data")
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
    @Id
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
