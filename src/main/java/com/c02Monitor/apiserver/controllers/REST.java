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

@GetMapping("/buildings") // Get all buildings
  List<Building> all() {
    return repository.findAll();
  }

  @GetMapping("/buildings/{id}/rooms")// Get all rooms in a building
  List<Room> all(@PathVariable Long id) {
    if (repository.findById(id).isPresent()){
      return repository.findById(id).get().getRooms();
    }
    return null;
    
  }

  @GetMapping("/buildings/{id}/rooms/{id2}/sensors")// Get all sensors in a room in a building
  List<Sensor> all(@PathVariable Long id, @PathVariable Long id2) {
    if (repository.findById(id).isPresent()){
    return repository.findById(id).get().getRoom(id2).getSensors();
    }
    return null;
  }

  @GetMapping("/buildings/{id}/rooms/{id2}/sensors{id3}/data")// Get all data in a sensor in a room in a building
  List<Data> all(@PathVariable Long id, @PathVariable Long id2, @PathVariable Long id3) {
    if (repository.findById(id).isPresent()){
    return repository.findById(id).get().getRoom(id2).getSensor(id3).getData();
    }
    return null;
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////// GET ONE //////////////////////////////////////////////////////////////////////////////////////////////////////////

  @GetMapping("/buildings/{id}") // Get a building
  Building one(@PathVariable Long id) {
    if (repository.findById(id).isPresent()){
      return repository.findById(id).get();
    }
    return null;
  }

  @GetMapping("/buildings/{id}/rooms/{id2}")// Get a room in a building
  Room one(@PathVariable Long id, @PathVariable Long id2) {
    if (repository.findById(id).isPresent()){
    return repository.findById(id).get().getRoom(id2);
    }
    return null;
  }

  @GetMapping("/buildings/{id}/rooms/{id2}/sensors/{id3}")// Get a sensor in a room in a building
  Sensor one(@PathVariable Long id, @PathVariable Long id2, @PathVariable Long id3) {
    if (repository.findById(id).isPresent()){
    return repository.findById(id).get().getRoom(id2).getSensor(id3);
    }
    return null;
  }

  @GetMapping("/buildings/{id}/rooms/{id2}/sensors{id3}/data/{id4}")// Get a datum in a sensor in a room in a building
  Data one(@PathVariable Long id, @PathVariable Long id2, @PathVariable Long id3, @PathVariable Long id4) {
    if (repository.findById(id).isPresent()){
    return repository.findById(id).get().getRoom(id2).getSensor(id3).getDatum(id4);
    }
    return null;
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////// ADD ONE //////////////////////////////////////////////////////////////////////////////////////////////////////////

  @PutMapping("/buildings/{id}")// Add or replace a building
  Building replaceBuilding(@RequestBody Building newBuilding, @PathVariable Long id) {
    
    return repository.findById(id)
      .map(building -> {
        building.setName(newBuilding.getName());
        building.setId(newBuilding.getId());
        building.setRooms(newBuilding.getRooms());
        return repository.save(building);
      })
      .orElseGet(() -> {
        newBuilding.setId(id);
        return repository.save(newBuilding);
      });
  }


@PutMapping("/buildings/{id}/rooms/{id2}")// Add or replace a room in a building
Building replaceRoom(@RequestBody Room newRoom, @PathVariable Long id,@PathVariable Long id2) {
  
  return repository.findById(id)
    .map(building -> {
      building.delRoom(id2);
      building.AddRoom(newRoom);
      return repository.save(building);
    })
    .orElseGet(() -> {
      
      return null;
    });
}

@PutMapping("/buildings/{id}/rooms/{id2}/sensors/{id3}")// Add or replace a sensor in a room in a building
Building replaceSensor(@RequestBody Sensor newSensor, @PathVariable Long id,@PathVariable Long id2,@PathVariable Long id3) {
  
  return repository.findById(id)
    .map(building -> {
      building.getRoom(id2).delSensor(id3);
      building.getRoom(id2).addSensor(newSensor);
      return repository.save(building);
    })
    .orElseGet(() -> {
      
      return null;
    });
}

@PutMapping("/buildings/{id}/rooms/{id2}/sensors/{id3}/data/{id4}")// Add or replace a datum in a sensor in a room in a building
Building replaceDatum(@RequestBody Data newDatum, @PathVariable Long id,@PathVariable Long id2,@PathVariable Long id3,@PathVariable Long id4) {
  
  return repository.findById(id)
    .map(building -> {
      building.getRoom(id2).getSensor(id3).delDatum(id4);
      building.getRoom(id2).getSensor(id3).addData(newDatum);
      return repository.save(building);
    })
    .orElseGet(() -> {
      
      return null;
    });
}


}