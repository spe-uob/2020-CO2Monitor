package com.c02Monitor.apiserver.classes;

import org.springframework.data.jpa.repository.JpaRepository;


public interface RoomRepository extends JpaRepository<Room, Long> {

  public Room findById(long id);
  Long deleteRoomById(long id);



}