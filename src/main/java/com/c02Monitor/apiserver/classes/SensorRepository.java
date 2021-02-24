package com.c02Monitor.apiserver.classes;

import org.springframework.data.jpa.repository.JpaRepository;


public interface SensorRepository extends JpaRepository<Sensor, Long> {

  Sensor findById(long id);
  Long deleteSensorById(long id);



}