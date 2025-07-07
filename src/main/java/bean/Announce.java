package bean;

import java.security.Timestamp;

public class Annnounce {

	private int announce_id; //お知らせID
	private int user_id; //ユーザー情報ID
	private Timestamp regist_date; //登録日時
	private Timestamp update_date; //更新日時
	private String title; //タイトル
	private String text; //本文
	private String image; //画像
	private String comment; //コメント
	private int iine_flag; //いいねフラグ
	private int announce_flag; //お知らせ表示フラグ
	private int favorite_flag; //お気に入りフラグ
	private int category; //カテゴリ
	private String tag; //タグ
	private String file; //ファイル

	public int getAnnounce_id() {
		return announce_id;
	}

	public void setAnnounce_id(int announce_id) {
		this.announce_id = announce_id;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public Timestamp getRegist_date() {
		return regist_date;
	}

	public void setRegist_date(Timestamp regist_date) {
		this.regist_date = regist_date;
	}

	public Timestamp getUpdate_date() {
		return update_date;
	}

	public void setUpdate_date(Timestamp update_date) {
		this.update_date = update_date;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public int getIine_flag() {
		return iine_flag;
	}

	public void setIine_flag(int iine_flag) {
		this.iine_flag = iine_flag;
	}

	public int getAnnounce_flag() {
		return announce_flag;
	}

	public void setAnnounce_flag(int announce_flag) {
		this.announce_flag = announce_flag;
	}

	public int getFavorite_flag() {
		return favorite_flag;
	}

	public void setFavorite_flag(int favorite_flag) {
		this.favorite_flag = favorite_flag;
	}

	public int getCategory() {
		return category;
	}

	public void setCategory(int category) {
		this.category = category;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	public String getFile() {
		return file;
	}

	public void setFile(String file) {
		this.file = file;
	}
}
