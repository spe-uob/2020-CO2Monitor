package com.c02Monitor.apiserver.controllers;

import com.c02Monitor.apiserver.classes.Building;
import com.c02Monitor.apiserver.classes.Room;
import com.c02Monitor.apiserver.classes.Sensor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import static com.c02Monitor.apiserver.controllers.TestController.getRawJson;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/buildings")
public class BuildingController {

    private List<Room> dataConditioner(List<Room> rooms){

        return rooms.stream().map(x -> new Room(x.getId(), x.getName(), new ArrayList<Sensor>())).collect(Collectors.toList());
    }

    @GetMapping
    public List<Building> getAllBuildings() {

        List<Building> data = getRawJson();
        return data.stream().map(x -> new Building(x.getId(), x.getName(), new ArrayList<Room>()))
                .collect(Collectors.toList());
    }

    @GetMapping(path = "/{buildingId}")
    public Building getBuildingDetail(@PathVariable() long buildingId){
        List<Building> data = getRawJson();
        return data.stream()
                .filter(x -> x.getId() == buildingId)
                .map(x ->  new Building(x.getId(), x.getName(), dataConditioner(x.getRooms())))
                .collect(Collectors.toList()).get(0);
    }
}
