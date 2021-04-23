package com.c02Monitor.apiserver.entity;

import com.fasterxml.jackson.annotation.*;
import lombok.*;
import lombok.Data;


import javax.persistence.*;
import java.util.List;
import java.util.Set;


@Entity
@NoArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class Building {
    @Id
    @Getter
    @Setter
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Getter
    @Setter
    private String name;

    @OneToMany(mappedBy = "building", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonManagedReference
    @Setter
    private Set<Room> rooms;

    public Building(String name) {
        this.name = name;
    }

    @JsonIgnore
    public Set<Room> getRooms() {
        return rooms;
    }
}
