package bean;

import java.security.Timestamp;

public class Work {

	private int work_id;				//在宅勤務状況管理
	private int user_id;				//ユーザーID
	private String situation;			//勤務状況
	private String job_location;		//勤務先
	private String low_root;			//最安値ルート
	private int price;					//料金
	private String near_station;		//現場最寄り駅
	private Timestamp regist_date;		//登録日時
	private Timestamp update_date;		//更新日時
	private String route_name;			//路線名
	
	//work_idのゲッターメソッド
	public int getWork_id() {
		return work_id;
	}
	
	//work_idのセッターメソッド
	public void setWork_id(int work_id) {
		this.work_id = work_id;
	}

	//user_idのゲッターメソッド
	public int getUser_id() {
		return user_id;
	}

	//user_idのセッターメソッド
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	//situationのゲッターメソッド
	public String getSituation() {
		return situation;
	}

	//situationのセッターメソッド
	public void setSituation(String situation) {
		this.situation = situation;
	}
	
	//job_locationのゲッターメソッド
	public String getJob_location() {
		return job_location;
	}

	//job_locationのセッターメソッド
	public void setJob_location(String job_location) {
		this.job_location = job_location;
	}

	//low_rootのゲッターメソッド
	public String getLow_root() {
		return low_root;
	}

	//low_rootのセッターメソッド
	public void setLow_root(String low_root) {
		this.low_root = low_root;
	}

	//priceのゲッターメソッド
	public int getPrice() {
		return price;
	}

	//priceのセッターメソッド
	public void setPrice(int price) {
		this.price = price;
	}

	public String getNear_station() {
		return near_station;
	}

	//near_stationのゲッターメソッド
	public void setNear_station(String near_station) {
		this.near_station = near_station;
	}

	//near_stationのセッターメソッド
	public Timestamp getRegist_date() {
		return regist_date;
	}

	//regist_dateのゲッターメソッド
	public void setRegist_date(Timestamp regist_date) {
		this.regist_date = regist_date;
	}

	//regist_dateのセッターメソッド
	public Timestamp getUpdate_date() {
		return update_date;
	}

	//update_dateのセッターメソッド
	public void setUpdate_date(Timestamp update_date) {
		this.update_date = update_date;
	}

	//route_nameのゲッターメソッド
	public String getRoute_name() {
		return route_name;
	}

	//route_nameのセッターメソッド
	public void setRoute_name(String route_name) {
		this.route_name = route_name;
	}
}
