package ptithcm.entity;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "Ct_TheLoai")
public class dCategory {	
	@EmbeddedId
	private CategoryId id;
	
	public CategoryId getId() {
		return id;
	}

	public void setId(CategoryId id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "IdTheLoai", updatable = false, insertable = false)
	private Category categories;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "IdTruyen", updatable = false, insertable = false)
	private Story stories;
	
	public String getNameCategory() {
		return categories.getName();
	}
	
}
