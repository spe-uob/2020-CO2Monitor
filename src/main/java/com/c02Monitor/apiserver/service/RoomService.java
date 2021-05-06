package com.c02Monitor.apiserver.service;

import com.c02Monitor.apiserver.entity.Room;
import com.c02Monitor.apiserver.repository.RoomRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class RoomService {

    @Autowired
    private RoomRepository roomRepository;

    //GET
    public Optional<Room> getRoomById(long id){
        return roomRepository.findById(id);
    }

    public List<Room> getAllBuildingRoomsById(long id){
        return roomRepository.findByBuildingId(id);
    }

    public List<Room> getAllRooms(){
        return roomRepository.findAll();
    }

    //Create
    public Room createRoom(Room room){
        return roomRepository.save(room);
    }

    public void createManyRooms(List<Room> rooms){
        roomRepository.saveAll(rooms);
    }

    //UPDATE
    public Room updateRoom(Room room) {return roomRepository.save(room);}

    //DELETE
    public void deleteById(Long id) {roomRepository.deleteById(id);}
}
