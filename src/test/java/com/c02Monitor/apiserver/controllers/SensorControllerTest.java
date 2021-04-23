package com.c02Monitor.apiserver.controllers;
/*
import com.c02Monitor.apiserver.classes.Data;
import com.c02Monitor.apiserver.classes.Sensor;
import org.junit.Assert;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import java.time.LocalDateTime;
import java.time.temporal.ChronoField;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;
import java.util.stream.Collectors;

import static org.junit.jupiter.api.Assertions.*;

class SensorControllerTest {

    //not null test
    @Test
    public void getAllSensorsTest() {
        SensorController controller = new SensorController();
        controller.getAllSensors().forEach(x -> assertTrue(x.getId() >= 0));
        controller.getAllSensors().forEach(x -> assertNotNull(x.getDescription()));
        controller.getAllSensors().forEach(x -> assertTrue(x.getData().isEmpty()));
    }

    //Not duplicate id test
    @Test
    public void SensorDuplicateIdTest() {
        SensorController controller = new SensorController();
        Set<Long> ids = new HashSet<Long>();
        assertTrue(controller.getAllSensors().stream()
                .map(Sensor::getId)
                .filter(x -> !ids.add(x))
                .collect(Collectors.toSet())
                .isEmpty());

    }

    //not null test
    @Test
    public void getAllSensorDataTest() {
        SensorController controller = new SensorController();
        controller.getAllSensors().stream()
                .map(x -> controller.getAllSensorData(x.getId()))
                .forEach(x -> {
                    assertTrue(x.getId() >= 0);
                    assertNotNull(x.getDescription());
                    assertFalse(x.getData().isEmpty());
                });
    }

    //date valid test
    @Test
    public void getAllSensorDataDateTest() {
        SensorController controller = new SensorController();
        controller.getAllSensors().forEach(y -> {
            controller.getAllSensorData(y.getId()).getData().forEach(x -> {
                assertTrue(x.getDate().isBefore(LocalDateTime.now().plusDays(1)));
                assertTrue(x.getDate().isSupported(ChronoField.YEAR));
                assertTrue(x.getDate().isSupported(ChronoField.MONTH_OF_YEAR));
                assertTrue(x.getDate().isSupported(ChronoField.DAY_OF_MONTH));
                assertTrue(x.getDate().isSupported(ChronoField.HOUR_OF_DAY));
                assertTrue(x.getDate().isSupported(ChronoField.MINUTE_OF_HOUR));
                assertTrue(x.getDate().isSupported(ChronoField.SECOND_OF_MINUTE));
            });
        });
    }

    //valid co2 test
    @Test
    public void getAllSensorDataCO2Test() {
        SensorController controller = new SensorController();
        controller.getAllSensors().forEach(y -> {
            controller.getAllSensorData(y.getId()).getData().forEach(x -> {
                assertTrue(0 <= x.getCo2() && x.getCo2() <= 100);
            });
        });
    }

    //returns the right amount of data points
    @Test
    public void getSensorDataTest() {
        SensorController controller = new SensorController();
        controller.getAllSensors().forEach(y -> {
            assertEquals(controller.getSensorData(y.getId(), 5).getData().size(), 5);
        });
    }
}

 */