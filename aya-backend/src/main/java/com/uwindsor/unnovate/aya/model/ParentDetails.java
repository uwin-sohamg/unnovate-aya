package com.uwindsor.unnovate.aya.model;


import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "parents_details")
public class ParentDetails {
	
	@Id
	private int id;
	private String parentsname;
	private String emailid;
	private String mobileno;
	
	
	@Override
    public String toString() {
        return "ParentDetails {" +
                " id= " + id +
                " name= " + parentsname 
                +" }";
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getParentsname() {
		return parentsname;
	}


	public void setParentsname(String parentsname) {
		this.parentsname = parentsname;
	}


	public String getEmailid() {
		return emailid;
	}


	public void setEmailid(String emailid) {
		this.emailid = emailid;
	}


	public String getMobileno() {
		return mobileno;
	}


	public void setMobileno(String mobileno) {
		this.mobileno = mobileno;
	}

}
