package com.c02Monitor.apiserver.repository;

import com.c02Monitor.apiserver.entity.Reading;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReadingRepository extends JpaRepository<Reading, Long> {
    List<Reading> findBySensorId(long id);
    Page<Reading> findBySensorId(long id, Pageable pageable);
}
