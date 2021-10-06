package ptithcm.entity;

import java.util.Base64;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "NoiDungTruyen")
public class Page {
	@GeneratedValue
	@Id
	@Column(name = "Id")
	private int id;
	
	@Column(name = "Hinh")
	private byte[] image;
	
	@Column(name = "IdChuong")
	private int IdChapter;

	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getImg() {
		return image==null? "": Base64.getEncoder().encodeToString(image);
	}

	public byte[] getImage() {
		return image;
	}

	public void setImage(byte[] image) {
		this.image = image;
	}

	public int getIdChapter() {
		return IdChapter;
	}

	public void setIdChapter(int idChaper) {
		IdChapter = idChaper;
	}
	
	@ManyToOne
	@JoinColumn(name = "IdChuong", updatable = false, insertable = false)
	private Chap listChapter;
}
