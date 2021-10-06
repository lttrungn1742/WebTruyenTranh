package ptithcm.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import ptithcm.entity.Account;
import ptithcm.entity.Token;
import ptithcm.security.Hash;
import ptithcm.security.JsonWebToken;

@Transactional
@Controller
public class Login {
	@Autowired 	SessionFactory factory;
	
	
	
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String index(ModelMap model,@ModelAttribute("user")Account user, HttpSession session) {
		if(session.getAttribute("user") != null) session.setAttribute("user", null);
		return "login";
	}
	
	@RequestMapping(value = "forgot", method = RequestMethod.GET)
	public String forgot() {
		return "forgot";
	}
	
	@RequestMapping(value = "forgot", method = RequestMethod.POST)
	public void requestNewPsswd(ModelMap model ,HttpServletRequest request, HttpSession session, HttpServletResponse response) throws IOException {
			String email = request.getParameter("email");
			Account user = verifyEmail(email);
			if(user != null &&  user.getEmail().equals(email)) {
			
				Token token = new Token();
				token.setJwt(JsonWebToken.createJWT(user.getUsername()));
				token.setUsed(false);
				token.setId(0);
				insert(token);
				
					session.setAttribute("email", email);
					session.setAttribute("JWT", token.getJwt());
					
					response.sendRedirect(request.getContextPath() +"/abcdefgh.html");
			}
			else {
				model.addAttribute("message","Mã xác thực đã được gửi");
			}
			
	}
	
	@RequestMapping(value = "RecoverPassword", method =  RequestMethod.GET)
	public String requestFromMail(@RequestParam(value = "jwt")String jwt , ModelMap model) throws JSONException {
			if(JsonWebToken.verifier(jwt)) {
				
					model.addAttribute("token",jwt);
					return "recover";
				
			}
		return	"redirect:/index.html";
			
	}
	
	@RequestMapping(value = "recover", method = RequestMethod.POST)
	public String RecoverPassword(HttpServletRequest request,ModelMap model) throws IOException {
		String passwd = request.getParameter("password");
		String confirmpasswd = request.getParameter("confirmpassword");
		String jwt = request.getParameter("token");
			
		if(	confirmpasswd.equals(passwd) ) {
			 System.out.println("True11");
			if(JsonWebToken.verifier(jwt))
			{
			 
				Token token =  verifyToken(jwt);
				if(token != null) {
				
					try {
						JSONObject object = JsonWebToken.getJson(jwt);
						LocalDateTime dateTimeNow = LocalDateTime.now();
						String datetimeStr = object.getString("time");
						
						
						if(dateTimeNow.isBefore(LocalDateTime.parse(datetimeStr, DateTimeFormatter.ISO_DATE_TIME))) {
							
								Account user = getUser((String)object.get("User"));
								if(user != null) {
									user.setPassword(Hash.getHash256(confirmpasswd));
									update(user);
									token.setUsed(true);
									updateToken(token);
									return "redirect:/login.html";
								}
						}
					} catch (JSONException e) {
						
						e.printStackTrace();
					}
			}
				}
			
		}
		else {
			return "recover";
		}
		
		
		return "redirect:/login.html";
	}
		
	@RequestMapping(value = "login", method = RequestMethod.POST)
 	public String index2(@ModelAttribute("user")Account user, HttpSession session) {

		if(verifyLogin(user.getUsername(), user.getPassword()) != null) {
			session.setAttribute("user", user.getUsername());
			return "redirect:/admin/data.html";
		}
		
		return "redirect:/login.html";
		
	}
	@RequestMapping(value = "logout", method = RequestMethod.GET)
	public void logout(HttpServletRequest request,HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		
		if(session.getAttribute("user") != null) {
			session.setAttribute("user", null);
			response.sendRedirect(request.getContextPath()+"/index.html");
		}
		
	}
	
	@RequestMapping(value = "admin", method = RequestMethod.GET)
	public String admin() {
		return "redirect:/admin/data.html";
	}
	
