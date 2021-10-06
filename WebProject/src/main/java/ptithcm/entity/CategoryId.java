package ptithcm.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class CategoryId implements Serializable {
	@Column(name = "IdTheLoai")
	private int idCategory;
	@Column(name = "IdTruyen")
	private int idStory;
	
	public CategoryId() {
		
	}
	
	public CategoryId(int idCategory, int idStory) {
		this.idCategory = idCategory;
		this.idStory = idStory;
	}

	public int getIdCategory() {
		return idCategory;
	}



	public void setIdCategory(int idCategory) {
		this.idCategory = idCategory;
	}



	public int getIdStory() {
		return idStory;
	}



	public void setIdStory(int idStory) {
		this.idStory = idStory;
	}



	@Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        CategoryId that = (CategoryId) o;

        if (!(idCategory == that.idCategory)) return false;
        return idStory == that.idStory;
    }
}
