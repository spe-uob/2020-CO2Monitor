package com.c02Monitor.apiserver.dto;

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
@JsonDeserialize(builder = BuildingDTO.BuildingDTOBuilder.class)
public class BuildingDTO {
    private Long id;
    @JsonProperty("name")
    private String name;
    private Set<Room> rooms;

    @Singular private Map<String, String> links;

}
