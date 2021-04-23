package com.c02Monitor.apiserver.controllers;
/*
import com.c02Monitor.apiserver.classes.Building;
import com.c02Monitor.apiserver.classes.Room;
import com.c02Monitor.apiserver.classes.Sensor;
import org.junit.jupiter.api.Test;

import java.util.HashSet;
import java.util.Set;
import java.util.stream.Collectors;

import static org.junit.jupiter.api.Assertions.*;

class BuildingsControllerTest {

    //not null test
    @Test
    public void getAllBuildingsTest() {
        BuildingController controller = new BuildingController();
        controller.getAllBuildings().forEach(x -> assertTrue(x.getId() >= 0));
        controller.getAllBuildings().forEach(x -> assertNotNull(x.getName()));
        controller.getAllBuildings().forEach(x -> assertTrue(x.getRooms().isEmpty()));
    }

    //duplicate id test
    @Test
    public void BuildingsDuplicateIdTest() {
        BuildingController controller = new BuildingController();
        Set<Long> ids = new HashSet<Long>();
        assertTrue(controller.getAllBuildings().stream()
                .map(Building::getId)
                .filter(x -> !ids.add(x))
                .collect(Collectors.toSet())
                .isEmpty());

    }

    //not null test
    @Test
    public void getRoomDetailTest() {
        BuildingController controller = new BuildingController();
        controller.getAllBuildings().stream()
                .map(x -> controller.getBuildingDetail(x.getId()))
                .forEach(x -> {
                    assertTrue(x.getId() >= 0);
                    assertNotNull(x.getName());
                    assertFalse(x.getRooms().isEmpty());
                });
    }

    //date valid test
    @Test
    public void  getRoomDetailSensorTest() {
        BuildingController controller = new BuildingController();
        controller.getAllBuildings().forEach(y -> {
            controller.getBuildingDetail(y.getId()).getRooms().forEach(x -> {
                assertTrue(x.getId() >= 0);
                assertNotNull(x.getName());
                assertTrue(x.getSensors().isEmpty());
            });
        });
    }

    //duplicate id test
    @Test
    public void getRoomDetailSensorDuplicateIdTest() {
        BuildingController controller = new BuildingController();
        controller.getAllBuildings().forEach(y -> {
            Set<Long> ids = new HashSet<Long>();
            assertTrue(controller.getBuildingDetail(y.getId()).getRooms().stream()
                    .map(Room::getId)
                    .filter(x -> !ids.add(x))
                    .collect(Collectors.toSet())
                    .isEmpty());
        });
    }
}

 */