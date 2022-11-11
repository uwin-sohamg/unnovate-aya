package com.uwindsor.unnovate.aya.model;


import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "child_vaccine_details")
public class  ChildVaccineDetails{
	
	private int childid;
	private String vaccineid;
	private String month;
	private String taken;

	
	
	@Override
    public String toString() {
        return "ChildDetails {" +
                " id= " + childid +
                " name= " + vaccineid 
                +" }";
	}



	public int getChildid() {
		return childid;
	}



	public void setChildid(int childid) {
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


}
