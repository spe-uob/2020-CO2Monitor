package com.c02Monitor.apiserver.controllers;

import com.c02Monitor.apiserver.classes.Building;
import com.c02Monitor.apiserver.classes.Room;
import com.c02Monitor.apiserver.classes.Sensor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import static com.c02Monitor.apiserver.controllers.TestController.getRawJson;

@RestController
@RequestMapping("/rooms")
public class RoomController {
    @GetMapping
    public List<Room> getAllRooms() {
        List<Building> data = getRawJson();
        return data.stream()
                .flatMap(x -> x.getRooms().stream())
                .map(x -> new Room(x.getId(), x.getName(), new ArrayList<Sensor>()))
                .collect(Collectors.toList());
    }

    @GetMapping(path = "/{roomId}")
    public Room getRoomDetail(@PathVariable() long roomId){
        List<Building> data = getRawJson();
        return data.stream()
                .flatMap(x -> x.getRooms().stream())
                .filter(x -> x.getId() == roomId)
                .collect(Collectors.toList()).get(0);
    }
}
