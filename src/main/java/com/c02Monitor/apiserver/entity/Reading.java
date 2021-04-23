package com.c02Monitor.apiserver.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDateTime;


@Entity
@NoArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class Reading {
    @Id
    @Getter
    @Setter
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Getter
    @Setter
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss'Z'")
    private LocalDateTime date;

    @Getter
    @Setter
    private int co2;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JsonBackReference
    @Getter
    @Setter
    private Sensor sensor;

    public Reading(LocalDateTime date, int co2, Sensor sensor) {
        this.date = date;
        this.co2 = co2;
        this.sensor = sensor;
    }

    @Override
    public String toString() {
        return "Reading{" +
                "id=" + id +
                ", date=" + date +
                ", co2=" + co2 +
                ", sensor=" + sensor.getId() +
                '}';
    }
}
