package com.uwindsor.unnovate.aya.model;


import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "doctors_list")
public class  DoctorsList{
	
	@Id
	private int docid;
	private String docname;
	private String specialist;
	private String address;
	private String mobileno;

	
	
	@Override
    public String toString() {
        return "Doctor Details {" +
                " id= " + docid +
                " name= " + docname 
                +" }";
	}



	public int getDocid() {
		return docid;
	}



	public void setDocid(int docid) {
		this.docid = docid;
	}



	public String getDocname() {
		return docname;
	}



	public void setDocname(String docname) {
		this.docname = docname;
	}



	public String getSpecialist() {
		return specialist;
	}



	public void setSpecialist(String specialist) {
		this.specialist = specialist;
	}



	public String getAddress() {
		return address;
	}



	public void setAddress(String address) {
		this.address = address;
	}



	public String getMobileno() {
		return mobileno;
	}



	public void setMobileno(String mobileno) {
		this.mobileno = mobileno;
	}

	

}
