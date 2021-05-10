package com.c02Monitor.apiserver.controllers;

import com.c02Monitor.apiserver.dto.BuildingDTO;
import com.c02Monitor.apiserver.dto.RoomDTO;
import com.c02Monitor.apiserver.dto.SensorDTO;
import com.c02Monitor.apiserver.entity.Building;
import com.c02Monitor.apiserver.controllers.ParentController;
import com.c02Monitor.apiserver.entity.Room;
import com.c02Monitor.apiserver.entity.Sensor;
import com.c02Monitor.apiserver.entity.Reading;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.json.JacksonJsonParser;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.web.server.LocalServerPort;
import static org.assertj.core.api.Assertions.assertThat;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.hamcrest.Matchers.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.setup.MockMvcBuilders.webAppContextSetup;

import java.util.*;
import java.util.stream.Collectors;

import static org.junit.jupiter.api.Assertions.*;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;

@SpringBootTest
@AutoConfigureMockMvc
@TestPropertySource(
        locations = "classpath:application-integrationtest.properties")
class SensorControllerTest {

    @Autowired
    private MockMvc mockMvc;
    @Autowired
    private ObjectMapper objectMapper;
    @Autowired
    private BuildingController controller;
    @Autowired
    private RoomController controller2;
    @Autowired
    private SensorController controller3;

    private String obtainAccessToken(String username, String password) throws Exception {

        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("grant_type", "password");
        params.add("client_id", "fooClientIdPassword");
        params.add("username", username);
        params.add("password", password);

        ResultActions result
                = mockMvc.perform(post("/api/v1/auth")
                .params(params)
                .contentType(MediaType.APPLICATION_JSON)
                .content("{\"username\":\"foo\",\"password\":\"bar\"}")
                .accept("application/json;charset=UTF-8"));

        String resultString = result.andReturn().getResponse().getContentAsString();
        JacksonJsonParser jsonParser = new JacksonJsonParser();
        return jsonParser.parseMap(resultString).get("token").toString();
    }


    @Test
    public void createSensorNoAuthTest() throws Exception {
        Sensor test = new Sensor();
        SensorDTO testDTO = controller3.convertToDTO(test);
        this.mockMvc.perform(post("/api/v1/sensors")
                .header("Authorization", "Bearer " + "invalidtoken..")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(testDTO)))
                .andExpect(status().isForbidden());

    }

    @Test
    public void updateSensorNoAuthTest() throws Exception {
        Sensor test = new Sensor();
        SensorDTO testDTO = controller3.convertToDTO(test);
        this.mockMvc.perform(put("/api/v1/sensors/" + test.getId())
                .header("Authorization", "Bearer " + "invalidtoken..")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(testDTO)))
                .andExpect(status().isForbidden());
    }

    @Test
    public void deleteSensorNoAuthTest() throws Exception {
        this.mockMvc.perform(delete("/api/v1/sensors/")
                .header("Authorization", "Bearer " + "invalidtoken..")
                .content("") )
                .andExpect(status().isForbidden());
    }

    @Test
    public void createSensorAuthTest() throws Exception {//TODO
        String accessToken = obtainAccessToken("foo", "bar");
        Building mvb = new Building("test");
        mvb.setId(123123);
        BuildingDTO mvbDTO = controller.convertToDTO(mvb);

        MvcResult result = mockMvc.perform(post("/api/v1/buildings/")
                .header("Authorization", "Bearer " + accessToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(mvbDTO))
                .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andReturn();
        String content = result.getResponse().getContentAsString();
        JacksonJsonParser jsonParser = new JacksonJsonParser();
        String id = jsonParser.parseMap(content).get("id").toString();

        mvb.setId(Long.parseLong(id));
        System.out.println(mvb.getId()+ "\n\n\n\n\n\n\n");
        Room test = new Room("test", mvb);
        RoomDTO testDTO = controller2.convertToDTO(test);
        this.mockMvc.perform(post("/api/v1/buildings/" + id + "/rooms")
                .header("Authorization", "Bearer " + accessToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(testDTO))
                .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk());
    }

    @Test
    public void updateSensorAuthTest() throws Exception {//TODO
        String accessToken = obtainAccessToken("foo", "bar");
        Building mvb = new Building("test");
        mvb.setId(123123);
        BuildingDTO mvbDTO = controller.convertToDTO(mvb);

        MvcResult result = mockMvc.perform(post("/api/v1/buildings/")
                .header("Authorization", "Bearer " + accessToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(mvbDTO))
                .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andReturn();
        String content = result.getResponse().getContentAsString();
        JacksonJsonParser jsonParser = new JacksonJsonParser();
        String id = jsonParser.parseMap(content).get("id").toString();

        mvb.setId(Long.parseLong(id));
        System.out.println(mvb.getId()+ "\n\n\n\n\n\n\n");
        Room test = new Room("test", mvb);
        RoomDTO testDTO = controller2.convertToDTO(test);
        MvcResult result2 = mockMvc.perform(post("/api/v1/buildings/" + id + "/rooms/")
                .header("Authorization", "Bearer " + accessToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(testDTO))
                .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andReturn();
        String content2 = result.getResponse().getContentAsString();
        String id2 = jsonParser.parseMap(content).get("id").toString();

        mockMvc.perform(put("/api/v1/buildings/" + id + "/rooms/" + id2)
                .header("Authorization", "Bearer " + accessToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(mvbDTO))
                .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk());
    }
    @Test
    public void deleteSensorAuthTest() throws Exception { //TODO
        String accessToken = obtainAccessToken("foo", "bar");
        Building mvb = new Building("test");
        mvb.setId(123123);
        BuildingDTO mvbDTO = controller.convertToDTO(mvb);

        MvcResult result = mockMvc.perform(post("/api/v1/buildings/")
                .header("Authorization", "Bearer " + accessToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(mvbDTO))
                .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andReturn();
        String content = result.getResponse().getContentAsString();
        JacksonJsonParser jsonParser = new JacksonJsonParser();
        String id = jsonParser.parseMap(content).get("id").toString();

        mvb.setId(Long.parseLong(id));
        System.out.println(mvb.getId()+ "\n\n\n\n\n\n\n");
        Room test = new Room("test", mvb);
        RoomDTO testDTO = controller2.convertToDTO(test);
        MvcResult result2 = mockMvc.perform(post("/api/v1/buildings/" + id + "/rooms/")
                .header("Authorization", "Bearer " + accessToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(testDTO))
                .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andReturn();
        String content2 = result.getResponse().getContentAsString();
        String id2 = jsonParser.parseMap(content).get("id").toString();

        mockMvc.perform(delete("/api/v1/buildings/" + id + "/rooms/" + id2)
                .header("Authorization", "Bearer " + accessToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(mvbDTO))
                .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk());
    }
}


