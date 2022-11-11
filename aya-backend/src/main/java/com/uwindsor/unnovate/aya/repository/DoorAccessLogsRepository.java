package com.uwindsor.unnovate.aya.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.uwindsor.unnovate.aya.model.DoorAccessLogs;

@Repository
public interface DoorAccessLogsRepository extends JpaRepository < DoorAccessLogs, Long > {
	//DoorAccessLogs findById(int id);
}
