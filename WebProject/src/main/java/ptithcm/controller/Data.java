package ptithcm.controller;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import ptithcm.entity.Author;
import ptithcm.entity.Category;

import ptithcm.entity.Story;

@Transactional
@Controller
@RequestMapping("/admin/")
public class Data {
	@Autowired
	SessionFactory factory;
	
	@RequestMapping(value = "data", method = RequestMethod.GET)
	public String index(ModelMap model,@ModelAttribute("story")Story story ,
			@ModelAttribute("author")Author author, 
			@ModelAttribute("category")Category category) {
					
		model.addAttribute("Authors",getAuthors()); 
		model.addAttribute("Categories",getCategory());
		
		model.addAttribute("Stories",getStories());
		return "admin/data";
	}
	
	@RequestMapping(value = "data-addAuthor", method = RequestMethod.POST)
	public String addAuthor(ModelMap model, @ModelAttribute("author")Author author, BindingResult errors) {
			
			if(errors.hasErrors()) {
				model.addAttribute("message","Lỗi");
			}else {
				String str = addAuthor(author)==1?"Thêm tác giả thành công":"Thêm tác giả thất bại";
				model.addAttribute("message",str);
			}
			return "redirect:/admin/data.html";
	}
		
	public int addAuthor(Author item) {
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
	
	@RequestMapping(value = "data-delAuthor", method = RequestMethod.POST)
	public String delAuthor(ModelMap model,	@ModelAttribute("author")Author author ) {
		model.addAttribute("message",delAuthor(author)==1?"Delete True":"Delete False");
		return "redirect:/admin/data.html";
	}
		
	public int delAuthor(Author item) {
		Session session = factory.openSession();
		Transaction transaction = session.beginTransaction();
		try {
			session.delete(item);						
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
	
	@RequestMapping(value = "data-editAuthor", method = RequestMethod.POST)
	public String editAuthor(ModelMap model, @ModelAttribute("author")Author author,  BindingResult errors) {
		if(errors.hasErrors()) {
			model.addAttribute("message","Lỗi");
		}else {
			String str = editAuthor(author)==1?"Chỉnh sửa tác giả thành công":"Chỉnh sửa tác giả thất bại";
			model.addAttribute("message", str);
		}
			return "redirect:/admin/data.html";
	}
	
	public int editAuthor(Author item) {
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
	
	@RequestMapping(value = "data-addCategory", method = RequestMethod.POST)
	public String addCategory(ModelMap model, @ModelAttribute("category")Category category, BindingResult errors) {
		if(errors.hasErrors()) {
			model.addAttribute("message","Lỗi");
		}else {
			String str = addCategory(category)==1?"Thêm thể loại thành công":"Thêm thể loại thất bại";

			model.addAttribute("message",str);
		}
			return "redirect:/admin/data.html";
	}
	
	public int addCategory(Category item) {
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
	
	@RequestMapping(value = "data-editCategory", method = RequestMethod.POST)
	public String editCategory(ModelMap model, @ModelAttribute("category")Category category, BindingResult errors) {
		if(errors.hasErrors()) {
			model.addAttribute("message","Lỗi");
		}else {
			String str = editCategory(category)==1?"Chỉnh sửa thể loại thành công":"Chỉnh sửa thể loại thất bại";
			model.addAttribute("message",str);
		}
			
		return "redirect:/admin/data.html";
	}
	
	public int editCategory(Category item) {
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
	
	@RequestMapping(value = "data-delCategory", method = RequestMethod.POST)
	public String delCategory(ModelMap model,	@ModelAttribute("category")Category category) {
		model.addAttribute("message",delCategory(category)==1?"Delete True":"Delete False");
		return "redirect:/admin/data.html";
	}
		
	public int delCategory(Category item) {
		Session session = factory.openSession();
		Transaction transaction = session.beginTransaction();
		try {
			session.delete(item);						
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
	
	List<Author> getAuthors(){
		return factory.getCurrentSession().createQuery("FROM Author").list();
	}
	
	List<Category> getCategory(){
		return factory.getCurrentSession().createQuery("FROM Category").list();
	}
		
	List<Story> getStories(){
		return factory.getCurrentSession().createQuery("FROM Story").list();
	}
	
}
