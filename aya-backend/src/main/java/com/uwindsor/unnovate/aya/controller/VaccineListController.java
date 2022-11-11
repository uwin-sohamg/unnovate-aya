package com.uwindsor.unnovate.aya.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.uwindsor.unnovate.aya.model.VaccineList;
import com.uwindsor.unnovate.aya.repository.VaccineListRepository;

@RestController
public class VaccineListController {
	
	@Autowired
    private VaccineListRepository vaacinelistRepository;

	@RequestMapping(
			  value = "/vaccinelist/create", 
			  method = RequestMethod.POST, 
			  headers = "Accept=application/json")
	@ResponseBody
	    public String createKidsDetails(@RequestBody String id) throws Exception {
		 //create ObjectMapper instance
		System.out.println("Inside create");
        ObjectMapper objectMapper = new ObjectMapper();

        //read JSON file and convert to a customer object
        VaccineList customer = objectMapper.readValue(id, VaccineList.class);

        //print customer details
        
        vaacinelistRepository.save(customer);
        System.out.println(customer.toString());
	        return "Child " +customer.getVaccinename() + " added successfully.";
	    }
	
	@RequestMapping(
			  value = "/vaccinelist/update", 
			  method = RequestMethod.POST, 
			  headers = "Accept=application/json")
	@ResponseBody
	    public String updateKidsDetails(@RequestBody String id) throws Exception {
		
		System.out.println("Inside update");
		 //create ObjectMapper instance
      ObjectMapper objectMapper = new ObjectMapper();

      //read JSON file and convert to a customer object
      VaccineList customer = objectMapper.readValue(id, VaccineList.class);
      VaccineList cd = vaacinelistRepository.findById(customer.getId());
      
      vaacinelistRepository.save(cd);
      //print customer details
      System.out.println(customer.toString());
	        return "Hello World RESTful with Spring Boot:-  " +id;
	    }
	
	@RequestMapping(
			  value = "/vaccinelist/delete", 
			  method = RequestMethod.POST, 
			  headers = "Accept=application/json")
	@ResponseBody
	    public String deleteKidsDetails(@RequestBody String id) throws Exception {
		
		System.out.println("Inside delete functionality");
		 //create ObjectMapper instance
      ObjectMapper objectMapper = new ObjectMapper();

      //read JSON file and convert to a customer object
      VaccineList customer = objectMapper.readValue(id, VaccineList.class);

      //print customer details
      System.out.println(customer.toString());
      vaacinelistRepository.delete(customer);
	        return "Hello World RESTful with Spring Boot:-  " +id;
	    }
	
	@RequestMapping(
			  value = "/vaccinelist/read", 
			  method = RequestMethod.GET)
	@ResponseBody
	    public String readKidsDetails() throws Exception {
		System.out.println("Inside read");
		 //create ObjectMapper instance
      ObjectMapper objectMapper = new ObjectMapper();

      List <VaccineList> list = vaacinelistRepository.findAll();
      //print customer details
      for(int i=0;i<list.size();i++)
      {
    	  VaccineList cd = list.get(i);
    	  System.out.println("Child name is :- "+cd.getVaccinename());
    	  System.out.println("Child Dotor name is :- "+cd.getDetails());
      }
      
      String jsonStr = objectMapper.writeValueAsString(list);
    		  return jsonStr;
	    }

}
