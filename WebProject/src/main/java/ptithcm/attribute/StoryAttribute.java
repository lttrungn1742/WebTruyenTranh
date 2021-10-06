package ptithcm.attribute;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import ptithcm.entity.Story;

public class StoryAttribute {
	private Story story;
	private List<String> categories;
	private MultipartFile image;
	
	public MultipartFile getImage() {
		return image;
	}
	
	public void setImage(MultipartFile image) {
		this.image = image;
	}
	
	public Story getStory() {
		return story;
	}
	
	public void setStory(Story story) {
		this.story = story;
	}
	
	public List<String> getCategories() {
		return categories;
	}
	
	public void setCategories(List<String> categories) {
		this.categories = categories;
	}
	
}
