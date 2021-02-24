package com.c02Monitor.apiserver.controllers;

import com.c02Monitor.apiserver.classes.*;

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

  private final BuildingRepository buildingRepository;
  private final RoomRepository roomRepository;
  private final SensorRepository sensorRepository;
  private final DataRepository dataRepository;

  REST(BuildingRepository buildingRepository, RoomRepository roomRepository, SensorRepository sensorRepository, DataRepository dataRepository) {
    this.buildingRepository = buildingRepository;
    this.roomRepository = roomRepository;
    this.sensorRepository = sensorRepository;
    this.dataRepository = dataRepository;
  }


////////////////////////////////////////////////////////////////////////////////////////////////////////// GET ALL //////////////////////////////////////////////////////////////////////////////////////////////////////////

  @GetMapping("/buildings")
    // Get all buildings
  List<Building> all() {
    return buildingRepository.findAll();
  }

  @GetMapping("/buildings/{id}/rooms")
// Get all rooms in a building
  List<Room> all(@PathVariable Long id) {
    List<Room> x = roomRepository.findAll();
    for (Room y : x) {
      if (y.building != id) {
        x.remove(y);
      }
    }
    return x;
  }

  @GetMapping("/buildings/{id}/rooms/{id2}/sensors")
// Get all sensors in a room in a building
  List<Sensor> all(@PathVariable Long id, @PathVariable Long id2) {
    List<Sensor> x = sensorRepository.findAll();
    for (Sensor y : x) {
      if (y.building != id || y.room != id2) {
        x.remove(y);
      }
    }
    return x;
  }

  @GetMapping("/buildings/{id}/rooms/{id2}/sensors{id3}/data")
// Get all data in a sensor in a room in a building
  List<Data> all(@PathVariable Long id, @PathVariable Long id2, @PathVariable Long id3) {
    List<Data> x = dataRepository.findAll();
    for (Data y : x) {
      if (y.building != id || y.room != id2 || y.sensor != id3) {
        x.remove(y);
      }
    }
    return x;
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////// GET ONE //////////////////////////////////////////////////////////////////////////////////////////////////////////

  @GetMapping("/buildings/{id}")
    // Get a building
  Building one(@PathVariable Long id) {
    return buildingRepository.findById(id).get();
  }

  @GetMapping("/buildings/{id}/rooms/{id2}")
// Get a room in a building
  Room one(@PathVariable Long id, @PathVariable Long id2) {
    return roomRepository.findById(id2).get();
  }

  @GetMapping("/buildings/{id}/rooms/{id2}/sensors/{id3}")
// Get a sensor in a room in a building
  Sensor one(@PathVariable Long id, @PathVariable Long id2, @PathVariable Long id3) {
    return sensorRepository.findById(id3).get();
  }

  @GetMapping("/buildings/{id}/rooms/{id2}/sensors{id3}/data/{id4}")
// Get a datum in a sensor in a room in a building
  Data one(@PathVariable Long id, @PathVariable Long id2, @PathVariable Long id3, @PathVariable Long id4) {
    return dataRepository.findById(id4).get();
  }
}
  ////////////////////////////////////////////////////////////////////////////////////////////////////////// ADD ONE //////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
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

 */