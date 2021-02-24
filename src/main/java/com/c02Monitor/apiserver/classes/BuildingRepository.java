package com.c02Monitor.apiserver.classes;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BuildingRepository extends JpaRepository<Object, Long> {

  public Building findBuildingById(long id);
  Long deleteBuildingById(long id);

  public Room findRoomById(long id);
  Long deleteRoomById(long id);

  public Sensor findSensorById(long id);
  Long deleteSensorById(long id);

  public Data findDatumById(long id);
  Long deleteDatumById(long id);

  public List<Room> findByBuilding(long building);

  public List<Sensor> findByRoom(long room);

  public List<Data> findBySensor(long sensor);



}