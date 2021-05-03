package com.c02Monitor.apiserver.controllers;

import com.c02Monitor.apiserver.dto.BuildingDTO;
import com.c02Monitor.apiserver.entity.Building;
import com.c02Monitor.apiserver.entity.Room;
import com.c02Monitor.apiserver.entity.Sensor;
import com.c02Monitor.apiserver.entity.Reading;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.web.server.LocalServerPort;
import static org.assertj.core.api.Assertions.assertThat;
import org.springframework.boot.test.web.client.TestRestTemplate;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class BuildingsControllerTest {
    @Autowired
    private TestRestTemplate restTemplate;


    @LocalServerPort
    private int port;

    @Autowired
    private BuildingController controller;



    //no default buildings test
    @Test
    public void getAllBuildingsTest() throws Exception {
        assertThat(this.restTemplate.getForObject("http://localhost:" + port + "/api/v1/buildings", List.class)
                .isEmpty()
        );
    }

    //add building then delete test
    @Test
    public void addAndRemoveBuildingTest() {
        Building mvb = new Building("mvb");
        BuildingDTO mvbDTO = controller.convertToDTO(mvb);
        this.restTemplate.postForLocation("http://localhost:" + port + "/api/v1/buildings", mvbDTO);
        assertThat(this.restTemplate.getForObject("http://localhost:" + port + "/api/v1/buildings", List.class)
                .contains(mvbDTO)
        );

        this.restTemplate.delete("http://localhost:" + port + "/api/v1/buildings/" + mvb.getId());
        assertThat(!(this.restTemplate.getForObject("http://localhost:" + port + "/api/v1/buildings", List.class)
                .contains(mvbDTO)));
    }

/*
    //duplicate id test
    @Test
    public void getRoomDetailSensorDuplicateIdTest() {
        controller.getAllBuildings().forEach(y -> {
            Set<Long> ids = new HashSet<Long>();
            assertTrue(controller.getBuildingDetail(y.getId()).getRooms().stream()
                    .map(Room::getId)
                    .filter(x -> !ids.add(x))
                    .collect(Collectors.toSet())
                    .isEmpty());
        });
    }*/
}

