package com.uwindsor.unnovate.aya.controller;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.uwindsor.unnovate.aya.model.ChildDetails;

@RestController
public class MusicController {
	

	@RequestMapping(
			  value = "/musicprofile/inbuiltgenre", 
			  method = RequestMethod.POST, 
			  headers = "Accept=application/json")
	@ResponseBody
	    public String readMusicGenreDetails(@RequestBody String id) throws Exception {
		 //create ObjectMapper instance
      ObjectMapper objectMapper = new ObjectMapper();

      //read JSON file and convert to a customer object
      ChildDetails customer = objectMapper.readValue(id, ChildDetails.class);

      //print customer details
      System.out.println(customer.toString());
	        return "Hello World RESTful with Spring Boot:-  " +id;
	    }

}
