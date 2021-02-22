package com.c02Monitor.apiserver.classes;

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
    return repository.findById(id).getRooms();
  }

  @GetMapping("/buildings/{id}/rooms/{id2}/sensors")// Get all sensors in a room in a building
  List<Sensor> all(@PathVariable Long id, @PathVariable Long id2) {
    return repository.findById(id).getRoom(id2).getSensors();
  }

  @GetMapping("/buildings/{id}/rooms/{id2}/sensors{id3}/data")// Get all data in a sensor in a room in a building
  List<Data> all(@PathVariable Long id, @PathVariable Long id2, @PathVariable Long id3) {
    return repository.findById(id).getRoom(id2).getSensor(id3).getData();
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////// GET ONE //////////////////////////////////////////////////////////////////////////////////////////////////////////

  @GetMapping("/buildings/{id}") // Get a building
  Building one(@PathVariable Long id) {
    return repository.findById(id);
  }

  @GetMapping("/buildings/{id}/rooms/{id2}")// Get a room in a building
  Room one(@PathVariable Long id, @PathVariable Long id2) {
    return repository.findById(id).getRoom(id2);
  }

  @GetMapping("/buildings/{id}/rooms/{id2}/sensors/{id3}")// Get a sensor in a room in a building
  Sensor one(@PathVariable Long id @PathVariable Long id2, @PathVariable Long id3) {
    return repository.findById(id).getRoom(id2).getSensor(id3);
  }

  @GetMapping("/buildings/{id}/rooms/{id2}/sensors{id3}/data/{id4}")// Get a datum in a sensor in a room in a building
  Data one(@PathVariable Long id @PathVariable Long id2, @PathVariable Long id3, @PathVariable Long id4) {
    return repository.findById(id).getRoom(id2).getSensor(id3).getDatum(id4);
  }