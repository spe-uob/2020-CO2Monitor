package com.c02Monitor.apiserver.repository;

import com.c02Monitor.apiserver.entity.Building;
import com.c02Monitor.apiserver.entity.Room;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RoomRepository extends JpaRepository<Room, Long> {
    List<Room> findByBuilding(Building building);
    List<Room> findByBuildingId(long id);

}
