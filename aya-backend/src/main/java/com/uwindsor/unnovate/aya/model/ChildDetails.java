package com.uwindsor.unnovate.aya.model;

public class ChildDetails {
	
	int id;
	String name;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	@Override
    public String toString() {
        return "ChildDetails {" +
                " id= " + id +
                " name= " + name 
                +" }";
	}

}
