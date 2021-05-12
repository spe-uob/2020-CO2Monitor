package com.c02Monitor.apiserver.controllers;

import com.c02Monitor.apiserver.dto.BuildingDTO;
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
class BuildingsControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    @Autowired
    private BuildingController controller;



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
    public void createBuildingNoAuthTest() throws Exception {
        Building mvb = new Building("test");
        BuildingDTO mvbDTO = controller.convertToDTO(mvb);
        this.mockMvc.perform(post("/api/v1/buildings/")
                .header("Authorization", "Bearer " + "invalidtoken..")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(mvbDTO)))
                .andExpect(status().isForbidden());

    }

    @Test
    public void updateBuildingNoAuthTest() throws Exception {
        Building mvb = new Building("test");
        BuildingDTO mvbDTO = controller.convertToDTO(mvb);
        this.mockMvc.perform(put("/api/v1/buildings/" + mvb.getId())
                .header("Authorization", "Bearer " + "invalidtoken..")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(mvbDTO)))
                .andExpect(status().isForbidden());
    }

    @Test
    public void deleteBuildingNoAuthTest() throws Exception {
        this.mockMvc.perform(delete("/api/v1/buildings/")
                .header("Authorization", "Bearer " + "invalidtoken..")
                .content("") )
                .andExpect(status().isForbidden());

    }


    @Test
    public void createBuildingAuthTest() throws Exception {
        String accessToken = obtainAccessToken("foo", "bar");
        Building mvb = new Building("test");
        BuildingDTO mvbDTO = controller.convertToDTO(mvb);
        this.mockMvc.perform(post("/api/v1/buildings/")
                .header("Authorization", "Bearer " + accessToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(mvbDTO))
                .accept(MediaType.APPLICATION_JSON))
        .andExpect(status().isOk());
    }

    @Test
    public void updateBuildingAuthTest() throws Exception {
        String accessToken = obtainAccessToken("foo", "bar");
        Building mvb = new Building("test");
        BuildingDTO mvbDTO = controller.convertToDTO(mvb);
        Building queens = new Building("test2");
        BuildingDTO queensDTO = controller.convertToDTO(queens);

        this.mockMvc.perform(post("/api/v1/buildings/")
                .header("Authorization", "Bearer " + accessToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(mvbDTO))
                .accept(MediaType.APPLICATION_JSON))
        .andExpect(status().isOk());

        this.mockMvc.perform(put("/api/v1/buildings/" + mvb.getId())
                .header("Authorization", "Bearer " + accessToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(queensDTO))
                .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk());
    }
    @Test
    public void deleteBuildingAuthTest() throws Exception {
        String accessToken = obtainAccessToken("foo", "bar");
        Building mvb = new Building("test");
        BuildingDTO mvbDTO = controller.convertToDTO(mvb);

        this.mockMvc.perform(post("/api/v1/buildings/")
                .header("Authorization", "Bearer " + accessToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(mvbDTO))
                .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk());

        this.mockMvc.perform(delete("/api/v1/buildings/" + mvb.getId())
                .header("Authorization", "Bearer " + accessToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(mvbDTO))
                .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk());


    }

}
