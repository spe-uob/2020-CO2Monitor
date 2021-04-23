package com.c02Monitor.apiserver.controllers;

import com.c02Monitor.apiserver.ApiServerApplication;
import com.c02Monitor.apiserver.dto.RoomDTO;
import com.c02Monitor.apiserver.dto.SensorDTO;
import com.c02Monitor.apiserver.entity.Room;
import com.c02Monitor.apiserver.entity.Sensor;
import com.c02Monitor.apiserver.service.RoomService;
import com.c02Monitor.apiserver.service.SensorService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
import org.springframework.web.util.UriComponents;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.function.Function;
import java.util.stream.Collectors;
import java.util.stream.Stream;


@RestController
@RequestMapping({"/api/v1/buildings/{buildingId}/rooms/{roomId}/sensors", "/api/v1/sensors"})
public class SensorController {

    private final SensorService sensorService;
    private final RoomService roomService;

    public SensorController(SensorService sensorService, RoomService roomService){
        this.sensorService = sensorService;
        this.roomService = roomService;
    }

    //TODO ERROR HANDLE (kids optional bool)
    @GetMapping("/list")
    public List<SensorDTO> getAllSensors(@PathVariable() Optional<Long> roomId,
                                     @RequestParam() Optional<Boolean> kids) {

        Stream<Sensor> sensors;
        Stream<SensorDTO> sensorsDTO;

        if (roomId.isPresent()){
            sensors = sensorService.getAllRoomSensorsById(roomId.get()).stream();
        }else{
            sensors = sensorService.getAllSensors().stream();
        }

        if (kids.isPresent() && kids.get()){
            sensorsDTO = sensors.map(mapToSensorDTOReadings);
        }else{
            sensorsDTO = sensors.map(mapToSensorDTO);
        }
        return sensorsDTO.collect(Collectors.toList());
    }

    //TODO ERROR HANDLE (kids optional bool)
    @GetMapping(path = "/{sensorId}")
    public ResponseEntity<SensorDTO> getSensor(@PathVariable("sensorId") long sensorId,
                                           @RequestParam() Optional<Boolean> kids) {
        Optional<SensorDTO> sensor;
        if (kids.isPresent() && kids.get()){
            sensor = sensorService.getSensorById(sensorId).map(mapToSensorDTOReadings);
        }else{
            sensor = sensorService.getSensorById(sensorId).map(mapToSensorDTO);
        }
        return sensor.map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    //TODO ERROR HANDLE
    @PostMapping()
    public SensorDTO createSensor (@RequestBody SensorDTO sensorDTO, @PathVariable() Optional<Long> roomId){
        Sensor test = covertToEntity(sensorDTO);
        if (roomId.isPresent()) {
            test.setRoom(roomService.getRoomById(roomId.get()).get());
        }else{
            test.setRoom(roomService.getRoomById(test.getRoom().getId()).get());
        }
        Sensor sensorCreated = sensorService.createSensor(test);
        if (sensorCreated != null) {
            ApiServerApplication.DEVICE_IDS.add(sensorCreated.getId());
            System.out.println("NEW SENSOR :" + sensorCreated.getId());
        }
        return convertToDTO(sensorCreated);
    }

    //TODO ERROR HANDLE
    @PutMapping(value = "/{id}")
    public SensorDTO updateSensor (@PathVariable("id") Long id, @RequestBody SensorDTO sensorDTO,
                            @PathVariable() Optional<Long> roomId){
        Sensor sensor = covertToEntity(sensorDTO);
        if (roomId.isPresent()) {
            sensor.setRoom(roomService.getRoomById(roomId.get()).get());
        }else{
            sensor.setRoom(roomService.getRoomById(sensor.getRoom().getId()).get());
        }
        sensor.setId(id);
        return convertToDTO(sensorService.updateSensor(sensor));
    }

    //TODO ERROR HANDLE
    @DeleteMapping(value = "/{id}")
    public void deleteSensor(@PathVariable("id") Long id) { sensorService.deleteById(id);}


//    @FunctionalInterface
//    private interface MapToDTO<One, Two, Three>{
//        public Three apply(One one, Two two);
//    }

    //TODO: possibly change to include building
    private Function<Sensor, SensorDTO> mapToSensorDTO = x  -> SensorDTO.builder()
            .id(x.getId())
            .description(x.getDescription())
            .links(getLinks(x.getId(), "sensors"))
            .build();

    private Function<Sensor, SensorDTO> mapToSensorDTOReadings = x  -> SensorDTO.builder()
            .id(x.getId())
            .description(x.getDescription())
            .readings(x.getReadings())
            .links(getLinks(x.getId(), "sensors"))
            .build();

    private Sensor covertToEntity(SensorDTO sensorDTO){
        return new Sensor(sensorDTO.getId(), sensorDTO.getDescription(), sensorDTO.getRoom());
    }

    //TODO :: Clean up
    private SensorDTO convertToDTO(Sensor sensor){
        return SensorDTO.builder()
                .id(sensor.getId())
                .description(sensor.getDescription())
                .readings(sensor.getReadings())
                .links(Map.of("self", "",
                        "child", ""))
                .build();
    }

    //TODO :: Make util
    private Map<String, String> getLinks (Long id, String sub){
        UriComponents urlComp = ServletUriComponentsBuilder.fromCurrentRequestUri().build();
        String url;
        if (urlComp.getPathSegments().get(urlComp.getPathSegments().size() - 1).equalsIgnoreCase(String.valueOf(id))){
            url = urlComp.toString();
        }else {
            url = String.format("%s/%d", urlComp.toString(), id);
        }
        return Map.of("self",
                url,
                "child",
                String.format("%s/%s", url, sub));
    }
}

