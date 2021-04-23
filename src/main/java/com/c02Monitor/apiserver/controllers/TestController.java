package com.c02Monitor.apiserver.controllers;


import com.c02Monitor.apiserver.dto.ReadingDTO;
import com.c02Monitor.apiserver.entity.Reading;
import com.c02Monitor.apiserver.entity.Sensor;
import com.c02Monitor.apiserver.service.BuildingService;
import com.c02Monitor.apiserver.service.ReadingService;
import com.c02Monitor.apiserver.service.RoomService;
import com.c02Monitor.apiserver.service.SensorService;
import com.c02Monitor.apiserver.templates.SmartReading;
import com.c02Monitor.apiserver.utils.SmartCit;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.List;

//import static com.c02Monitor.apiserver.utils.SmartCit.testy;

@RestController
@RequestMapping("/test")
public class TestController {

    private final ReadingService readingService;
    private final SensorService sensorService;

    public TestController(ReadingService readingService, SensorService sensorService) {
        this.readingService = readingService;
        this.sensorService = sensorService;
    }
}


