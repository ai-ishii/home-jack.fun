package bean;

import java.sql.Date;
import java.sql.Timestamp;

public class User {

	
	private int userId;					//ユーザー情報ID
	private String accountId;			//アカウントID
	private String name;				//氏名
	private String nameKana;			//氏名（カナ）
	private Date birthday;				//生年月日
	private String address;				//住所
	private String post;				//郵便番号
	private String phone;				//電話番号
	private String nearestStation;		//最寄り駅
	private String transportation;		//交通手段
	private String sex;					//性別
	private String employeeNumber;		//社員番号
	private int departmentId;			//部
	private int groupId;				//グループ
	private Timestamp joiningDate;		//入社年月
	private int workHistory;			//勤務年数
	private int marriageFlag;			//既婚・未婚フラグ	
	private int children;				//子供人数
	private String qualification;		//資格
	private int displayFlag;			//表示・非表示フラグ
	private int restFlag;				//休職フラグ
	private Timestamp registDate;		//登録日時
	private Timestamp updateDate;		//更新日時
	
	
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getAccountId() {
		return accountId;
	}
	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNameKana() {
		return nameKana;
	}
	public void setNameKana(String nameKana) {
		this.nameKana = nameKana;
	}
	public Date getBirthday() {
		return birthday;
	}
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPost() {
		return post;
	}
	public void setPost(String post) {
		this.post = post;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getNearestStation() {
		return nearestStation;
	}
	public void setNearestStation(String nearestStation) {
		this.nearestStation = nearestStation;
	}
	public String getTransportation() {
		return transportation;
	}
	public void setTransportation(String transportation) {
		this.transportation = transportation;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getEmployeeNumber() {
		return employeeNumber;
	}
	public void setEmployeeNumber(String employeeNumber) {
		this.employeeNumber = employeeNumber;
	}
	public int getDepartmentId() {
		return departmentId;
	}
	public void setDepartmentId(int departmentId) {
		this.departmentId = departmentId;
	}
	public int getGroupId() {
		return groupId;
	}
	public void setGroupId(int groupId) {
		this.groupId= groupId;
	}
	public Timestamp getJoiningDate() {
		return joiningDate;
	}
	public void setJoiningDate(Timestamp joiningDate) {
		this.joiningDate = joiningDate;
	}
	public int getWorkHistory() {
		return workHistory;
	}
	public void setWorkHistory(int workHistory) {
		this.workHistory = workHistory;
	}
	public int getMarriageFlag() {
		return marriageFlag;
	}
	public void setMarriageFlag(int marriageFlag) {
		this.marriageFlag = marriageFlag;
	}
	public int getChildren() {
		return children;
	}
	public void setChildren(int children) {
		this.children = children;
	}
	public String getQualification() {
		return qualification;
	}
	public void setQualification(String qualification) {
		this.qualification = qualification;
	}
	public int getDisplayFlag() {
		return displayFlag;
	}
	public void setDisplayFlag(int displayFlag) {
		this.displayFlag = displayFlag;
	}
	public int getRestFlag() {
		return restFlag;
	}
	public void setRestFlag(int restFlag) {
		this.restFlag = restFlag;
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
	
	

		
}


