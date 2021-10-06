package ptithcm.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import ptithcm.attribute.ContentChapter;
import ptithcm.entity.Chap;
import ptithcm.entity.Page;
import ptithcm.entity.Story;

@Controller
@Transactional
@RequestMapping("/admin/")
public class ViewChap {
	@Autowired 	SessionFactory factory;
	
	@RequestMapping(value = "view", method = RequestMethod.GET)
	public String view(ModelMap model, @RequestParam(value = "id")Integer id, @ModelAttribute("chap")Chap chap) {
		
		try {
			model.addAttribute("story",getStory(id));
			
			return "admin/view";
		} catch (Exception e) {
			return "redirect:/admin/data.html";
		}
		
	}
	
	
	@RequestMapping(value = "delChap", method = RequestMethod.POST)
	public void del(ModelMap model, @ModelAttribute("chap")Chap chap, HttpServletRequest request, HttpServletResponse response) throws IOException {
			try {
				int id = getChap(chap.getId()).getIdStory();
					delChap(chap);
					response.sendRedirect(request.getContextPath()  +"/admin/view.html?id="+id);
			} catch (Exception e) {
				response.sendRedirect(request.getContextPath() + "/admin/data.html");
			}
			
	}
	
	@RequestMapping(value = "editChaper", method = RequestMethod.GET)
	public String edit(ModelMap model, @RequestParam(value = "id")Integer id) {	
		try {
			Chap temp = getChap(id);
			List<String> str = new ArrayList<String>();
					
	 		for (Page p : temp.getPages()) {
				str.add(p.getImg());
			}
	
	 		ContentChapter attribute = new ContentChapter(temp,str);
			model.addAttribute("chapter",attribute);
			model.addAttribute("length",str.size());
			return "admin/EditChaper";
		} catch (Exception e) {
			return "redirect:/admin/data.html";
		}
	}
	
	@RequestMapping(value = "editChaper", method = RequestMethod.POST)
	public String editChaper(ModelMap model,  @ModelAttribute("chaper")ContentChapter chaper) {	
			List<Page> list = getPages(chaper.getChap().getId());
			
			int length = list.size(), length2 = chaper.getImages().size();
			
			String str = "";
			
			if(length < length2) {
				for (int i = 0; i < length; i++) {
					if(chaper.getImages().get(i).length() == 0) {
			
						str +=  delPage(list.get(i))==1 ? "true del" : "False del";
					}
					else {
						list.get(i).setImage(Base64.getDecoder().decode(chaper.getImages().get(i)));
						str +=  updatePage(list.get(i))==1 ? "true update" : "False update";
					}
					
				}
				for(int i=length;i<length2;i++) {
					
					String bytes = chaper.getImages().get(i);
					if( bytes.length() != 0 ) {
						try {
							Page temp = new Page();
							temp.setImage(Base64.getDecoder().decode(bytes));
							temp.setIdChapter(chaper.getChap().getId());
							str += addPage(temp)==1?"True content save" :"False content save";
						} catch (Exception e) {
							// TODO: handle exception
						}
					}
				}
			}
//			else {
//				for (int i = 0; i < length2; i++) {
//					list.get(i).setImage(Base64.getDecoder().decode(chaper.getImages().get(i)));
//					updatePage(list.get(i));
//				}
//				for (int i = length2; i < length; i++) {
//					delPage(list.get(i));
//				}
//			}
			
			model.addAttribute("message",str);
			
			return "redirect:/admin/data.html";
		
	}
	
	
	public int delChap(Chap item) {
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
	
	public int delPage(Page item) {
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

	public int addPage(Page item) {
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

	public int updatePage(Page item) {
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
	
	public List<Page> getPages(int id) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Page where IdChapter = :nhi";
		Query query = session.createQuery(hql);
		query.setParameter("nhi", id);
		return query.list();
	}

	public Story getStory(int id) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Story where id = :nhi";
		Query query = session.createQuery(hql);
		query.setParameter("nhi", id);
		return (Story) query.list().get(0);
	}
	
	public Chap getChap(int id) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Chap where id = :nhi";
		Query query = session.createQuery(hql);
		query.setParameter("nhi", id);
		return (Chap) query.list().get(0);
	}
}
