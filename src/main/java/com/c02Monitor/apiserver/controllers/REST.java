package com.c02Monitor.apiserver.controllers;

import com.c02Monitor.apiserver.classes.Building;
import com.c02Monitor.apiserver.classes.Room;
import com.c02Monitor.apiserver.classes.Sensor;
import com.c02Monitor.apiserver.classes.Data;
import com.c02Monitor.apiserver.classes.BuildingRepository;

import java.util.List;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
class REST {

    private final BuildingRepository repository;

    REST(BuildingRepository repository) {
      this.repository = repository;
}


////////////////////////////////////////////////////////////////////////////////////////////////////////// GET ALL //////////////////////////////////////////////////////////////////////////////////////////////////////////

//@GetMapping("/buildings") // Get all buildings
  //List<Building> all() {
  //  return repository.findAllBuilding();
  //}

  @GetMapping("/buildings/{id}/rooms")// Get all rooms in a building
  List<Room> all(@PathVariable Long id) {
      return repository.findByBuilding(id);
  }

  @GetMapping("/buildings/{id}/rooms/{id2}/sensors")// Get all sensors in a room in a building
  List<Sensor> all(@PathVariable Long id, @PathVariable Long id2) {
    List<Sensor> x = repository.findByRoom(id2);
      for (Sensor y:x){
        if (y.building!= id){
          x.remove(y);
        }
      }
    return x;  
  }

  @GetMapping("/buildings/{id}/rooms/{id2}/sensors{id3}/data")// Get all data in a sensor in a room in a building
  List<Data> all(@PathVariable Long id, @PathVariable Long id2, @PathVariable Long id3) {
    List<Data> x = repository.findBySensor(id3);
      for (Data y:x){
        if (y.room!= id2 && y.building != id){
          x.remove(y);
        }
      }
    return x; 
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////// GET ONE //////////////////////////////////////////////////////////////////////////////////////////////////////////

  @GetMapping("/buildings/{id}") // Get a building
  Building one(@PathVariable Long id) {
    return repository.findBuildingById(id);
  }

  @GetMapping("/buildings/{id}/rooms/{id2}")// Get a room in a building
  Room one(@PathVariable Long id, @PathVariable Long id2) {
    return repository.findRoomById(id2);
  }

  @GetMapping("/buildings/{id}/rooms/{id2}/sensors/{id3}")// Get a sensor in a room in a building
  Sensor one(@PathVariable Long id, @PathVariable Long id2, @PathVariable Long id3) {
    return repository.findSensorById(id3);
  }

  @GetMapping("/buildings/{id}/rooms/{id2}/sensors{id3}/data/{id4}")// Get a datum in a sensor in a room in a building
  Data one(@PathVariable Long id, @PathVariable Long id2, @PathVariable Long id3, @PathVariable Long id4) {
    return repository.findDatumById(id4);
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////// ADD ONE //////////////////////////////////////////////////////////////////////////////////////////////////////////

  @PutMapping("/buildings/{id}")// Add or replace a building
  Building replaceBuilding(@RequestBody Building newBuilding, @PathVariable Long id) {
   return repository.save(newBuilding);
  }


@PutMapping("/buildings/{id}/rooms/{id2}")// Add or replace a room in a building
Room replaceRoom(@RequestBody Room newRoom, @PathVariable Long id,@PathVariable Long id2) {
  newRoom.building = id;
  return repository.save(newRoom);
}

@PutMapping("/buildings/{id}/rooms/{id2}/sensors/{id3}")// Add or replace a sensor in a room in a building
Sensor replaceSensor(@RequestBody Sensor newSensor, @PathVariable Long id,@PathVariable Long id2,@PathVariable Long id3) {
  newSensor.room = id2;
  newSensor.building = id;
  return repository.save(newSensor);
}

@PutMapping("/buildings/{id}/rooms/{id2}/sensors/{id3}/data/{id4}")// Add or replace a datum in a sensor in a room in a building
Data replaceDatum(@RequestBody Data newDatum, @PathVariable Long id,@PathVariable Long id2,@PathVariable Long id3,@PathVariable Long id4) {
  
  newDatum.sensor = id3;
  newDatum.room = id2;
  newDatum.building = id;
  return repository.save(newDatum);
}


}