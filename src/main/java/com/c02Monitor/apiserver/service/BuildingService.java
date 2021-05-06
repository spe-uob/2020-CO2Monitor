package com.c02Monitor.apiserver.service;

import com.c02Monitor.apiserver.entity.Building;
import com.c02Monitor.apiserver.repository.BuildingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.*;

@Service
public class BuildingService {

    @Autowired
    private BuildingRepository buildingRepository;

    //GET
    public Optional<Building> getBuildingById(long id){
        return buildingRepository.findById(id);
    }

    public List<Building> getAllBuildings(){
        return buildingRepository.findAll();
    }

    //Create
    public Building createBuilding(Building building){
        return buildingRepository.save(building);
    }

    public void createManyBuildings(List<Building> buildings){
        buildingRepository.saveAll(buildings);
    }

    //UPDATE
    public Building updateBuilding(Building building) {return buildingRepository.save(building);}

    //DELETE
    public void deleteById(Long id) {buildingRepository.deleteById(id);}
}