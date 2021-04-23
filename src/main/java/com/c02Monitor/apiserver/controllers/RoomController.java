package com.c02Monitor.apiserver.controllers;

import com.c02Monitor.apiserver.dto.BuildingDTO;
import com.c02Monitor.apiserver.dto.RoomDTO;
import com.c02Monitor.apiserver.entity.Building;
import com.c02Monitor.apiserver.entity.Room;
import com.c02Monitor.apiserver.repository.BuildingRepository;
import com.c02Monitor.apiserver.repository.RoomRepository;
import com.c02Monitor.apiserver.service.BuildingService;
import com.c02Monitor.apiserver.service.RoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
import org.springframework.web.util.UriComponents;

import javax.servlet.http.HttpServletRequest;
import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;
import java.util.stream.Stream;

//import static com.c02Monitor.apiserver.controllers.TestController.getRawJson;

@RestController
@RequestMapping({"/api/v1/buildings/{buildingId}/rooms", "/api/v1/rooms"})
//@RequestMapping("/rooms")
public class RoomController {
    private final RoomService roomService;
    private final BuildingService buildingService;

    public RoomController(RoomService roomService, BuildingService buildingService) {
        this.roomService = roomService;
        this.buildingService = buildingService;
    }

    //TODO ERROR HANDLE (kids optional bool)
    @GetMapping("/list")
    public List<RoomDTO> getAllRooms(@PathVariable() Optional<Long> buildingId,
            @RequestParam() Optional<Boolean> kids) {

        Stream<Room> rooms;
        Stream<RoomDTO> roomsDTO;

        if (buildingId.isPresent()){
            rooms = roomService.getAllBuildingRoomsById(buildingId.get()).stream();
        }else{
            rooms = roomService.getAllRooms().stream();
        }

        if (kids.isPresent() && kids.get()){
            roomsDTO = rooms.map(mapToRoomDTOSensors);
        }else{
            roomsDTO = rooms.map(mapToRoomDTO);
        }
        return roomsDTO.collect(Collectors.toList());
    }

    //TODO ERROR HANDLE (kids optional bool)
    @GetMapping(path = "/{roomId}")
    public ResponseEntity<RoomDTO> getRoom(@PathVariable("roomId") long roomId,
                                           @RequestParam() Optional<Boolean> kids) {
        Optional<RoomDTO> room;
        if (kids.isPresent() && kids.get()){
            room = roomService.getRoomById(roomId).map(mapToRoomDTOSensors);
        }else{
            room = roomService.getRoomById(roomId).map(mapToRoomDTO);
        }
        return room.map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    //TODO ERROR HANDLE
    @PostMapping()
    public RoomDTO createRoom (@RequestBody RoomDTO roomDTO, @PathVariable() Optional<Long> buildingId){
        Room test = covertToEntity(roomDTO);
        if (buildingId.isPresent()) {
            test.setBuilding(buildingService.getBuildingById(buildingId.get()).get());
        }else{
            test.setBuilding(buildingService.getBuildingById(test.getBuilding().getId()).get());
        }
        Room roomCreated = roomService.createRoom(test);
        return convertToDTO(roomCreated);
    }

    //TODO ERROR HANDLE
    @PutMapping(value = "/{id}")
    public RoomDTO updateRoom (@PathVariable("id") Long id, @RequestBody RoomDTO roomDTO,
                            @PathVariable() Optional<Long> buildingId){
        Room room = covertToEntity(roomDTO);
        if (buildingId.isPresent()) {
            room.setBuilding(buildingService.getBuildingById(buildingId.get()).get());
        }else{
            room.setBuilding(buildingService.getBuildingById(room.getBuilding().getId()).get());
        }
        room.setId(id);
        return convertToDTO(roomService.updateRoom(room));
//        return getRoom;
    }

    //TODO ERROR HANDLE
    @DeleteMapping(value = "/{id}")
    public void deleteRoom(@PathVariable("id") Long id) { roomService.deleteById(id);}


    //TODO: possibly change to include building
    private Function<Room, RoomDTO> mapToRoomDTO = x  -> RoomDTO.builder()
            .id(x.getId())
            .name(x.getName())
            .links(getLinks(x.getId(), "sensors"))
            .build();

    private Function<Room, RoomDTO> mapToRoomDTOSensors = x  -> RoomDTO.builder()
            .id(x.getId())
            .name(x.getName())
            .sensors(x.getSensors())
            .links(getLinks(x.getId(), "sensors"))
            .build();

    private Room covertToEntity(RoomDTO roomDTO){
        return new Room(roomDTO.getName(), roomDTO.getBuilding());
    }

    //TODO :: Clean up
    private RoomDTO convertToDTO(Room room){
        return RoomDTO.builder()
                .id(room.getId())
                .name(room.getName())
                .sensors(room.getSensors())
                .links(Map.of("self", "",
                        "child", ""))
                .build();
    }

    //TODO :: Make util
    private Map<String, String> getLinks (Long id, String sub){
        UriComponents urlComp = ServletUriComponentsBuilder.fromCurrentRequestUri().build();
        String url;
        if (urlComp.getPathSegments().get(urlComp.getPathSegments().size() - 1).equalsIgnoreCase(String.valueOf(id))){
            url = urlComp.toString();
        }else {
            url = String.format("%s/%d", urlComp.toString(), id);
        }
        return Map.of("self",
                url,
                "child",
                String.format("%s/%s", url, sub));
    }
}


