package com.uwindsor.unnovate.aya.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.uwindsor.unnovate.aya.model.DoctorsList;

@Repository
public interface DoctorListRepository extends JpaRepository < DoctorsList, Long > {
	
}
