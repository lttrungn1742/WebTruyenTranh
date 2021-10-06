package ptithcm.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Base64;
import java.util.Date;

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
public class AddChap {
	@Autowired 	SessionFactory factory;
	
	@RequestMapping(value = "newChap", method =  RequestMethod.GET)
	public String newChaper(ModelMap model, @ModelAttribute("chap")ContentChapter chaper, @RequestParam(value = "id")Integer id ){
		model.addAttribute("length", ChaperLength(id));
		model.addAttribute("idStory",id);

		return "admin/chapter";
	}
	
	@RequestMapping(value = "newChap", method =  RequestMethod.POST)
	public String add(ModelMap model, @ModelAttribute("chap")ContentChapter chapter ){
		String str = "";
		try {
			String datestr = DateTimeFormatter.ofPattern("yyyy/MM/dd").format(LocalDateTime.now());
			Date date=  new SimpleDateFormat("yyyy/MM/dd").parse(datestr);
			chapter.getChap().setDate(date);
		} catch (ParseException e1) {
			chapter.getChap().setDate(null);
		}
		
		str += addChap(chapter.getChap())==1?"True chap":"False chap";
		for (int i = 0; i < chapter.getImages().size(); i++) {
			if(chapter.getImages().get(i).length() != 0) {
				try {
					Page temp = new Page();
					
					temp.setImage(Base64.getDecoder().decode(chapter.getImages().get(i)));
					temp.setIdChapter(chapter.getChap().getId());
		
					str += addContent(temp)==1?"True content" :"False content";
				} catch (Exception e) {
					// TODO: handle exception
				}
			}
		}
		model.addAttribute("message",str);
		return "redirect:/admin/data.html";
	}
	
	public int ChaperLength(int idStory) {
		Query query = factory.getCurrentSession().createQuery("FROM Chap where idStory = :id");
		query.setParameter("id", idStory);
		return query.list().size();
	}
	
	public Story getStory(int id) {
		Session session = factory.getCurrentSession();
		String hql = "FROM Story where id = :id";
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		return (Story) query.list().get(0);
	}
	
	public int addChap(Chap item) {
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

	public int addContent(Page item) {
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
}
