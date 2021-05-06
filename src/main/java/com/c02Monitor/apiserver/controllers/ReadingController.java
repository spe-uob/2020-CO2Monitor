package com.c02Monitor.apiserver.controllers;

import com.c02Monitor.apiserver.dto.ReadingDTO;
import com.c02Monitor.apiserver.entity.Reading;
import com.c02Monitor.apiserver.service.ReadingService;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;
import java.util.function.Function;
import java.util.stream.Collectors;

@RestController
@RequestMapping({"/api/v1/buildings/{buildingId}/rooms/{roomId}/sensors/{sensorId}/readings", "/api/v1/{sensorId}/readings"})
public class ReadingController extends ParentController{
    private final ReadingService readingService;

    public ReadingController(ReadingService readingService) {
        this.readingService = readingService;
    }

    //TODO ERROR HANDLE (kids optional bool)
    @GetMapping()
    public List<ReadingDTO> getAllReadings(@PathVariable("sensorId") Long sensorId) {
        List<Reading> readings = readingService.getAllSensorReadingsById(sensorId);

        return readings.stream().map(mapToReadingDTO).collect(Collectors.toList());
    }

    //TODO ERROR HANDLE (kids optional bool)
    @GetMapping(path = "/{readingId}")
    public ResponseEntity<ReadingDTO> getReading(@PathVariable("readingId") long readingId) {

        Optional<ReadingDTO> reading = readingService.getReadingById(readingId).map(mapToReadingDTO);

        return reading.map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    //TODO ERROR HANDLE (kids optional bool)
    @GetMapping(path = "/latest")
    public List<ReadingDTO> getLatestReading(@PathVariable("sensorId") Long sensorId,
                                                        @RequestParam() Optional<Integer> amt) {
        if (amt.isEmpty()) {
            amt = Optional.of(1);
        }
        Pageable pageable = PageRequest.of(0, amt.get(), Sort.Direction.DESC, "date");
        Page<Reading> topPage = readingService.getSensorReadings(sensorId, pageable);

        return topPage.get()
                .map(mapToReadingDTO)
                .collect(Collectors.toList());
    }

    //TODO ERROR HANDLE
    @DeleteMapping(value = "/{id}")
    public void deleteReading(@PathVariable("id") Long id) { readingService.deleteById(id);}


    //TODO: possibly change to include building
    private Function<Reading, ReadingDTO> mapToReadingDTO = x  -> ReadingDTO.builder()
            .id(x.getId())
            .date(x.getDate())
            .co2(x.getCo2())
            .build();
}
