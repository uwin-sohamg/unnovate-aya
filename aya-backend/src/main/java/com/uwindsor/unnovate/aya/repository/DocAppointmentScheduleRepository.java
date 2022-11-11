package com.uwindsor.unnovate.aya.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.uwindsor.unnovate.aya.model.DocAppointmentSchedule;

@Repository
public interface DocAppointmentScheduleRepository extends JpaRepository < DocAppointmentSchedule, Long > {
	DocAppointmentSchedule findById(int id);
}
