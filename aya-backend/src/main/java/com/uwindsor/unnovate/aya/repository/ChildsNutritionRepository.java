package com.uwindsor.unnovate.aya.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.uwindsor.unnovate.aya.model.ChildsNutrition;

@Repository
public interface ChildsNutritionRepository extends JpaRepository < ChildsNutrition, Long > {
	
}
