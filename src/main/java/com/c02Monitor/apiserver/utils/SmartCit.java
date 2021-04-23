package com.c02Monitor.apiserver.utils;

import com.c02Monitor.apiserver.ApiServerApplication;
import com.c02Monitor.apiserver.dto.ReadingDTO;
import com.c02Monitor.apiserver.entity.Reading;
import com.c02Monitor.apiserver.service.ReadingService;
import com.c02Monitor.apiserver.service.SensorService;
import com.c02Monitor.apiserver.templates.SmartReading;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.socket.client.IO;
import io.socket.client.Socket;
import io.socket.emitter.Emitter;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import javax.annotation.PostConstruct;
import java.net.URISyntaxException;

@Component
public class SmartCit {

    private final SensorService sensorService;
    private final ReadingService readingService;

    public SmartCit(SensorService sensorService, ReadingService readingService) {
        this.sensorService = sensorService;
        this.readingService = readingService;
    }


    public static ReadingDTO smartGet(int id) {
        final String uri = "https://api.smartcitizen.me/v0/devices/" + id;

        //TODO: Autowire the RestTemplate in all the examples
        RestTemplate restTemplate = new RestTemplate();

        SmartReading result = restTemplate.getForObject(uri, SmartReading.class);

        //TODO: Add error handling
        SmartReading.SmartData.SmartSensors foo = result.getData()
                                                        .getSensors()
                                                        .stream()
                                                        .filter(x -> x.getId() == 112)
                                                        .findFirst()
                                                        .get();

        return ReadingDTO.builder()
                .date(result.getLast_reading_at())
                .co2(foo.getValue())
                .build();

    }



    @PostConstruct
    public void smartSocket(){
        final Socket socket;
        {
            try {
                socket = IO.socket("http://ws.smartcitizen.me");
            } catch (URISyntaxException e) {
                throw new RuntimeException(e);
            }
        }

//        System.out.println("A");
        socket.on(Socket.EVENT_CONNECT, new Emitter.Listener() {

            @Override
            public void call(Object... args) {
                System.out.println("SMARTCIT WebSocket connected");
            }

        }).on("data-received", new Emitter.Listener() {

            @Override
            public void call(Object... args) {
                JSONObject data = (JSONObject)args[0];
                long id = (long) -1;
                try {
                    id = data.getInt("id");
                } catch (JSONException e) {
                    e.printStackTrace();
                }

                if (ApiServerApplication.DEVICE_IDS.contains(id)){
                    ObjectMapper objectMapper = new ObjectMapper();

                    SmartReading reading = null;
                    try {
                        reading = objectMapper.readValue(args[0].toString(), SmartReading.class);
                    } catch (JsonProcessingException e) {
                        e.printStackTrace();
                    }
                    if (reading.getData().getSensors().stream().anyMatch(x -> x.getId() == 112)) {
                        Reading newReading =  readingService.createReading(
                                new Reading(
                                        reading.getLast_reading_at(),
                                        reading.getData().getSensors().stream().filter(x -> x.getId() == 112).findFirst().get().getValue(),
                                        sensorService.getSensorById(reading.getId()).get()
                                )
                        );
                        System.out.println("Reading added : " + newReading.toString());
                    }
                }
//                else{
//                    System.out.println("E : ID not in list - " + id);
//                }
            }

        }).on(Socket.EVENT_DISCONNECT, new Emitter.Listener() {

            @Override
            public void call(Object... args) {
                System.out.println("SMARTCIT WebSocket Disconnected!!");
            }

        });
        socket.connect();
    }
}
