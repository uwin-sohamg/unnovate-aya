package com.uwindsor.unnovate.aya.model;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "child_vaccine_details")
public class  ChildVaccineDetails{
	
	@Id
	private int id;
	private String childid;
	private String vaccineid;
	private String vaccinename;
	private String month;
	private String taken;
	
	public int getId() {
		return id;
	}



	public void setId(int id) {
		this.id = id;
	}

	
	
	@Override
    public String toString() {
        return "ChildDetails {" +
                " id= " + childid +
                " name= " + vaccineid 
                +" }";
	}



	public String getChildid() {
		return childid;
	}



	public void setChildid(String childid) {
		this.childid = childid;
	}



	public String getVaccineid() {
		return vaccineid;
	}



	public void setVaccineid(String vaccineid) {
		this.vaccineid = vaccineid;
	}



	public String getMonth() {
		return month;
	}



	public void setMonth(String month) {
		this.month = month;
	}



	public String getTaken() {
		return taken;
	}



	public void setTaken(String taken) {
		this.taken = taken;
	}



	public String getVaccinename() {
		return vaccinename;
	}



	public void setVaccinename(String vaccinename) {
		this.vaccinename = vaccinename;
	}


}
