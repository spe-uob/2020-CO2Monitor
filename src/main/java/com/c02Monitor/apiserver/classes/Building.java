package com.c02Monitor.apiserver.classes;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.FetchType;
import javax.persistence.CascadeType;
import javax.persistence.Embedded;
@Entity
public class Building {
    private long id;
    private String name;
    public List<Long> rooms;

    public Building(long id, String name, List<Long> rooms) {
        this.id = id;
        this.name = name;
        this.rooms = rooms;
    }


    
    public void AddRoom(Long room){ 
        for (Long x:getRooms()){
            if (!(x == room)){
                rooms.add(room);
            }
        } 
      
    }

    public void delRoom(long id){
        for (Long x:rooms){
            if (x == id){
                rooms.remove(x);
            }
        }
    }
    @Id
    public long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public List<Long> getRooms(){
        return rooms;
    }

    public Long getRoom(long id) {
        for (Long x:  getRooms()){
            if( x == id){
                return x;
            }
        }
        return null;
    }
    public void setName(String name){
        this.name = name;
    }
    public void setId(long id){
        this.id = id;
    }
    public void setRooms(List<Long> rooms){
        this.rooms = rooms;
    }
    

}

