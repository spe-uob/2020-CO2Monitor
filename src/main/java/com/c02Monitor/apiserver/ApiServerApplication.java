package com.c02Monitor.apiserver;

import com.c02Monitor.apiserver.entity.Building;
import com.c02Monitor.apiserver.entity.Room;
import com.c02Monitor.apiserver.entity.Sensor;
import com.c02Monitor.apiserver.entity.User;
import com.c02Monitor.apiserver.service.BuildingService;
import com.c02Monitor.apiserver.service.RoomService;
import com.c02Monitor.apiserver.service.SensorService;
import com.c02Monitor.apiserver.service.UserService;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.http.converter.json.Jackson2ObjectMapperBuilder;

import java.util.*;
import java.util.stream.Collectors;

@SpringBootApplication
public class ApiServerApplication {

	public static List<Long> DEVICE_IDS = new ArrayList<>();

	public static void main(String[] args) {
		SpringApplication.run(ApiServerApplication.class, args);
	}

	@Bean
	CommandLineRunner runner(BuildingService buildingService, RoomService roomService, SensorService sensorService, UserService userService, ApiServerApplication bar){
		return args -> {
//			User user = new User("foo", "bar");
//			userService.create(user);
//
//			Building building1 =  new Building("MVB");
//			Building building2 =  new Building("Queens");
//
//			buildingService.createBuilding(building1);
//			buildingService.createBuilding(building2);
//
//			Room room1 = new Room("1.1", building1);
//			Room room2 = new Room("2.11", building1);
//			roomService.createRoom(room1);
//			roomService.createRoom(room2);
//
//			Room room3 = new Room("Room A", building2);
//			Room room4 = new Room("Room B", building2);
//			roomService.createRoom(room3);
//			roomService.createRoom(room4);
//
//			Sensor sensor1 = new Sensor(12600, "test", room1);
//			Sensor sensor2 = new Sensor(9858, "test", room1);
//			sensorService.createSensor(sensor1);
//			sensorService.createSensor(sensor2);

			DEVICE_IDS.addAll(sensorService.getAllSensors()
                        .stream()
                        .map(Sensor::getId)
                        .collect(Collectors.toList()));

		};
	}
	@Bean
	public Jackson2ObjectMapperBuilder jacksonBuilder() {
		Jackson2ObjectMapperBuilder b = new Jackson2ObjectMapperBuilder();
		b.failOnEmptyBeans(false);
		b.failOnUnknownProperties(false);
		return b;
	}
}
