/*
 * 機能：住所変更申請フォームに表示する内容を格納するためのDTO
 * 
 * 作成者：桑原岳
 * 
 * 最終更新日：2025/08/07
 * 
 * */



package bean;

import java.time.LocalDate;

public class AddressRequestExclusive {
	
		private int requestId;          			//申請ID
		private LocalDate applicationDate;     		//申請日時
		private String name;          				//申請者名
		private int addressRequestId;      		//住所申請ID
		private String oldAddress;        			//旧住所  
		private String newAddress;  				//新住所
		private String oldPost;						//旧郵便番号
		private String newPost; 					//新郵便番号
		private LocalDate  addressChangedDate; 		//住所変更日時
		private String employeeNumber;        		//社員番号
		private String nearestStation; 				//最寄り駅
		
		
		
		
		public int getRequestId() {
			return requestId;
		}
		public void setRequestId(int requestId) {
			this.requestId = requestId;
		}
		public LocalDate getApplicationDate() {
			return applicationDate;
		}
		public void setApplicationDate(LocalDate applicationDate) {
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
		public LocalDate  getAddressChangedDate() {
			return addressChangedDate;
		}
		public void setAddressChangedDate(LocalDate  addressChangedDate) {
			this.addressChangedDate = addressChangedDate;
		}
		public String getEmployeenumber() {
			return employeeNumber;
		}
		public void setEmployeenumber(String employeenumber) {
			this.employeeNumber = employeenumber;
		}
		public String getNeareststation() {
			return nearestStation;
		}
		public void setNeareststation(String neareststation) {
			this.nearestStation = neareststation;
		}
		
		
	}
