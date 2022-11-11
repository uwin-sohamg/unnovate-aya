package com.uwindsor.unnovate.aya.model;


import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "childs_nutrition")
public class ChildsNutrition {
	
	@Id
	private int id;
	private String childage;
	private String gender;
	private String calories;
	private String protein;
	private String dairy;
	private String food;
	
	
	@Override
    public String toString() {
        return "ChildDetails {" +
                " id= " + id +
                " name= " + childage 
                +" }";
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getChildage() {
		return childage;
	}


	public void setChildage(String childage) {
		this.childage = childage;
	}


	public String getGender() {
		return gender;
	}


	public void setGender(String gender) {
		this.gender = gender;
	}


	public String getCalories() {
		return calories;
	}


	public void setCalories(String calories) {
		this.calories = calories;
	}


	public String getProtein() {
		return protein;
	}


	public void setProtein(String protein) {
		this.protein = protein;
	}


	public String getDairy() {
		return dairy;
	}


	public void setDairy(String dairy) {
		this.dairy = dairy;
	}


	public String getFood() {
		return food;
	}


	public void setFood(String food) {
		this.food = food;
	}

}
