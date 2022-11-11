package com.uwindsor.unnovate.aya.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.uwindsor.unnovate.aya.model.ParentDetails;
import com.uwindsor.unnovate.aya.model.VaccineList;

@Repository
public interface VaccineListRepository extends JpaRepository < VaccineList, Long > {
	VaccineList findById(int id);
}
