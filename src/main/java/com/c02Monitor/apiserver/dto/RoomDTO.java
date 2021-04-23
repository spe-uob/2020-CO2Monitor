package com.c02Monitor.apiserver.dto;

import com.c02Monitor.apiserver.entity.Building;
import com.c02Monitor.apiserver.entity.Sensor;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import lombok.Builder;
import lombok.Data;
import lombok.Singular;

import java.util.Map;
import java.util.Set;

@Data
@Builder
@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonDeserialize(builder = RoomDTO.RoomDTOBuilder.class)
public class RoomDTO {
    private long id;

    @JsonProperty("name")
    private String name;

    //TODO: Possibly change to buildingDTO or dict.
    @JsonProperty("building")
    private Building building;

    private Set<Sensor> sensors;

    @Singular private Map<String, String> links;
}
