package com.uwindsor.unnovate.aya.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.uwindsor.unnovate.aya.model.ParentDetails;
import com.uwindsor.unnovate.aya.repository.ParentDetailsRepository;

@RestController
public class ParentDetailsController {
	
	@Autowired
    private ParentDetailsRepository parentRepository;

	@RequestMapping(
			  value = "/parentdetails/create", 
			  method = RequestMethod.POST, 
			  headers = "Accept=application/json")
	@ResponseBody
	    public String createParentsDetails(@RequestBody String id) throws Exception {
		 //create ObjectMapper instance
		System.out.println("Inside create");
        ObjectMapper objectMapper = new ObjectMapper();

        //read JSON file and convert to a customer object
        ParentDetails customer = objectMapper.readValue(id, ParentDetails.class);

        //print customer details
        
        parentRepository.save(customer);
        System.out.println(customer.toString());
	        return "Parent " +customer.getParentsname() + " added successfully.";
	    }
	
	@RequestMapping(
			  value = "/parentdetails/update", 
			  method = RequestMethod.POST, 
			  headers = "Accept=application/json")
	@ResponseBody
	    public String updateParentsDetails(@RequestBody String id) throws Exception {
		
		System.out.println("Inside update");
		 //create ObjectMapper instance
      ObjectMapper objectMapper = new ObjectMapper();

      //read JSON file and convert to a customer object
      ParentDetails customer = objectMapper.readValue(id, ParentDetails.class);
      ParentDetails cd = parentRepository.findById(customer.getId());
      cd.setEmailid(customer.getEmailid());
      cd.setMobileno(customer.getMobileno());
      cd.setParentsname(customer.getParentsname());      
      parentRepository.save(cd);
      //print customer details
      System.out.println(customer.toString());
	        return "Hello World RESTful with Spring Boot:-  " +id;
	    }
	
	@RequestMapping(
			  value = "/parentdetails/delete", 
			  method = RequestMethod.POST, 
			  headers = "Accept=application/json")
	@ResponseBody
	    public String deleteParentsDetails(@RequestBody String id) throws Exception {
		
		System.out.println("Inside delete functionality");
		 //create ObjectMapper instance
      ObjectMapper objectMapper = new ObjectMapper();

      //read JSON file and convert to a customer object
      ParentDetails customer = objectMapper.readValue(id, ParentDetails.class);

      //print customer details
      System.out.println(customer.toString());
      parentRepository.delete(customer);
	        return "Hello World RESTful with Spring Boot:-  " +id;
	    }
	
	@RequestMapping(
			  value = "/parentdetails/read", 
			  method = RequestMethod.GET)
	@ResponseBody
	    public String readParentsDetails() throws Exception {
		System.out.println("Inside read");
		 //create ObjectMapper instance
      ObjectMapper objectMapper = new ObjectMapper();

      List <ParentDetails> list = parentRepository.findAll();
      //print customer details
      for(int i=0;i<list.size();i++)
      {
    	  ParentDetails cd = list.get(i);
    	  System.out.println("Parent name is :- "+cd.getParentsname());
      }
      
      String jsonStr = objectMapper.writeValueAsString(list);
    		  return jsonStr;
	    }

}
