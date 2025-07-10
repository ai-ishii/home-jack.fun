package bean;

import java.sql.Timestamp;

public class Work {

	private int workId;					//在宅勤務状況管理
	private int userId;					//ユーザーID
	private String situation;			//勤務状況
	private String jobLocation;			//勤務先
	private String lowRoot;				//最安値ルート
	private int price;					//料金
	private String nearStation;			//現場最寄り駅
	private Timestamp registDate;		//登録日時
	private Timestamp updateDate;		//更新日時
	private String routeName;			//路線名
	
	
	public int getWorkId() {
		return workId;
	}
	public void setWorkId(int workId) {
		this.workId = workId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getSituation() {
		return situation;
	}
	public void setSituation(String situation) {
		this.situation = situation;
	}
	public String getJobLocation() {
		return jobLocation;
	}
	public void setJobLocation(String jobLocation) {
		this.jobLocation = jobLocation;
	}
	public String getLowRoot() {
		return lowRoot;
	}
	public void setLowRoot(String lowRoot) {
		this.lowRoot = lowRoot;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getNearStation() {
		return nearStation;
	}
	public void setNearStation(String nearStation) {
		this.nearStation = nearStation;
	}
	public Timestamp getRegistDate() {
		return registDate;
	}
	public void setRegistDate(Timestamp registDate) {
		this.registDate = registDate;
	}
	public Timestamp getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Timestamp updateDate) {
		this.updateDate = updateDate;
	}
	public String getRouteName() {
		return routeName;
	}
	public void setRouteName(String routeName) {
		this.routeName = routeName;
	}
	
	
}