	public Account verifyEmail(String email) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Account where email = :email";
		Query query = session.createQuery(hql);
		query.setParameter("email", email);
		return (Account) query.list().get(0);
	}
	
	public Account verifyLogin(String username, String passowrd) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Account where username = :username";
		Query query = session.createQuery(hql);
		query.setParameter("username", username);
		
		Account temp = (Account) query.list().get(0);
		
		if (temp!=null &&  temp.getPassword().equals(Hash.getHash256(passowrd))) {
			return temp;
		}
		return null;
	}
		
	public Token verifyToken(String jwt) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Token";
		Query query = session.createQuery(hql);
	
		
		List<Token> list =  query.list();
		
		for (Token token : list) {
			if(token.isUsed()  == false && token.getJwt().equals(jwt)) {
				return token;
			}
		}
		
		return null;
	}
	
	public Account getUser(String username) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Account where username = :username";
		Query query = session.createQuery(hql);
		query.setParameter("username", username);
		Account temp = (Account) query.list().get(0);
		
		return temp;
	}
	
	@RequestMapping(value = "/admin/profile", method = RequestMethod.GET)
	public String profile() {
		return "admin/profile";
	}
	
	@RequestMapping(value = "/admin/profile", method = RequestMethod.POST)
	public String ChangePassword(HttpServletRequest request,ModelMap model, HttpSession session) throws IOException {
		String passwd = request.getParameter("password");
		String newpasswd = request.getParameter("newpassword");
		String confirmpasswd = request.getParameter("confirmpassword");
		String username = (String) session.getAttribute("user");
		
		if(newpasswd.equals(confirmpasswd)  && newpasswd.length() != 0 ) {
			Account user = verifyLogin(username, passwd);
			if(user != null)
			{
				user.setPassword(Hash.getHash256(confirmpasswd));
				int result = update(user);
				if(result == 1) {
					model.addAttribute("message" , "{\"success\":true, \"message\":\"Cập nhật thành công\"}");
				}else {
					model.addAttribute("message" , "{\"success\":false, \"message\":\"Cập nhật thất bại\"}");
				}
			}
			else {
				model.addAttribute("message" , "{\"success\":false, \"message\":\"Sai mật khẩu\"}");
			}
		}
		else if(newpasswd.length() == 0 ) {
			model.addAttribute("message" , "{\"success\":false, \"message\":\"mật khẩu không để trống\"}");
		}
		else {
			model.addAttribute("message" , "{\"success\":false, \"message\":\"mật khẩu xác thực không đúng\"}");
		}
		
		
		return "admin/profile";
	}
	
	@RequestMapping(value = "/admin/profile-email", method = RequestMethod.POST)
	public String ChangeEmail(HttpServletRequest request,ModelMap model, HttpSession session) throws IOException {
		String email = request.getParameter("email"),
				newemail = request.getParameter("newemail"),
				passwd = request.getParameter("password"),
				username = (String) session.getAttribute("user");
		
			Account user = verifyLogin(username, passwd);
			if(user != null)
			{
				if(user.getEmail().equals(email)) {
					user.setEmail(newemail);
				}
				
				int result = update(user);
				if(result == 1) {
					model.addAttribute("message" , "{\"success\":true, \"message\":\"Cập nhật thành công\"}");
				}else {
					model.addAttribute("message" , "{\"success\":false, \"message\":\"Cập nhật thất bại\"}");
				}
			}
			else {
				model.addAttribute("message" , "{\"success\":false, \"message\":\"Sai mật khẩu\"}");
			}
	
		
		
		return "admin/profile";
	}
		
	public int update(Account item) {
		Session session = factory.openSession();
		Transaction transaction = session.beginTransaction();
		try {
			session.update(item);						
			transaction.commit();
		} catch (Exception e) {
			transaction.rollback();
			return 0;
		}
		finally {
			session.close();
		}	
		return 1;
	}

	public int insert(Token item) {
		Session session = factory.openSession();
		Transaction transaction = session.beginTransaction();
		try {
			session.save(item);						
			transaction.commit();
		} catch (Exception e) {
			transaction.rollback();
			return 0;
		}
		finally {
			session.close();
		}	
		return 1;
	}

	public int updateToken(Token item) {
		Session session = factory.openSession();
		Transaction transaction = session.beginTransaction();
		try {
			session.update(item);						
			transaction.commit();
		} catch (Exception e) {
			transaction.rollback();
			return 0;
		}
		finally {
			session.close();
		}	
		return 1;
	}
	
}
