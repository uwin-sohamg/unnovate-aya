package com.uwindsor.unnovate.aya.model;


import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "doc_appointment_schedule")
public class DocAppointmentSchedule {
	
	@Id
	private int id;
	private String childid;
	private String doctorid;
	private String date;
	private String time;
	
	
	@Override
    public String toString() {
        return "ChildDetails {" +
                " id= " + id +
                " name= " + date 
                +" }";
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getChildid() {
		return childid;
	}


	public void setChildid(String childid) {
		this.childid = childid;
	}


	public String getDoctorid() {
		return doctorid;
	}


	public void setDoctorid(String doctorid) {
		this.doctorid = doctorid;
	}


	public String getDate() {
		return date;
	}


	public void setDate(String date) {
		this.date = date;
	}


	public String getTime() {
		return time;
	}


	public void setTime(String time) {
		this.time = time;
	}



}
