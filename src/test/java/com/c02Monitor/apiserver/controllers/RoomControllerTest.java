package com.c02Monitor.apiserver.controllers;
/*
import com.c02Monitor.apiserver.classes.Room;
import com.c02Monitor.apiserver.classes.Sensor;
import org.junit.jupiter.api.Test;

import java.time.LocalDateTime;
import java.time.temporal.ChronoField;
import java.util.HashSet;
import java.util.Set;
import java.util.stream.Collectors;

import static org.junit.jupiter.api.Assertions.*;

class RoomControllerTest {

    //not null test
    @Test
    public void getAllRoomsTest() {
        RoomController controller = new RoomController();
        controller.getAllRooms().forEach(x -> assertTrue(x.getId() >= 0));
        controller.getAllRooms().forEach(x -> assertNotNull(x.getName()));
        controller.getAllRooms().forEach(x -> assertTrue(x.getSensors().isEmpty()));
    }

    //duplicate id test
    @Test
    public void RoomDuplicateIdTest() {
        RoomController controller = new RoomController();
        Set<Long> ids = new HashSet<Long>();
        assertTrue(controller.getAllRooms().stream()
                .map(Room::getId)
                .filter(x -> !ids.add(x))
                .collect(Collectors.toSet())
                .isEmpty());

    }

    //not null test
    @Test
    public void getRoomDetailTest() {
        RoomController controller = new RoomController();
        controller.getAllRooms().stream()
                .map(x -> controller.getRoomDetail(x.getId()))
                .forEach(x -> {
                    assertTrue(x.getId() >= 0);
                    assertNotNull(x.getName());
                    assertFalse(x.getSensors().isEmpty());
                });
    }

    //date valid test
    @Test
    public void  getRoomDetailSensorTest() {
        RoomController controller = new RoomController();
        controller.getAllRooms().forEach(y -> {
            controller.getRoomDetail(y.getId()).getSensors().forEach(x -> {
                assertTrue(x.getId() >= 0);
                assertNotNull(x.getDescription());
                assertTrue(x.getData().isEmpty());
            });
        });
    }

    //duplicate id test
    @Test
    public void getRoomDetailSensorDuplicateIdTest() {
        RoomController controller = new RoomController();
        controller.getAllRooms().forEach(y -> {
            Set<Long> ids = new HashSet<Long>();
            assertTrue(controller.getRoomDetail(y.getId()).getSensors().stream()
                    .map(Sensor::getId)
                    .filter(x -> !ids.add(x))
                    .collect(Collectors.toSet())
                    .isEmpty());
        });
    }
}

 */