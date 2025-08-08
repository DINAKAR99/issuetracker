package in.gov.cgg.service;

import in.gov.cgg.dto.EmailContentDTO;
import in.gov.cgg.dto.EmailDetails;
// Importing required classes
import java.io.File;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

// Annotation
@Service
// Class
// Implementing EmailService interface
public class EmailServiceImpl {

  @Autowired
  private JavaMailSender javaMailSender;

  @Value("${spring.mail.username}")
  private String sender;

  // Method 1
  // To send a simple email
 @Async
  public String sendHtmlMail(EmailDetails details,EmailContentDTO emailContentDTO) {
    try {
      // Create a MIME message
      MimeMessage message = javaMailSender.createMimeMessage();
      MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

      // Set email properties
      helper.setFrom(sender);
      helper.setTo(details.getRecipient());
      helper.setSubject("Ticket ID : "+emailContentDTO.getTicketid()); 
     String htmlContent = 
    "<!DOCTYPE html>" +
    "<html>" +
    "<head>" +
    "<style>" +
    "body { font-family: Arial, sans-serif; background-color: #f9f9f9; color: #333; }" +
    ".container { width: 100%; max-width: 600px; margin: 20px auto; background: #fff; padding: 20px; border-radius: 10px; box-shadow: 0px 0px 15px rgba(0,0,0,0.3); }" +
    ".header {  padding-bottom: 20px; border-bottom: 2px solid #007bff; }" +
    ".content { padding: 20px 0; }" +
    ".content h3 { color: #007bff;  }" +
    ".content p { font-size: 16px; line-height: 1.6;   }" +
    ".cta-button { text-align: center; margin-top: 20px; }" +
    ".cta-button a { background-color: #007bff; color: white; padding: 12px 20px; text-decoration: none; font-size: 16px; border-radius: 5px; display: inline-block; }" +
    ".cta-button a:hover { background-color: #0056b3; }" +
    ".footer { text-align: center; margin-top: 20px; font-size: 12px; color: #888888; }" +
    "</style>" +
    "</head>" +
    "<body>" +
    "<div class='container'>" +
    "<div class='header'>" +
    "<h2>Ticketing System</h2>" +
    "</div>" +
    "<div class='content'>" +
    "<h3>Dear " + emailContentDTO.getUser() + ",</h3>" +
    "<p>A support ticket has been raised. Below are the details:</p>" +
    "<p><strong>Ticket ID:</strong> " + emailContentDTO.getTicketid() + "</p>" +
    // "<p><strong>Priority:</strong> " + emailContentDTO.getTicketPriority() + "</p>" +
    "<p><strong>Description:</strong></p>" +
    "<p>" + emailContentDTO.getTicketDescription() + "</p>" +
    "<div class='cta-button'>" +
    // "<a href='" +  emailContentDTO.getUrl()  + "'>View Ticket</a>" +
    "</div>" +
    "</div>" +
    "<div class='footer'>" +
    "<p></p>" +
    "<p>Best regards,<br>Ticketing System Support Team</p>" +
    "</div>" +
    "</div>" +
    "</body>" +
    "</html>";


      // Set HTML content in the email
      helper.setText(htmlContent, true); // 'true' enables HTML

      // Send the email
      javaMailSender.send(message);
      System.out.println("--MAIL SENT SUCCESSFULLY--");
      return "HTML Mail Sent Successfully...";
    } catch (MessagingException e) {
      System.out.println("--MAIL SENT FAILED--");
      return "Error while Sending HTML Mail: " + e.getMessage();
    }
  }

  
  // Method 2
  // To send an email with attachment
  public String sendMailWithAttachment(EmailDetails details) {
    // Creating a mime message
    MimeMessage mimeMessage = javaMailSender.createMimeMessage();
    MimeMessageHelper mimeMessageHelper;

    try {
      // Setting multipart as true for attachments to
      // be send
      mimeMessageHelper = new MimeMessageHelper(mimeMessage, true);
      mimeMessageHelper.setFrom(sender);
      mimeMessageHelper.setTo(details.getRecipient());
      mimeMessageHelper.setText(details.getMsgBody());
      mimeMessageHelper.setSubject(details.getSubject());

      // Adding the attachment
      FileSystemResource file = new FileSystemResource(
        new File(details.getAttachment())
      );

      mimeMessageHelper.addAttachment(file.getFilename(), file);

      // Sending the mail
      javaMailSender.send(mimeMessage);
      return "Mail sent Successfully";
    } catch (MessagingException e) { // Catch block to handle MessagingException
      // Display message when exception occurred
      return "Error while sending mail!!!";
    }
  }
}
