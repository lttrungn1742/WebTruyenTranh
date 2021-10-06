package ptithcm.controller;


import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import ptithcm.entity.Category;
import ptithcm.entity.Chap;
import ptithcm.entity.Page;
import ptithcm.entity.Story;
import ptithcm.entity.dCategory;

@Controller
@Transactional
public class Index {
	@Autowired 	SessionFactory factory;
	
	@RequestMapping(value = "index", method = RequestMethod.GET)
	public String index(ModelMap model, HttpSession session) {
		String login = "<a href=\"login.html\">Đăng Nhập</a>",
				logout = "<div class=\"logout-user\" >\r\n"
						+ "                    <a href=\"logout.html\">Đăng Xuất</a>\r\n"
						+ "                </div>";
		if(session.getAttribute("user") != null) {
			model.addAttribute("sign",logout);
		}else {
			model.addAttribute("sign", login);
		}
		
		List<Story> list = getStory();
		
		List<Story> listSilde = new ArrayList<Story>();
		if(list.size() > 5 ) {
			int count = 0;
			for (int i = list.size() - 1;; i--) {
			
				listSilde.add(list.get(i));
				count++;
				if(count == 5) break;
			}
		}
		else {
			for (int i = list.size() - 1; i >= 0; i--) {
				
				listSilde.add(list.get(i));
			}
		}
		model.addAttribute("listSilde",listSilde);
		
		
		List<Story> listUpdate = new ArrayList<Story>();
		if(list.size() > 12 ) {
			int count = 0;
			for (int i = list.size() - 1;; i--) {
			
				listUpdate.add(list.get(i));
				count++;
				if(count == 12) break;
			}
		}
		else {
			for (int i = list.size() - 1; i >= 0; i--) {
				
				listUpdate.add(list.get(i));
			}
			
		}
		model.addAttribute("listUpdate",listUpdate);
		
		List<Story> listHot = new ArrayList<Story>();
		
		
		if(list.size() > 2 ) {
			int count = 0;
			for (int i = list.size() - 1;; i--) {
			
				
					listHot.add(list.get(i));
				
				count++;
				if(count == 2) break;
				
			}
		}
		else {
			for (int i = list.size() - 1; i >= 0; i--) {
				
				listHot.add(list.get(i));
			}
			
		}
		model.addAttribute("listHot",listHot);
	
		List<Story> listall = new ArrayList<Story>();
		
		
		if(list.size() > 6 ) {
			int count = 0;
			for (int i = 0;; i++) {
				listall.add(list.get(i));
				count++;
				if(count == 6) break;
			}
		}
		
		model.addAttribute("listHot",listHot);
		
		model.addAttribute("listall",listall);
		
		return "index";
	}
	
	@RequestMapping(value = "index/{idStory}", method = RequestMethod.GET)
	public String story(ModelMap model, @PathVariable Integer idStory, HttpSession session) {
		String login = "<a href=\"login.html\">Đăng Nhập</a>",
				logout = "<div class=\"logout-user\" >\r\n"
						+ "                    <a href=\"logout.html\">Đăng Xuất</a>\r\n"
						+ "                </div>";
		if(session.getAttribute("user") != null) {
			model.addAttribute("sign",logout);
		}else {
			model.addAttribute("sign", login);
		}
		model.addAttribute("story",getStory(idStory));
		return "story";
	}
	
	@RequestMapping(value = "index/watch/{idChaper}", method = RequestMethod.GET)
	public String read(ModelMap model, @PathVariable Integer idChaper) {
		
		Chap chap = getChap(idChaper);
		if(chap != null) {
			Story story = getStory(chap.getIdStory());
			int id1,id2;
			List<Chap> list = story.getChapers();
			for (int i = 0; i < list.size(); i++) {
				if(list.get(i).getId() == idChaper) {
					if(i != 0) {
						System.out.println("front" +list.get(i-1).getId());
						String s = "<a href=\""+list.get(i-1).getId()+".html\">\r\n"
								+ "                        <div class=\"page-icons-right\"><span class=\"page-text\">Trang trước</span></div>\r\n"
								+ "                    </a>";
						model.addAttribute("front", s);
					}
					else {
						model.addAttribute("front", "");
					}
					System.out.println("at"+ list.get(i).getId());
					
					
					if(i != list.size()-1) {
						System.out.println("back"+ list.get(i+1).getId());
						String s = "<a href=\""+list.get(i+1).getId()+".html\">\r\n"
								+ "                        <div class=\"page-icons-right\"><span class=\"page-text\">Trang sau</span>\r\n"
								+ "                        </div>\r\n"
								+ "                    </a>";
						model.addAttribute("back",s);
					}
					else {
						model.addAttribute("back", "");
					}
					break;
				}
			}
			
			
			model.addAttribute("list",getPages(idChaper));
			return "read";
		}
		
		return "redirect:/index.html";
	}
	
	@RequestMapping(value = "all", method = RequestMethod.GET)
	public String all(ModelMap modal) {
		
		modal.addAttribute("list", getStory());
		modal.addAttribute("category", getCategory());
		return "all";
	}
	
	@RequestMapping(value = "all/{id}.html", method = RequestMethod.GET)
	public String all(ModelMap modal, @PathVariable Integer id) {
		
		
		List<Story> list = new ArrayList<Story>();
		for (Story story : getStory()) {
			for (dCategory it : story.getStoryId()) {
				if(it.getId().getIdCategory() == id) {
					list.add(story);
					break;
				}
			}
		}
		modal.addAttribute("list", list);
		modal.addAttribute("category", getCategory());
		modal.addAttribute("id",id);
		return "allForCategory";
	}
	
	public Story getStory(int id) {
		Query query = factory.getCurrentSession().createQuery("FROM Story where id = :id");
		query.setParameter("id", id);
		return (Story) query.list().get(0);
	}
	
	public Chap getChap(int id) {
		Query query = factory.getCurrentSession().createQuery("FROM Chap where id = :id");
		query.setParameter("id", id);
		return (Chap) query.list().get(0);
	}
	
	
	public List<Story> getStory(){
		return factory.getCurrentSession().createQuery("FROM Story").list();
	}
	
	public List<Category> getCategory(){
		return factory.getCurrentSession().createQuery("FROM Category").list();
	}
		
	public List<Page> getPages(Integer id){
		Query query = factory.getCurrentSession().createQuery("FROM Page where IdChapter = :id");
		query.setParameter("id", id);
		return  query.list();
	}
}
