package ptithcm.controller;


import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;



@Controller
public  class Mail {
	@Autowired
	JavaMailSender mailer;
	
	@RequestMapping(value = "abcdefgh", method = RequestMethod.GET)
	public   void RequestNewPassword(ModelMap model ,HttpServletRequest request, HttpSession session, HttpServletResponse response) throws IOException {	
	
			if(session.getAttribute("JWT") !=null && session.getAttribute("email")!=null) {
				String from = "hanhphuclagi17042000@gmail.com",
						subject = "Yêu cầu mật khẩu mới",
						jwt = (String) session.getAttribute("JWT"),
						to = (String) session.getAttribute("email"),
						body = "Theo đường dẫn này, bạn có thể thay đổi mật khẩu " +
								String.format("http://localhost:8080/%s/RecoverPassword.html?jwt=%s", request.getContextPath(),jwt);
						
						
				
						
						session.setAttribute("email", null);
						session.setAttribute("JWT", null);
						MimeMessage mail = mailer.createMimeMessage();	
						MimeMessageHelper helper = new MimeMessageHelper(mail);
					
						try {
							helper.setFrom(from,from);
							helper.setTo(to);
							helper.setReplyTo(from,from);
							helper.setSubject(subject);
							helper.setText(body,true);
							mailer.send(mail);
						
						} catch (UnsupportedEncodingException e) {
							e.printStackTrace();
						} catch (MessagingException e) {
							e.printStackTrace();
						}
			}
			
			response.sendRedirect(request.getContextPath() +"/forgot.html");
			
	}
}
