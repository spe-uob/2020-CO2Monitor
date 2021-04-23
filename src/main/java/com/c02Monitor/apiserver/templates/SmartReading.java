package com.c02Monitor.apiserver.templates;

import com.c02Monitor.apiserver.dto.BuildingDTO;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import lombok.Builder;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.IOException;
import java.text.Format;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class SmartReading {
    //TODO: CLEAN UP
    // I KNOW BUT I DIDNT WANT TO
    @Data
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class SmartData{
        @Data
        @JsonIgnoreProperties(ignoreUnknown = true)
        public static class SmartSensors {
            private long id;
            private int value;
        }
        private List<SmartSensors> sensors;
    }

    private Long id;
    //    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class)
    private LocalDateTime last_reading_at;

    private SmartData data;

    public static class LocalDateTimeDeserializer extends JsonDeserializer<LocalDateTime> {
        @Override
        public LocalDateTime deserialize(JsonParser arg0, DeserializationContext arg1) throws IOException {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss'Z'");
            return LocalDateTime.parse(arg0.getText(), formatter);
        }
    }

//    public static class LocalDateTimeSerializer extends JsonSerializer<LocalDateTime> {
//        @Override
//        public void serialize(LocalDateTime arg0, JsonGenerator arg1, SerializerProvider arg2) throws IOException {
//            arg1.writeString(arg0.toString());
//        }
//    }
}
