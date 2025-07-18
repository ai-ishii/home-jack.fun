package bean;

public class AddressRequest {
	private int addressRequestId;      //住所申請ID
	private int requestId;          	//申請ID
	private String oldAddress;        	//旧住所  
	private String newAddress;  		//新住所
	private String oldPost;				//旧郵便番号
	private String newPost; 			//新郵便番号
	
	
	public int getAddressRequestId() {
		return addressRequestId;
	}
	public void setAddressRequestId(int addressRequestId) {
		this.addressRequestId = addressRequestId;
	}
	public int getRequestId() {
		return requestId;
	}
	public void setRequestId(int requestId) {
		this.requestId = requestId;
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
	
}

