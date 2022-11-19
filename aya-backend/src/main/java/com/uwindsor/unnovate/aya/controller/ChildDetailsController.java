package com.uwindsor.unnovate.aya.controller;

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
import com.uwindsor.unnovate.aya.model.VaccineList;
import com.uwindsor.unnovate.aya.repository.ChildDetailsRepository;
import com.uwindsor.unnovate.aya.repository.ChildVaccineDetailsRepository;
import com.uwindsor.unnovate.aya.repository.VaccineListRepository;

@RestController
public class ChildDetailsController {
	
	@Autowired
    private ChildDetailsRepository childRepository;
	
	@Autowired
    private ChildVaccineDetailsRepository childVaccineDetailsRepository;
	
	@Autowired
    private VaccineListRepository vaccineListRepository;

	@RequestMapping(
			  value = "/kidsprofile/create", 
			  method = RequestMethod.POST, 
			  headers = "Accept=application/json")
	@ResponseBody
	    public String createKidsDetails(@RequestBody String id) throws Exception {
		 //create ObjectMapper instance
		System.out.println("Inside create");
        ObjectMapper objectMapper = new ObjectMapper();

        //read JSON file and convert to a customer object
        ChildDetails customer = objectMapper.readValue(id, ChildDetails.class);

        //print customer details
        
        ChildDetails newChild = childRepository.save(customer);
        List <VaccineList> list = vaccineListRepository.findAll();
        List <ChildVaccineDetails> vaccineDetailsList = new ArrayList<ChildVaccineDetails>();
        List <ChildVaccineDetails> newList = new ArrayList<ChildVaccineDetails>();
        newList = childVaccineDetailsRepository.findAll();
        List <ChildDetails> childList = childRepository.findAll();
        int childId=0;
        int identity =1;
        
        for(int i =0 ;i<newList.size();i++) {
        	ChildVaccineDetails cvd1 = newList.get(i);
        	if(identity< cvd1.getId())
        		identity=cvd1.getId();
        }
        
        for(int i =0 ;i<childList.size();i++) {
        	ChildDetails cvd1 = childList.get(i);
        	if(childId< cvd1.getId())
        		childId=cvd1.getId();
        }
        
        for(int i=0;i<list.size();i++)
        {
      	  VaccineList vl = list.get(i);
      	  String[] res = vl.getMonths().split("[,]", 0);
      	  for(String myStr: res) {
      		  ChildVaccineDetails cvd = new ChildVaccineDetails();
      		  cvd.setId(identity);
      		  cvd.setChildid(childId+"");
      		  cvd.setMonth(myStr);
      		  cvd.setTaken("0");
      		  cvd.setVaccineid(vl.getId()+"");
      		  cvd.setVaccinename(vl.getVaccinename());
      		vaccineDetailsList.add(cvd);
      		identity++;
      	  }
      	childVaccineDetailsRepository.saveAll(vaccineDetailsList);
      	  System.out.println("Parent name is :- "+vl.getVaccinename());
        }
        System.out.println(customer.toString());
	        return "Child " +customer.getName() + " added successfully.";
	    }
	
	@RequestMapping(
			  value = "/kidsprofile/update", 
			  method = RequestMethod.POST, 
			  headers = "Accept=application/json")
	@ResponseBody
	    public String updateKidsDetails(@RequestBody String id) throws Exception {
		
		System.out.println("Inside update");
		 //create ObjectMapper instance
      ObjectMapper objectMapper = new ObjectMapper();

      //read JSON file and convert to a customer object
      ChildDetails customer = objectMapper.readValue(id, ChildDetails.class);
      ChildDetails cd = childRepository.findById(customer.getId());
      cd.setDob(customer.getDob());
      cd.setDocid(customer.getDocid());
      cd.setGender(customer.getGender());
      cd.setName(customer.getName());
      
      childRepository.save(cd);
      //print customer details
      System.out.println(customer.toString());
	        return "Hello World RESTful with Spring Boot:-  " +id;
	    }
	
	@RequestMapping(
			  value = "/kidsprofile/delete", 
			  method = RequestMethod.POST, 
			  headers = "Accept=application/json")
	@ResponseBody
	    public String deleteKidsDetails(@RequestBody String id) throws Exception {
		
		System.out.println("Inside delete functionality");
		 //create ObjectMapper instance
      ObjectMapper objectMapper = new ObjectMapper();

      //read JSON file and convert to a customer object
      ChildDetails customer = objectMapper.readValue(id, ChildDetails.class);

      //print customer details
      System.out.println(customer.toString());
      childRepository.delete(customer);
	        return "Hello World RESTful with Spring Boot:-  " +id;
	    }
	
	@RequestMapping(
			  value = "/kidsprofile/read", 
			  method = RequestMethod.GET)
	@ResponseBody
	    public String readKidsDetails() throws Exception {
		System.out.println("Inside read");
		 //create ObjectMapper instance
      ObjectMapper objectMapper = new ObjectMapper();

      List <ChildDetails> list = childRepository.findAll();
      //print customer details
      for(int i=0;i<list.size();i++)
      {
    	  ChildDetails cd = list.get(i);
    	  System.out.println("Child name is :- "+cd.getName());
    	  System.out.println("Child Dotor name is :- "+cd.getDocid());
      }
      
      String jsonStr = objectMapper.writeValueAsString(list);
      return jsonStr;
	    }
	
	@RequestMapping(
			  value = "/kidsprofile/readById", 
			  method = RequestMethod.POST, 
			  headers = "Accept=text/plain")
	@ResponseBody
	    public String readKidByIdDetails(@RequestBody String id) throws Exception {
		System.out.println("Inside read");
		 //create ObjectMapper instance
    ObjectMapper objectMapper = new ObjectMapper();

    ChildDetails cd = childRepository.findById(Integer.parseInt(id));
    
    String jsonStr = objectMapper.writeValueAsString(cd);
    return jsonStr;
	}

}
