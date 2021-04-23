package com.c02Monitor.apiserver.dto;

import com.c02Monitor.apiserver.entity.Building;
import com.c02Monitor.apiserver.entity.Reading;
import com.c02Monitor.apiserver.entity.Room;
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
@JsonDeserialize(builder = SensorDTO.SensorDTOBuilder.class)
public class SensorDTO {
    @JsonProperty("id")
    private long id;

    @JsonProperty("name")
    private String description;

    //TODO: Possibly change to roomDTO or dict.
    @JsonProperty("room")
    private Room room;

    private Set<Reading> readings;

    @Singular private Map<String, String> links;
}
