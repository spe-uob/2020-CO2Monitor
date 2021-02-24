package com.c02Monitor.apiserver.classes;

import org.springframework.data.jpa.repository.JpaRepository;


public interface DataRepository extends JpaRepository<Data, Long> {

  public Data findById(long id);
  Long deleteDataById(long id);



}