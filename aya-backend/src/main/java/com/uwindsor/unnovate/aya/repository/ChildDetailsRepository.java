package com.uwindsor.unnovate.aya.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.uwindsor.unnovate.aya.model.ChildDetails;

@Repository
public interface ChildDetailsRepository extends JpaRepository < ChildDetails, Long > {
    ChildDetails findById(int id);
}
