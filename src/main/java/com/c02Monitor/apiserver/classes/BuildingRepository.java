package com.c02Monitor.apiserver.classes;


import org.springframework.data.jpa.repository.JpaRepository;

public interface BuildingRepository extends JpaRepository<Building, Long> {

  public Building findById(long id);
  Long deleteBuildingById(long id);

}