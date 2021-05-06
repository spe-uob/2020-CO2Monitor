package com.c02Monitor.apiserver.service;

import com.c02Monitor.apiserver.entity.Reading;
import com.c02Monitor.apiserver.repository.ReadingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ReadingService {
    @Autowired
    private ReadingRepository readingRepository;

    //GET
    public Optional<Reading> getReadingById(long id){
        return readingRepository.findById(id);
    }

    public List<Reading> getAllSensorReadingsById(long id){
        return readingRepository.findBySensorId(id);
    }

    public Page<Reading> getSensorReadings(long id, Pageable pageable){
        return readingRepository.findBySensorId(id, pageable);
    }

    public List<Reading> getAllReadings(){
        return readingRepository.findAll();
    }

    //Create
    public Reading createReading(Reading reading){
        return readingRepository.save(reading);
    }

    public void createManyReadings(List<Reading> reading){
        readingRepository.saveAll(reading);
    }

    //UPDATE
    public Reading updateReading(Reading reading) {return readingRepository.save(reading);}

    //DELETE
    public void deleteById(Long id) {readingRepository.deleteById(id);}
}
