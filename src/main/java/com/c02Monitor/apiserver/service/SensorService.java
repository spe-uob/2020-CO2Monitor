package com.c02Monitor.apiserver.service;

import com.c02Monitor.apiserver.dto.RoomDTO;
import com.c02Monitor.apiserver.dto.SensorDTO;
import com.c02Monitor.apiserver.entity.Room;
import com.c02Monitor.apiserver.entity.Sensor;
import com.c02Monitor.apiserver.repository.SensorRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class SensorService {
    private final SensorRepository sensorRepository;

    public SensorService(SensorRepository sensorRepository) {
        this.sensorRepository = sensorRepository;
    }

    //GET
    public Optional<Sensor> getSensorById(long id){
        return sensorRepository.findById(id);
    }

    public List<Sensor> getAllRoomSensorsById(long id){
        return sensorRepository.findByRoomId(id);
    }

    public List<Sensor> getAllSensors(){
        return sensorRepository.findAll();
    }

    //Create
    public Sensor createSensor(Sensor sensor){
        return sensorRepository.save(sensor);
    }

    public void createManySensors(List<Sensor> sensors){
        sensorRepository.saveAll(sensors);
    }

    //UPDATE
    public Sensor updateSensor(Sensor sensor) {return sensorRepository.save(sensor);}

    //DELETE
    public void deleteById(Long id) {sensorRepository.deleteById(id);}
}
