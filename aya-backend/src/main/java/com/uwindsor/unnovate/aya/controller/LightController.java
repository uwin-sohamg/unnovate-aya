package com.uwindsor.unnovate.aya.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.uwindsor.unnovate.aya.model.LightStatus;
import com.uwindsor.unnovate.aya.repository.LightStatusRepository;

@RestController
public class LightController {
	
	@Autowired
    private LightStatusRepository lightStatusRepository;
	
	@RequestMapping(
			  value = "/lightstatus/changeLightStatus", 
			  method = RequestMethod.POST, 
			  headers = "Accept=text/plain")
	@ResponseBody
	    public String changeLightStatus(@RequestBody String id) throws Exception {
		 //create ObjectMapper instance
		List<LightStatus> ls = lightStatusRepository.findAll();
		String currentStatus="";
		LightStatus cd = new LightStatus();
		id = id.replaceAll("\"", "");
		 for(int i=0;i<ls.size();i++)
	      {
			 cd = ls.get(i);
			 currentStatus = cd.getStatus();
	      }
		 if(currentStatus.equals(id))
			 return "Light Status Unchanged";
		 else if(id.equals("0")) {
			 cd.setStatus(id);
			 lightStatusRepository.save(cd);
	    	  System.out.println("Light Turned ON");
		        return "Light Turned ON";}
	      else {
	    	  cd.setStatus(id);
	    	  lightStatusRepository.save(cd);
	    	  System.out.println("Light Turned OFF");
	    	  return "Light Turned OFF";
	      }
		}
	
	@RequestMapping(
			  value = "/lightstatus/currentLightStatus", 
			  method = RequestMethod.GET)
	@ResponseBody
	    public String currentLightStatus() throws Exception {
		 //create ObjectMapper instance
		List<LightStatus> ls = lightStatusRepository.findAll();
		String currentStatus="";
		 for(int i=0;i<ls.size();i++)
	      {
			 LightStatus cd = ls.get(i);
			 currentStatus = cd.getStatus();
	      }
		return currentStatus;
		}

}
