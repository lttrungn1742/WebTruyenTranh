package ptithcm.entity;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotBlank;

@Entity
@Table(name = "Chuong")
public class Chap {
	@GeneratedValue
	@Id
	@Column(name = "IdChuong")
	private int id;
	
	@Column(name = "IdTruyen")
	private int idStory;
	
	@Column(name = "Ngay")
	private Date date;
	
	@Column(name = "Stt")
	private int serial;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getIdStory() {
		return idStory;
	}

	public void setIdStory(int idStory) {
		this.idStory = idStory;
	}

	public Date getDate() {
		return date;
	}
	
	public String getDateString() {
		return new SimpleDateFormat("dd/MM/yyyy").format(date);
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public int getSerial() {
		return serial;
	}

	public void setSerial(int serial) {
		this.serial = serial;
	}
	
	@ManyToOne
	@JoinColumn(name = "IdTruyen", updatable = false, insertable =  false)
	private Story listStory;
	
	@OneToMany(mappedBy = "listChapter" )
	private List<Page> Pages;

	public List<Page> getPages() {
		return Pages;
	}

	public void setPages(List<Page> pages) {
		Pages = pages;
	}

	public List<String> ListPages() {
		List<String> list = new ArrayList<String>();
		for (Page it : Pages) {
			list.add(it.getImg());
		}
		return list;
		
	}

	
	
	
}
