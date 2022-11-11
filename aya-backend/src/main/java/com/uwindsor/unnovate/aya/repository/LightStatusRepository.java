package com.uwindsor.unnovate.aya.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.uwindsor.unnovate.aya.model.LightStatus;

@Repository
public interface LightStatusRepository extends JpaRepository < LightStatus, Long > {
	//LightStatus findById(int id);
}
