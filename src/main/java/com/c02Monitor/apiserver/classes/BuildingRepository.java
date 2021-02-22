package com.c02Monitor.apiserver.classes;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface BuildingRepository extends JpaRepository<Building, Long> {

  public Building findById(String id);
  Long deleteBuildingById(String id);

}