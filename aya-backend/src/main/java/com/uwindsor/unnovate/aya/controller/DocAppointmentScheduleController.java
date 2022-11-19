package com.uwindsor.unnovate.aya.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.uwindsor.unnovate.aya.model.DocAppointmentSchedule;
import com.uwindsor.unnovate.aya.model.DoctorsList;
import com.uwindsor.unnovate.aya.repository.DocAppointmentScheduleRepository;
import com.uwindsor.unnovate.aya.repository.DoctorListRepository;

@RestController
public class DocAppointmentScheduleController {
	
	@Autowired
    private DocAppointmentScheduleRepository docAppointmentScheduleRepository;
	
	@Autowired
    private DoctorListRepository doctorListRepository;

	@RequestMapping(
			  value = "/docAppointment/create", 
			  method = RequestMethod.POST, 
			  headers = "Accept=application/json")
	@ResponseBody
	    public String createdocAppointment(@RequestBody String id) throws Exception {
		 //create ObjectMapper instance
		System.out.println("Inside create");
        ObjectMapper objectMapper = new ObjectMapper();

        //read JSON file and convert to a customer object
        DocAppointmentSchedule customer = objectMapper.readValue(id, DocAppointmentSchedule.class);

        //print customer details
        
        docAppointmentScheduleRepository.save(customer);
        System.out.println(customer.toString());
	        return "Doc Appointment " +customer.getChildid() + " added successfully.";
	    }
	
	@RequestMapping(
			  value = "/docAppointment/update", 
			  method = RequestMethod.POST, 
			  headers = "Accept=application/json")
	@ResponseBody
	    public String updatedocAppointment(@RequestBody String id) throws Exception {
		
		System.out.println("Inside update");
		 //create ObjectMapper instance
      ObjectMapper objectMapper = new ObjectMapper();

      //read JSON file and convert to a customer object
      DocAppointmentSchedule customer = objectMapper.readValue(id, DocAppointmentSchedule.class);
      DocAppointmentSchedule cd = docAppointmentScheduleRepository.findById(customer.getId());
      cd.setDate(customer.getDate());
      cd.setTime(customer.getTime());
      
      docAppointmentScheduleRepository.save(cd);
      //print customer details
      System.out.println(customer.toString());
	        return "Hello World RESTful with Spring Boot:-  " +id;
	    }
	
	@RequestMapping(
			  value = "/docAppointment/delete", 
			  method = RequestMethod.POST, 
			  headers = "Accept=application/json")
	@ResponseBody
	    public String deletedocAppointment(@RequestBody String id) throws Exception {
		
		System.out.println("Inside delete functionality");
		 //create ObjectMapper instance
      ObjectMapper objectMapper = new ObjectMapper();

      //read JSON file and convert to a customer object
      DocAppointmentSchedule customer = objectMapper.readValue(id, DocAppointmentSchedule.class);

      //print customer details
      System.out.println(customer.toString());
      docAppointmentScheduleRepository.delete(customer);
	        return "Hello World RESTful with Spring Boot:-  " +id;
	    }
	
	@RequestMapping(
			  value = "/docAppointment/read", 
			  method = RequestMethod.GET)
	@ResponseBody
	    public String readdocAppointment() throws Exception {
		System.out.println("Inside read");
		 //create ObjectMapper instance
      ObjectMapper objectMapper = new ObjectMapper();

      List <DocAppointmentSchedule> list = docAppointmentScheduleRepository.findAll();
      //print customer details
      for(int i=0;i<list.size();i++)
      {
    	  DocAppointmentSchedule cd = list.get(i);
    	  System.out.println("Child id is :- "+cd.getChildid());
      }
      
      String jsonStr = objectMapper.writeValueAsString(list);
    		  return jsonStr;
	    }
	
	@RequestMapping(
			  value = "/doctorList/read", 
			  method = RequestMethod.GET)
	@ResponseBody
	    public String fetchDoctorList() throws Exception {
		System.out.println("Inside read");
		 //create ObjectMapper instance
    ObjectMapper objectMapper = new ObjectMapper();

    List <DoctorsList> list = doctorListRepository.findAll();
    String jsonStr = objectMapper.writeValueAsString(list);
  		  return jsonStr;
	    }

}
