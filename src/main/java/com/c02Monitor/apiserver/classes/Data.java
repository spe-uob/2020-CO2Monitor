package com.c02Monitor.apiserver.classes;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.time.LocalDateTime;

public class Data {
    @JsonProperty("id")
    private long id;
    @JsonProperty("date")
    private LocalDateTime date;
    @JsonProperty("co2")
    private float co2;

    //for the json fake data
    public Data() {
        super();
    }

    public Data(long id, LocalDateTime date, float co2) {
        this.id = id;
        this.date = date;
        this.co2 = co2;
    }

    public long getId() {
        return id;
    }

    public LocalDateTime getDate() {
        return date;
    }

    public float getCo2() {
        return co2;
    }
}
