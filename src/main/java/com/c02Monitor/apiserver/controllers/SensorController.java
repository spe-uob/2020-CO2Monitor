package com.c02Monitor.apiserver.controllers;

import com.c02Monitor.apiserver.classes.Building;
import com.c02Monitor.apiserver.classes.Sensor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;

import static com.c02Monitor.apiserver.controllers.TestController.getRawJson;
import static com.c02Monitor.apiserver.controllers.TestController.generateSensorData;

@RestController
@RequestMapping("/sensors")
public class SensorController {

    @GetMapping
    public List<Sensor> getAllSensors() {
        List<Building> data = getRawJson();
        return data.stream()
                .flatMap(x -> x.getRooms().stream())
                .flatMap(x -> x.getSensors().stream())
                .collect(Collectors.toList());
    }

    @GetMapping(path = "/{sensorId}")
//    @RequestMapping("/id")
    public Sensor getAllSensorData(@PathVariable() long sensorId){
        List<Building> data = getRawJson();
        Sensor sensor = data.stream()
                .flatMap(x -> x.getRooms().stream())
                .flatMap(x -> x.getSensors().stream())
                .filter(x -> x.getId() == sensorId)
                .collect(Collectors.toList()).get(0);
        sensor = new Sensor(sensor.getId(), sensor.getDescription(), generateSensorData(10));

        return sensor;
    }

    @GetMapping(path = "/{sensorId}/{dataPoints}")
    public Sensor getSensorData(@PathVariable() long sensorId, @PathVariable() int dataPoints){
        List<Building> data = getRawJson();
        Sensor sensor = data.stream()
                .flatMap(x -> x.getRooms().stream())
                .flatMap(x -> x.getSensors().stream())
                .filter(x -> x.getId() == sensorId)
                .collect(Collectors.toList()).get(0);
        sensor = new Sensor(sensor.getId(), sensor.getDescription(), generateSensorData(dataPoints));

        return sensor;
    }
}
