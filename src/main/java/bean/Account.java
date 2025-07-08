package bean;

public class Account {

	private int accountId;				//アカウントID
	private String pass;				//パスワード
	private String mail;				//メールアドレス
	private int adminFlag;				//権限（管理者フラグ）
	private int managerFlag;			//権限（マネージャーフラグ）
	

		public int getAccountId() {
			return accountId;
		}


		public void setAccountId(int accountId) {
			this.accountId = accountId;
		}


		public String getPass() {
			return pass;
		}


		public void setPass(String pass) {
			this.pass = pass;
		}


		public String getMail() {
			return mail;
		}


		public void setMail(String mail) {
			this.mail = mail;
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
