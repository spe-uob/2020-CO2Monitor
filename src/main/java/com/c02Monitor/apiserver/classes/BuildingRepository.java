package com.c02Monitor.apiserver.classes;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;

public interface BuildingRepository extends CrudRepository<Building, Long> {

  public Building findById(String id);
  Long deleteBuildingById(String id);

}