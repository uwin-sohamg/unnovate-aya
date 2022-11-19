package com.uwindsor.unnovate.aya.controller;

import java.time.LocalDate;
import java.time.Period;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.uwindsor.unnovate.aya.model.ChildDetails;
import com.uwindsor.unnovate.aya.model.ChildsNutrition;
import com.uwindsor.unnovate.aya.repository.ChildsNutritionRepository;

@RestController
public class ChildsNutritionController {
	
	@Autowired
	ChildsNutritionRepository childNutritionDetailsRepository;
	
	@RequestMapping(
			  value = "/childnutrition/fetchDetails", 
			  method = RequestMethod.POST, 
			  headers = "Accept=application/json")
	@ResponseBody
	    public List<ChildsNutrition> fetchNutritionDetails(@RequestBody String id) throws Exception {
		 //create ObjectMapper instance
	      ObjectMapper objectMapper = new ObjectMapper();
	      ChildDetails customer = objectMapper.readValue(id, ChildDetails.class);
	      System.out.println(id);
	      String age="";
	      
	      LocalDate curDate = LocalDate.now(); 
	      if ((customer.getDob() != null) && (curDate != null))   
	      {  
	    	  age= Period.between(LocalDate.parse(customer.getDob()), curDate).getYears()+"";  
	      }  
	      else  
	      {  
	    	  age="0";  
	      }  
	      //cnd.setGender(customer.getGender());
	      List<ChildsNutrition> returnList = new ArrayList<ChildsNutrition>();
	      List<ChildsNutrition> list = childNutritionDetailsRepository.findAll();
	      for(int i = 0; i<list.size();i++) {
	    	  if(list.get(i).getChildage().equals(age) && list.get(i).getGender().equalsIgnoreCase(customer.getGender()))
	    		  returnList.add(list.get(i));
	      }
	    	  return returnList;
		}

}
