package bean;

public class AnnounceCategory {
	
	private int announceCategoryId;	//お知らせカテゴリID
	private String categoryCode;		//カテゴリを一意に定めるナンバー
	private String category;		//カテゴリ
	
	public int getAnnounceCategoryId() {
		return announceCategoryId;
	}
	public void setAnnounceCategoryId(int announceCategoryId) {
		this.announceCategoryId = announceCategoryId;
	}
	public String getCategoryCode() {
		return categoryCode;
	}
	public void setCategoryCode(String categoryCode) {
		this.categoryCode = categoryCode;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}

}
