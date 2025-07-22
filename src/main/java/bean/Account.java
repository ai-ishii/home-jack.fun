package bean;

public class Account {

	private String accountId;			//アカウントID
	private String email;				//メールアドレス
	private int adminFlag;				//権限（管理者フラグ）
	private int managerFlag;			//権限（マネージャーフラグ）
	
	public String getAccountId() {
		return accountId;
	}
	
	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public int getAdminFlag() {
		return adminFlag;
	}
	
	public void setAdminFlag(int adminFlag) {
		this.adminFlag = adminFlag;
	}
	
	public int getManagerFlag() {
		return managerFlag;
	}
	
	public void setManagerFlag(int managerFlag) {
		this.managerFlag = managerFlag;
	}
	
}
