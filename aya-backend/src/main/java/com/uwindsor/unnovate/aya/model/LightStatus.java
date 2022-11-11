package com.uwindsor.unnovate.aya.model;


import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "light_status")
public class LightStatus {
	
	@Id
	private int id;
	private String status;
	
	@Override
    public String toString() {
        return "ChildDetails {" +
                " id= " + id +
                " status= " + status 
                +" }";
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}

}
