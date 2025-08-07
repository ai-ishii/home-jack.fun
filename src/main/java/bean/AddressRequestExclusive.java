/*
 * 機能：住所変更申請フォームに表示する内容を格納するためのDTO
 * 
 * 作成者：桑原岳
 * 
 * 最終更新日：2025/08/07
 * 
 * */



package bean;

import java.sql.Date;
import java.sql.Timestamp;

public class AddressRequestExclusive {
	
		private int requestId;          		//申請ID
		private Timestamp applicationDate;     //申請日時
		private String name;          			//申請者名
		private int addressRequestId;      	//住所申請ID
		private String oldAddress;        		//旧住所  
		private String newAddress;  			//新住所
		private String oldPost;					//旧郵便番号
		private String newPost; 				//新郵便番号
		private Date addressChangedDate;       //住所変更日時
		private String employeenumber;        	//社員番号
		private String neareststation; 			//最寄り駅
		
		
		
		
		public int getRequestId() {
			return requestId;
		}
		public void setRequestId(int requestId) {
			this.requestId = requestId;
		}
		public Timestamp getApplicationDate() {
			return applicationDate;
		}
		public void setApplicationDate(Timestamp applicationDate) {
			this.applicationDate = applicationDate;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public int getAddressRequestId() {
			return addressRequestId;
		}
		public void setAddressRequestId(int addressRequestId) {
			this.addressRequestId = addressRequestId;
		}
		public String getOldAddress() {
			return oldAddress;
		}
		public void setOldAddress(String oldAddress) {
			this.oldAddress = oldAddress;
		}
		public String getNewAddress() {
			return newAddress;
		}
		public void setNewAddress(String newAddress) {
			this.newAddress = newAddress;
		}
		public String getOldPost() {
			return oldPost;
		}
		public void setOldPost(String oldPost) {
			this.oldPost = oldPost;
		}
		public String getNewPost() {
			return newPost;
		}
		public void setNewPost(String newPost) {
			this.newPost = newPost;
		}
		public Date getAddressChangedDate() {
			return addressChangedDate;
		}
		public void setAddressChangedDate(Date addressChangedDate) {
			this.addressChangedDate = addressChangedDate;
		}
		public String getEmployeenumber() {
			return employeenumber;
		}
		public void setEmployeenumber(String employeenumber) {
			this.employeenumber = employeenumber;
		}
		public String getNeareststation() {
			return neareststation;
		}
		public void setNeareststation(String neareststation) {
			this.neareststation = neareststation;
		}
		
		
	}
