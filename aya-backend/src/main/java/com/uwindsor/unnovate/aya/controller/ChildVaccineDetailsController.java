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
import com.uwindsor.unnovate.aya.model.ChildVaccineDetails;
import com.uwindsor.unnovate.aya.model.ChildsNutrition;
import com.uwindsor.unnovate.aya.model.VaccineList;
import com.uwindsor.unnovate.aya.repository.ChildDetailsRepository;
import com.uwindsor.unnovate.aya.repository.ChildVaccineDetailsRepository;
import com.uwindsor.unnovate.aya.repository.VaccineListRepository;

@RestController
public class ChildVaccineDetailsController {
	
	@Autowired
    private ChildVaccineDetailsRepository childVaccineDetailsRepository;

	
	@Autowired
    private ChildDetailsRepository childRepository;

	@RequestMapping(
			  value = "/childvaccinedetails/create", 
			  method = RequestMethod.POST, 
			  headers = "Accept=application/json")
	@ResponseBody
	    public String createParentsDetails(@RequestBody String id) throws Exception {
		 //create ObjectMapper instance
		System.out.println("Inside create");
        ObjectMapper objectMapper = new ObjectMapper();

        //read JSON file and convert to a customer object
        ChildVaccineDetails customer = objectMapper.readValue(id, ChildVaccineDetails.class);

        //print customer details
        
        childVaccineDetailsRepository.save(customer);
        System.out.println(customer.toString());
	        return "Parent " +customer.getVaccineid() + " added successfully.";
	    }
	
	@RequestMapping(
			  value = "/childvaccinedetails/update", 
			  method = RequestMethod.POST, 
			  headers = "Accept=application/json")
	@ResponseBody
	    public String updateParentsDetails(@RequestBody String id) throws Exception {
		
		System.out.println("Inside update");
		 //create ObjectMapper instance
      ObjectMapper objectMapper = new ObjectMapper();

      //read JSON file and convert to a customer object
      ChildVaccineDetails customer = objectMapper.readValue(id, ChildVaccineDetails.class);
         
      childVaccineDetailsRepository.save(customer);
      //print customer details
      System.out.println(customer.toString());
	        return "Hello World RESTful with Spring Boot:-  " +id;
	    }
	
	@RequestMapping(
			  value = "/childvaccinedetails/delete", 
			  method = RequestMethod.POST, 
			  headers = "Accept=application/json")
	@ResponseBody
	    public String deleteParentsDetails(@RequestBody String id) throws Exception {
		
		System.out.println("Inside delete functionality");
		 //create ObjectMapper instance
      ObjectMapper objectMapper = new ObjectMapper();

      //read JSON file and convert to a customer object
      ChildVaccineDetails customer = objectMapper.readValue(id, ChildVaccineDetails.class);

      //print customer details
      System.out.println(customer.toString());
      childVaccineDetailsRepository.delete(customer);
	        return "Hello World RESTful with Spring Boot:-  " +id;
	    }
	
	@RequestMapping(
			  value = "/childvaccinedetails/read", 
			  method = RequestMethod.POST,
			  headers = "Accept=text/plain")
	@ResponseBody
	    public String readParentsDetails(@RequestBody String id) throws Exception {
		System.out.println("Inside read");
		 //create ObjectMapper instance
      ObjectMapper objectMapper = new ObjectMapper();
      id = id.replaceAll("\"", "");
      ChildDetails cd = childRepository.findById(Integer.parseInt(id));
      List <ChildVaccineDetails> list = childVaccineDetailsRepository.findAll();
      List <ChildVaccineDetails> returnList = new ArrayList<ChildVaccineDetails>();
      //print customer details
      String age="";
      ChildsNutrition cnd = new ChildsNutrition();
      for(int j =0;j<list.size();j++)
      {
    	  ChildVaccineDetails cvd = list.get(j);
    	  System.out.println("Vaccine details 1:- " + cvd.getChildid());
    	  System.out.println("Vaccine details 2:- " + cvd.getVaccineid());
    	  System.out.println("Vaccine details 3:- " + cvd.getMonth());
    	  System.out.println("Vaccine details 4:- " + cvd.getId());
      }
      LocalDate curDate = LocalDate.now(); 
      if ((cd.getDob() != null) && (curDate != null))   
      {  
    	  age= Period.between(LocalDate.parse(cd.getDob()), curDate).getMonths()+"";  
      }  
      else  
      {  
    	  age="0";  
      }  
      
      for(int i=0;i<list.size();i++)
      {
    	  ChildVaccineDetails cvd = list.get(i);
    	  if(cvd.getChildid().equals(id) && Integer.parseInt(cvd.getMonth()) <= (Integer.parseInt(age)+1) && cvd.getTaken().equals("0")) {
    		  returnList.add(cvd);
    	  }
    	  System.out.println("Parent name is :- "+cvd.getChildid());
      }
      
      String jsonStr = objectMapper.writeValueAsString(returnList);
      return jsonStr;
	    }

}
