package ptithcm.controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Query;
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
import org.springframework.web.bind.annotation.RequestParam;

import ptithcm.attribute.StoryAttribute;
import ptithcm.entity.Author;
import ptithcm.entity.Category;
import ptithcm.entity.CategoryId;

import ptithcm.entity.Story;
import ptithcm.entity.dCategory;


@Controller
@Transactional
@RequestMapping("/admin/")
public class StoryController {
	@Autowired 	SessionFactory factory;
	
	private static final List<String> contentTypes = Arrays.asList("image/png", "image/jpeg", "image/gif");

	@RequestMapping(value = "create", method = RequestMethod.GET)
	public String index(ModelMap model, @ModelAttribute("story")StoryAttribute story) {
		model.addAttribute("Authors", getAuthors());
		model.addAttribute("Categories",getCategory());
		return "admin/create";
	}
	
	
	@RequestMapping(value = "create", method = RequestMethod.POST)
	public String createStory(ModelMap model ,@ModelAttribute("story")StoryAttribute story, BindingResult errors ) {	
			if(errors.hasErrors()) {
				model.addAttribute("message","LỖi");
			}else {
				if(story.getImage().isEmpty()==false && contentTypes.contains(story.getImage().getContentType())) {
					try {
						story.getStory().setImg(story.getImage().getBytes());
					} catch (IOException e) {
						story.getStory().setImg(null);
						e.printStackTrace();
					}
				}
		
				String str = "";
				str += addStory(story.getStory())==1?"" : "False Story;";
				int idStory = story.getStory().getId();
				for (String it : story.getCategories()) {
					try {
						int idCategory  = Integer.parseInt(it);
						if(idCategory !=0 ) {
							dCategory temp = new dCategory();
							temp.setId(new CategoryId(idCategory,idStory));
							str += addDetailCategory(temp)==1?"True dcategory":"False dcategory" + idCategory+";";
						}
					} catch (Exception e) {
					}
				}
				model.addAttribute("message",str);
			}
	
		return "redirect:/admin/data.html";
	}
		
	public int addStory(Story item) {
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
	
	public int addDetailCategory(dCategory item) {
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
		
	@RequestMapping(value = "edit-story", method = RequestMethod.GET)
	public String index2(ModelMap model, @RequestParam(value = "id")Integer id) {
		
		try {
			StoryAttribute story = new StoryAttribute();
			Story item = getStory(id);
			story.setStory(item);		

			model.addAttribute("story",story);
			model.addAttribute("Authors", getAuthors());
			model.addAttribute("Categories", getCategory());
			return "admin/edit";
		} catch (Exception e) {
			return "redirect:/admin/data.html";
		}
	}
	
	
	@RequestMapping(value = "edit-story",method = RequestMethod.POST)
	public String editStory(ModelMap model ,@ModelAttribute("story")StoryAttribute story ) {
		
		if(story.getImage().isEmpty() == false && contentTypes.contains(story.getImage().getContentType())) {
	
			try {
				story.getStory().setImg(story.getImage().getBytes());
			} catch (IOException e) {
				story.getStory().setImg(null);
				e.printStackTrace();
			}
		}
		else  {
			story.getStory().setImg(getStory(story.getStory().getId()).getImg());
		}
		
		String str = "";
		str += updateStory(story.getStory())==1?"True Story " : "False Story ";
		int idStory = story.getStory().getId();
	
		for (dCategory it : getdCategories(idStory)) {
			delDetailCategory(it);
		}
		
		for (String it : story.getCategories()) {
			try {
				int idCategory  = Integer.parseInt(it);
				if(idCategory !=0 ) {
						dCategory temp = new dCategory();
						temp.setId(new CategoryId(idCategory,idStory));
						str += addDetailCategory(temp)==1?"":"False dcategory " + idCategory+"";
				}
			} catch (Exception e) {
			}
		}
		
		if(str.contains("False")) {
			model.addAttribute("message", String.format("false, message:%s", str));
		}
		else {
			model.addAttribute("message","success:true");
		}
		
		return "redirect:/admin/data.html";
	}
			
	public Story getStory(int id) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Story where id = :id";
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		return (Story) query.list().get(0);
	}
	
	public List<dCategory> getdCategories(int id){
		Session session = factory.getCurrentSession();
		String hql = "FROM dCategory where id.idStory = :id";
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		return query.list();
	}
	
	public int updateStory(Story item) {
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
	
	public int delDetailCategory(dCategory item) {
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
	
	@RequestMapping(value = "delete-story", method = RequestMethod.POST)
	public String del(ModelMap model, @RequestParam(value = "id")int id) {
		
		System.out.println(id);
		try {
			Story story = getStory(id);
			if(story != null) {
			
				for (dCategory it : story.getStoryId()) {
					delDetailCategory(it);
				}
				
				int result = deleteStory(story);
				if(result == 1) {
					model.addAttribute("message","Delete success");
				}
				else {
					model.addAttribute("message","Delete fail");
				}
			}
			
		} catch (Exception e) {
			model.addAttribute("message","Delete fail");
		}
		return "redirect:/admin/data.html";
	}
	
	public int deleteStory(Story item) {
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
	

}
