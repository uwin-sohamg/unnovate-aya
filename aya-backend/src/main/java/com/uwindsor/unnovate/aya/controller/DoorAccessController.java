package com.uwindsor.unnovate.aya.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.uwindsor.unnovate.aya.model.DoorAccessLogs;
import com.uwindsor.unnovate.aya.repository.DoorAccessLogsRepository;

@RestController
public class DoorAccessController {
	
	@Autowired
	DoorAccessLogsRepository doorAccessLogsRepository;
	
	@RequestMapping(
			  value = "/dooraccess/authenticate", 
			  method = RequestMethod.POST, 
			  headers = "Accept=text/plain")
	@ResponseBody
	    public String accessDoor(@RequestBody String id) throws Exception {
		 //create ObjectMapper instance
		System.out.println(id);
	      if(id.equals("1234")) {
	    	  System.out.println("Access Granted");
	    	  DoorAccessLogs da = new DoorAccessLogs();
	    	  da.setDate(java.time.LocalDate.now().toString());
	    	  da.setTime(java.time.LocalTime.now().toString());
	    	  da.setStatus("Authorized");
	    	  da.setTime("112523");
	    	  doorAccessLogsRepository.save(da);
		        return "Access Granted";}
	      else {
	    	  System.out.println("Access Not Granted");
	    	  DoorAccessLogs da = new DoorAccessLogs();
	    	  da.setDate(java.time.LocalDate.now().toString());
	    	  da.setTime(java.time.LocalTime.now().toString());
	    	  da.setStatus("Unauthorized");
	    	  da.setTime("112523");
	    	  doorAccessLogsRepository.save(da);
	    	  return "Access Not Granted";
	      }
		}

}
