package in.gov.cgg.controller;

import in.gov.cgg.dto.EmailContentDTO;
import in.gov.cgg.dto.EmailDetails;
import in.gov.cgg.service.EmailServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

// Annotation
@RestController
// Class
public class EmailController {

  @Autowired
  private EmailServiceImpl emailService;

  // Sending a simple Email
  @PostMapping("/sendMail")
  public String sendMail(@RequestBody EmailDetails details) {
    EmailContentDTO nContentDTO=new EmailContentDTO();
    nContentDTO.setContent("dd");
    nContentDTO.setTicketPriority("low");
    nContentDTO.setTicketStatus("open");
    nContentDTO.setTicketid("tck15");
    nContentDTO.setTicketDescription("sssss");
    details.setRecipient("karenguladinakar@gmail.com");
    details.setSubject("test");
    String status = emailService.sendHtmlMail(details,nContentDTO);

    return status;
  }

  // Sending email with attachment
  @PostMapping("/sendMailWithAttachment")
  public String sendMailWithAttachment(@RequestBody EmailDetails details) {
    String status = emailService.sendMailWithAttachment(details);

    return status;
  }
}
