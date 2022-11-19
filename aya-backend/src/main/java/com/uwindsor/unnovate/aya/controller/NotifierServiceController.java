package com.uwindsor.unnovate.aya.controller;

import java.time.LocalDate;
import java.time.Period;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.uwindsor.unnovate.aya.model.ChildDetails;
import com.uwindsor.unnovate.aya.model.ChildVaccineDetails;
import com.uwindsor.unnovate.aya.model.DocAppointmentSchedule;
import com.uwindsor.unnovate.aya.model.VaccineList;
import com.uwindsor.unnovate.aya.repository.ChildDetailsRepository;
import com.uwindsor.unnovate.aya.repository.ChildVaccineDetailsRepository;
import com.uwindsor.unnovate.aya.repository.DocAppointmentScheduleRepository;
import com.uwindsor.unnovate.aya.repository.DoctorListRepository;
import com.uwindsor.unnovate.aya.repository.VaccineListRepository;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/*import com.fasterxml.jackson.databind.ObjectMapper;
import com.uwindsor.unnovate.aya.model.DocAppointmentSchedule;*/

@RestController
public class NotifierServiceController {
	@Autowired
    private ChildDetailsRepository childRepository;
	@Autowired
    private VaccineListRepository vaccineListRepository;
	
	private String to = "sohamgoswami2015@gmail.com";
	private String from = "aya.childcare.uwin@gmail.com";
	@Autowired
    private ChildVaccineDetailsRepository childVaccineDetailsRepository;
	@RequestMapping(
			  value = "/NotifierServiceController/VaccineNotification", 
			  method = RequestMethod.GET)

	@ResponseBody
	public String VaccineNotification() throws Exception {
		 String MailBody = "";
		 LocalDate curDate = LocalDate.now(); 
		 int curmonth = curDate.getMonthValue();
		try {
		// Start>> DB check for vaccine data
			List <ChildVaccineDetails> vclist = childVaccineDetailsRepository.findAll();
			  List <ChildDetails> cdlist = childRepository.findAll();
			  List <VaccineList> vlist = vaccineListRepository.findAll();
			  int age = 0 ,month = 0 ;
		      //print customer details
		      for(int i=0;i<cdlist.size();i++)
		      {
		    	  if((cdlist.get(i).getDob() != null) && (curDate != null)) {
		    		  age= Period.between(LocalDate.parse(cdlist.get(i).getDob()), curDate).getMonths();
		    		 
		    		  for(int j = 0 ; j<vclist.size();j++) {
		    			  month =Integer.parseInt(vclist.get(j).getMonth());
		    			  if( month == age+1 && cdlist.get(i).getId() == Integer.parseInt(vclist.get(j).getChildid())) 
				    	  {     			    	
				    		  MailBody += "The upcomming vaccine for child name: "+cdlist.get(i).getName()+
				    				  		" || Vaccine name : "+vlist.get(Integer.parseInt(vclist.get(j).getVaccineid())).getVaccinename()+"\n\n";
				    	 
				    	  }
		    		  }
		    	  
		    	  }
		    	 
		     }
		      
		// End>> DB check for vaccine data
		
        String sub = "Vaccine Reminder";
      
        boolean IsMsgSent = SendEmail(from,to,sub,MailBody);
		// End Send Email
	
        return MailBody;
	    
	}catch(Exception ex) {
		return ex.getMessage();
		}

}
	@Autowired
    private DocAppointmentScheduleRepository docAppointmentScheduleRepository;
	

	@Autowired
    private DoctorListRepository doctorListRepository;

	@RequestMapping(
			  value = "/NotifierServiceController/DoctorAppointmentNotification", 
			  method = RequestMethod.GET)

	@ResponseBody
	public String DoctorAppointmentNotification() throws Exception {
		
		try {
		// Start>> DB check for doctor appointment data
			 String Mailbody = "";
			 LocalDate curDate = LocalDate.now(); 
		     List <DocAppointmentSchedule> list = docAppointmentScheduleRepository.findAll();
		     
		      for(int i=0;i<list.size();i++)
		      {
		    	  int days = Period.between(curDate,LocalDate.parse(list.get(i).getDate())).getDays();
		      
		    	  if( days > 0  && days<=7) 
		    	  { 
		    		  Mailbody += "The upcomming appointment for child name: "+childRepository.findById(Integer.parseInt(list.get(i).getChildid())).getName()+
		    				  		" with Doctor "+list.get(i).getDoctorid()+" at "+list.get(i).getDate()+" :"+list.get(i).getTime()+"\n\n";
		    	  }
		      }
		    // Start>> DB check for doctor appointment data
		
		  String sub = "Doctor's Appoinment Reminder";
     
        boolean IsMailSent = SendEmail(from,to,sub,Mailbody);
		// End Send Email
	
        return Mailbody;
	    
	}catch(Exception ex) {
		return ex.getMessage();
		}

}

	public static boolean SendEmail(String From , String To ,String Subject ,String Body) {
		try {
			String host = "smtp.gmail.com";
	        Properties properties =  new Properties();
	        properties.put("mail.smtp.host", host); 
			properties.put("mail.smtp.port", 587);
		    properties.put("mail.smtp.auth", "true");
			properties.put("mail.smtp.ssl.trust", host);
			properties.put("mail.smtp.starttls.enable", "true");
			properties.put("mail.smtp.user", From);
			 
	        Session session = Session.getInstance(properties, new javax.mail.Authenticator() {

	            protected PasswordAuthentication getPasswordAuthentication() {

	                return new PasswordAuthentication("aya.childcare.uwin@gmail.com", "nmkoyxjgfbgfxmyr");

	            }

	        });
	        session.setDebug(true);

	        try {
	            
	            MimeMessage message = new MimeMessage(session);
	            message.setFrom(new InternetAddress(From));
	            message.addRecipient(Message.RecipientType.TO, new InternetAddress(To));
	            message.setSubject(Subject);
	            message.setText(Body);
	            System.out.println("Sending started...");
	            Transport.send(message);
	            System.out.println("Email sent successfully....");
	        } catch (MessagingException ex) {
	            throw ex;
	        }
	        return true ;
		 } catch (Exception ex) {
			 ex.getMessage();
			 return false ;   
			// throw ex;
	            
	        }
		 }
}
