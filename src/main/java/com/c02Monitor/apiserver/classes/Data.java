package com.c02Monitor.apiserver.classes;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.time.LocalDateTime;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Embeddable;


@Entity
public class Data {
    private long id;
    private LocalDateTime date;
    private float co2;
    public Long sensor;
    public Long room;
    public Long building;

    public Data(long id, LocalDateTime date, float co2, long sensor, Long room, Long building) {
        this.id = id;
        this.date = date;
        this.co2 = co2;
        this.sensor = sensor;
        this.room = room;
        this.building = building;
    }
    @Id
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
