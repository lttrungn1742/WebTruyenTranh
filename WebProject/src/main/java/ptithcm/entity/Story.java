package ptithcm.entity;

import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.SafeHtml;

import java.util.ArrayList;
import java.util.Base64;
import java.util.Collection;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

@Entity
@Table(name = "Truyen")
public class Story {
	@Id
	@GeneratedValue
	@Column(name = "ID")
	private int id;
	
	@NotBlank
	@NotNull
	@SafeHtml
	@Length(max = 200)
	@Column(name = "TenTruyen")
	private String name;
	
	@Column(name = "HinhAnh")
	private byte[] img;
	@Column(name = "TrangThai")
	private boolean status;
	@Column(name = "idTacGia")
	private int idAuthor;
	
	@NotBlank
	@NotNull
	@SafeHtml
	@Column(name = "NoiDung")
	private String description;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	
	public String getName(int len) {
		return name.length() > len ? (name.substring(0,len) + "...") : name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public byte[] getImg() {
		return img;
	}
	public void setImg(byte[] img) {
		this.img = img;
	}
	
	public String getImage() {
		return img==null? "": Base64.getEncoder().encodeToString(img);
	}
	
	public int getIdAuthor() {
		return idAuthor;
	}
	public void setIdAuthor(int idAuthor) {
		this.idAuthor = idAuthor;
	}
	
	public String getDescription() {
		return description;
	}
	
	public String getDescription256() {
		if(description.length() > 256) {
			return description.substring(0,256) + "...";
		}
		return description;
	}
	
	public void setDescription(String description) {
		this.description = description;
	}

	@OneToMany(mappedBy = "stories", fetch = FetchType.EAGER )
	private Collection<dCategory> storyId;
	
	public Collection<dCategory> getStoryId() {
		return storyId;
	}
	public void setStoryId(Collection<dCategory> storyId) {
		this.storyId = storyId;
	}
	
	public String listCategory(String x) {
		List<String> s = new ArrayList<String>();
		
		for (dCategory it : storyId) {
			 s.add(it.getNameCategory());
		}
		return String.join(x, s);
	}
	
	public String ListIdCategory() {
		String str = "";
		for (dCategory it : storyId) {
			str += it.getId().getIdCategory() + " ";
		}
		
		return str!="" ? str.substring(0, str.length()-1) : "";
	}
	
	public boolean isStatus() {
		return status;
	}
	
	public void setStatus(boolean status) {
		this.status = status;
	}
	
	public String getStatus() {
		return status?"Hoàn Thành" : "Đang Cập Nhật";
	}
	
	@ManyToOne
	@JoinColumn(name = "idTacGia", updatable = false, insertable = false)
	private Author author;
	
	public String getNameAuthor() {
		return author.getName();
	}
	
	@OneToMany(mappedBy = "listStory", fetch = FetchType.EAGER )
	private List<Chap> Chapers;
	
	public List<Chap> getChapers() {
		return Chapers;
	}
	
	public void setChapers(List<Chap> chapers) {
		Chapers = chapers;
	}
	
	public String getlistChaperstr() {
		String s = "";
		int length = Chapers.size();
		for (int i = 0; i < length; i++) {
			s += Chapers.get(i).getSerial() + ( (i == length - 1) ? "" : " ");
		}
		return s;
	}
	
}
