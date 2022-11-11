package com.uwindsor.unnovate.aya.model;


import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "vaccine_list")
public class  VaccineList{
	
	@Id
	private int id;
	private String vaccinename;
	private String details;
	private String months;

	
	
	@Override
    public String toString() {
        return "ChildDetails {" +
                " id= " + id +
                " name= " + vaccinename 
                +" }";
	}



	public int getId() {
		return id;
	}



	public void setId(int id) {
		this.id = id;
	}



	public String getVaccinename() {
		return vaccinename;
	}



	public void setVaccinename(String vaccinename) {
		this.vaccinename = vaccinename;
	}



	public String getDetails() {
		return details;
	}



	public void setDetails(String details) {
		this.details = details;
	}


	public String getMonths() {
		return months;
	}

	public void setMonths(String months) {
		this.months = months;
	}


}
