package com.c02Monitor.apiserver.controllers;

import com.c02Monitor.apiserver.dto.BuildingDTO;
import com.c02Monitor.apiserver.entity.Building;
import com.c02Monitor.apiserver.service.BuildingService;
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

@RestController
@RequestMapping("/api/v1/buildings")
public class BuildingController {

    private final BuildingService buildingService;

    public BuildingController(BuildingService buildingService) {
        this.buildingService = buildingService;
    }

    //TODO ERROR HANDLE (kids optional bool)
    @GetMapping("/list")
    public List<BuildingDTO> getAllBuildings(@RequestParam() Optional<Boolean> kids) {
        Stream<BuildingDTO> buildings;
        if (kids.isPresent() && kids.get()){
            buildings = buildingService.getAllBuildings().stream().map(mapToBuildingDTORooms);
        }else{
            buildings = buildingService.getAllBuildings().stream().map(mapToBuildingDTO);
        }
        return buildings.collect(Collectors.toList());
    }

    //TODO ERROR HANDLE (kids optional bool)
    @GetMapping(path = "/{buildingId}")
    public ResponseEntity<BuildingDTO> getBuilding(@PathVariable("buildingId") long buildingId,
                                                   @RequestParam() Optional<Boolean> kids) {
        Optional<BuildingDTO> building;
        if (kids.isPresent() && kids.get()){
            building = buildingService.getBuildingById(buildingId).map(mapToBuildingDTORooms);
        }else{
            building = buildingService.getBuildingById(buildingId).map(mapToBuildingDTO);
        }
        return building.map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    //TODO ERROR HANDLE
    @PostMapping()
    public BuildingDTO createBuilding (@RequestBody BuildingDTO buildingDTO){
        Building test = covertToEntity(buildingDTO);
        Building buildingCreated = buildingService.createBuilding(test);
        return convertToDTO(buildingCreated);
    }

    //TODO ERROR HANDLE
    @PutMapping(value = "/{id}")
    public BuildingDTO updateBuilding (@PathVariable("id") Long id, @RequestBody BuildingDTO buildingDTO){
        Building building = covertToEntity(buildingDTO);
        building.setId(id);
        Building buildingUpdated = buildingService.updateBuilding(building);
        return convertToDTO(buildingUpdated);
//        return getBuilding;
    }

    //TODO ERROR HANDLE
    @DeleteMapping(value = "/{id}")
    public void deleteBuilding(@PathVariable("id") Long id) { buildingService.deleteById(id);}


//    @FunctionalInterface
//    private interface MapToDTO<One, Two, Three>{
//        public Three apply(One one, Two two);
//    }

    private Function<Building, BuildingDTO> mapToBuildingDTO = x  -> BuildingDTO.builder()
            .id(x.getId())
            .name(x.getName())
            .links(getLinks(x.getId(), "rooms"))
            .build();

    private Function<Building, BuildingDTO> mapToBuildingDTORooms = x  -> BuildingDTO.builder()
            .id(x.getId())
            .name(x.getName())
            .rooms(x.getRooms())
            .links(getLinks(x.getId(), "rooms"))
            .build();

    private Building covertToEntity(BuildingDTO buildingDTO){
        return new Building(buildingDTO.getName());
    }

    //TODO :: Clean up
    private BuildingDTO convertToDTO(Building building){
        return BuildingDTO.builder()
                .id(building.getId())
                .name(building.getName())
                .rooms(building.getRooms())
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

