package bean;

import java.security.Timestamp;
import java.sql.Date;

public class User {

	
	private int user_id;				//ユーザー情報ID
	private int acount_id;				//アカウントID
	private String name;				//氏名
	private String name_kana;			//氏名（カナ）
	private Date birthday;				//生年月日
	private String address;				//住所
	private String post;				//郵便番号
	private String phone;				//電話番号
	private String nearest_station;		//最寄り駅
	private String transportation;		//交通手段
	private String sex;					//性別
	private String employee_number;		//社員番号
	private String department;			//部
	private String team;				//グループ
	private Timestamp joining_date;		//入社年月
	private int work_history;			//勤務年数
	private int marriage_flag;			//既婚・未婚フラグ	
	private int children;				//子供人数
	private String qualification;		//資格
	private int display_flag;			//表示・非表示フラグ
	private int rest_flag;				//休職フラグ
	private Timestamp regist_date;		//登録日時
	private Timestamp update_date;		//更新日時
	
	

		public int getUser_id() {
			return user_id;
		}
		

		public void setUser_id(int user_id) {
			this.user_id = user_id;
		}


		public int getAcount_id() {
			return acount_id;
		}


		public void setAcount_id(int acount_id) {
			this.acount_id = acount_id;
		}


		public String getName() {
			return name;
		}


		public void setName(String name) {
			this.name = name;
		}


		public String getName_kana() {
			return name_kana;
		}


		public void setName_kana(String name_kana) {
			this.name_kana = name_kana;
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


		public String getNearest_station() {
			return nearest_station;
		}


		public void setNearest_station(String nearest_station) {
			this.nearest_station = nearest_station;
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


		public String getEmployee_number() {
			return employee_number;
		}


		public void setEmployee_number(String employee_number) {
			this.employee_number = employee_number;
		}


		public String getDepartment() {
			return department;
		}


		public void setDepartment(String department) {
			this.department = department;
		}


		public String getTeam() {
			return team;
		}


		public void setTeam(String team) {
			this.team = team;
		}


		public Timestamp getJoining_date() {
			return joining_date;
		}


		public void setJoining_date(Timestamp joining_date) {
			this.joining_date = joining_date;
		}


		public int getWork_history() {
			return work_history;
		}


		public void setWork_history(int work_history) {
			this.work_history = work_history;
		}


		public int getMarriage_flag() {
			return marriage_flag;
		}


		public void setMarriage_flag(int marriage_flag) {
			this.marriage_flag = marriage_flag;
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


		public int getDisplay_flag() {
			return display_flag;
		}


		public void setDisplay_flag(int display_flag) {
			this.display_flag = display_flag;
		}


		public int getRest_flag() {
			return rest_flag;
		}


		public void setRest_flag(int rest_flag) {
			this.rest_flag = rest_flag;
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

		
}


