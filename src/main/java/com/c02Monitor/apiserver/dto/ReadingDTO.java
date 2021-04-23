package com.c02Monitor.apiserver.dto;

import com.c02Monitor.apiserver.entity.Sensor;
import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import lombok.*;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.Map;

@Data
@Builder
@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonDeserialize(builder = ReadingDTO.ReadingDTOBuilder.class)
public class ReadingDTO {

    private long id;

    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss'Z'")
    private LocalDateTime date;

    private int co2;

    private Sensor sensor;
}
