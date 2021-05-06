package com.c02Monitor.apiserver.entity;

import com.fasterxml.jackson.annotation.*;
import lombok.*;

import javax.persistence.*;
import java.util.Set;

@Entity
@NoArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class Room {
    @Id
    @Getter
    @Setter
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Getter
    @Setter
    private String name;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JsonBackReference
    @Getter
    @Setter
    private Building building;

    @OneToMany(mappedBy = "room", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonManagedReference
    @Setter
    private Set<Sensor> sensors;

    public Room(String name, Building building) {
        this.name = name;
        this.building = building;
    }

    @JsonIgnore
    public Set<Sensor> getSensors() {
        return sensors;
    }
}
