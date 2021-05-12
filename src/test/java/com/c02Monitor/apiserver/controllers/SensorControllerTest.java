package com.c02Monitor.apiserver.controllers;

import com.c02Monitor.apiserver.dto.BuildingDTO;
import com.c02Monitor.apiserver.dto.RoomDTO;
import com.c02Monitor.apiserver.dto.SensorDTO;
import com.c02Monitor.apiserver.entity.Building;
import com.c02Monitor.apiserver.entity.Room;
import com.c02Monitor.apiserver.entity.Sensor;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.json.JacksonJsonParser;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

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
        Building mvb = new Building("test");
        Room testRoom = new Room("testRoom", mvb);
        Sensor testSensor = new Sensor(2000, "testSensor", testRoom);
        SensorDTO testSensorDTO = controller3.convertToDTO(testSensor);
        this.mockMvc.perform(post("/api/v1/sensors")
                .header("Authorization", "Bearer " + "invalidtoken..")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(testSensorDTO)))
                .andExpect(status().isForbidden());

    }

    @Test
    public void updateSensorNoAuthTest() throws Exception {
        Building mvb = new Building("test");
        Room testRoom = new Room("testRoom", mvb);
        Sensor testSensor = new Sensor(2000, "testSensor", testRoom);
        SensorDTO testSensorDTO = controller3.convertToDTO(testSensor);
        this.mockMvc.perform(put("/api/v1/sensors/")
                .header("Authorization", "Bearer " + "invalidtoken..")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(testSensorDTO)))
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
    public void createSensorAuthTest() throws Exception {
        String accessToken = obtainAccessToken("foo", "bar");
        Building mvb = new Building("test");
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
        String content2 = result2.getResponse().getContentAsString();
        String id2 = jsonParser.parseMap(content2).get("id").toString();
        test.setId(Long.parseLong(id2));
        Sensor testSensor = new Sensor(3000, "testSensor", test);
        SensorDTO testSensorDTO = controller3.convertToDTO(testSensor);

        mockMvc.perform(post("/api/v1/buildings/" + id + "/rooms/" + id2 + "/sensors")
                .header("Authorization", "Bearer " + accessToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(testSensorDTO))
                .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk());
    }

    @Test
    public void updateSensorAuthTest() throws Exception {
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
        mvb.setId(Long.parseLong(id));
        Room test = new Room("test", mvb);
        RoomDTO testDTO = controller2.convertToDTO(test);
        MvcResult result2 = mockMvc.perform(post("/api/v1/buildings/" + id + "/rooms/")
                .header("Authorization", "Bearer " + accessToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(testDTO))
                .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andReturn();
        String content2 = result2.getResponse().getContentAsString();
        String id2 = jsonParser.parseMap(content2).get("id").toString();

        Sensor testSensor = new Sensor(2000, "testSensor", test);
        SensorDTO testSensorDTO = controller3.convertToDTO(testSensor);
        MvcResult result3 = mockMvc.perform(post("/api/v1/buildings/" + id + "/rooms/" + id2 + "/sensors/")
                .header("Authorization", "Bearer " + accessToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(testSensorDTO))
                .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andReturn();
        String content3 = result3.getResponse().getContentAsString();
        String id3 = jsonParser.parseMap(content3).get("id").toString();
        test.setId(Long.parseLong(id2));
        Sensor testSensor2 = new Sensor(2001, "testSensor2", test);
        SensorDTO testSensor2DTO = controller3.convertToDTO(testSensor2);

        mockMvc.perform(put("/api/v1/buildings/" + id + "/rooms/" + id2 + "/sensors/" + id3)
                .header("Authorization", "Bearer " + accessToken)

                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(testSensor2DTO))
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
        Room test = new Room("test", mvb);
        RoomDTO testDTO = controller2.convertToDTO(test);
        MvcResult result2 = mockMvc.perform(post("/api/v1/buildings/" + id + "/rooms/")
                .header("Authorization", "Bearer " + accessToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(testDTO))
                .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andReturn();
        String content2 = result2.getResponse().getContentAsString();
        String id2 = jsonParser.parseMap(content2).get("id").toString();

        Sensor testSensor = new Sensor(2000, "testSensor", test);
        SensorDTO testSensorDTO = controller3.convertToDTO(testSensor);
        test.setId(Long.parseLong(id2));
        MvcResult result3 = mockMvc.perform(post("/api/v1/buildings/" + id + "/rooms/" + id2 + "/sensors/")
                .header("Authorization", "Bearer " + accessToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(testSensorDTO))
                .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andReturn();
        String content3 = result3.getResponse().getContentAsString();
        String id3 = jsonParser.parseMap(content3).get("id").toString();

        mockMvc.perform(delete("/api/v1/buildings/" + id + "/rooms/" + id2 + "/sensors/" + id3)
                .header("Authorization", "Bearer " + accessToken)

                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(testSensorDTO))
                .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk());
    }
}


