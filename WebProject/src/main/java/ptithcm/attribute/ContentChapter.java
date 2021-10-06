package ptithcm.attribute;

import java.util.ArrayList;
import java.util.List;

import ptithcm.entity.Chap;

public class ContentChapter {
	
	private Chap chap;
	private	List<String> images;
	
	public ContentChapter() {
		images = new ArrayList<String>();
		chap = new Chap();
	}
	
	public ContentChapter(Chap chap, List<String> images) {
		this.chap = chap;
		this.images = images;
	}
	

	public Chap getChap() {
		return chap;
	}

	public void setChap(Chap chap) {
		this.chap = chap;
	}

	public List<String> getImages() {
		return images;
	}
	
	public void setImages(List<String> images) {
		this.images = images;
	}
	
	
}
