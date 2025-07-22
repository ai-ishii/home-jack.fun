package bean;

public class WorkRequest {
	
	private int workRequestId;       	//勤務状況申請ID
	private int requestId;            	//ユーザーID
	private String situation;        	//勤務状況
	private String jobLocation;      	//勤務先
	private String lowRoot;          	//最安値ルート
	private int price;              	//料金
	private String nearStation;     	//現場最寄り駅
	private String routeName;       	//路線名
	
	
	public int getWorkRequestId() {
		return workRequestId;
	}
	public void setWorkRequestId(int workRequestId) {
		this.workRequestId = workRequestId;
	}
	public int getRequestId() {
		return requestId;
	}
	public void setRequestId(int requestId) {
		this.requestId = requestId;
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
	public String getRouteName() {
		return routeName;
	}
	public void setRouteName(String routeName) {
		this.routeName = routeName;
	}
}
