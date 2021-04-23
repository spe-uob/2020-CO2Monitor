package com.c02Monitor.apiserver.entity;

import com.fasterxml.jackson.annotation.*;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.List;
import java.util.Set;

@Entity
@NoArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class Sensor {

    @Id
    @Getter
    @Setter
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Getter
    @Setter
    private String description;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JsonBackReference
    @Getter
    @Setter
    private Room room;

    @OneToMany(mappedBy = "sensor", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonManagedReference
    @Setter
    private Set<Reading> readings;

    public Sensor(long id, String description, Room room) {
        this.id = id;
        this.description = description;
        this.room = room;
    }

    @JsonIgnore
    public Set<Reading> getReadings() {
        return readings;
    }
}
