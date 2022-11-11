package com.uwindsor.unnovate.aya.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.uwindsor.unnovate.aya.model.ParentDetails;

@Repository
public interface ParentDetailsRepository extends JpaRepository < ParentDetails, Long > {
	ParentDetails findById(int id);
}
