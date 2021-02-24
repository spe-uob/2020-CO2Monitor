package com.c02Monitor.apiserver.classes;

import com.fasterxml.jackson.annotation.JsonProperty;
import java.util.List;

public class Sensor {
    @JsonProperty("id")
    private long id;
    @JsonProperty("description")
    private String description;
    @JsonProperty("data")
    private List<Data> data;

    //for the json fake data
    public Sensor() {
        super();
    }

    public Sensor(long id, String description, List<Data> data) {
        this.id = id;
        this.description = description;
        this.data = data;
    }

    public void addData (Data data){
        this.data.add(data);
    }

    public long getId() {
        return id;
    }

    public String getDescription() {
        return description;
    }

    public List<Data> getData() {
        return data;
    }

    public void delDatum(long id){
        for (Data x:data){
            if (x.getId() == id){
                data.remove(x);
            }
        }
    }

    public void setData(List<Data> data){
        this.data = data;
    }

    public Data getDatum(long id) {
        for (Data x : getData()){
            if (x.getId() == id){
                return x;
            }
        }
        return null;
    }
}
