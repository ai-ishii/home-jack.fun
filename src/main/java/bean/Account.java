package bean;

public class Account {

	private int account_id;				//アカウントID
	private String pass;				//パスワード
	private String mail;				//メールアドレス
	private int admin_flag;				//権限（管理者フラグ）
	private int manager_flag;			//権限（マネージャーフラグ）
	
	
	
	

		public int getAccount_id() {
			return account_id;
		}
		

		public void setAccount_id(int account_id) {
			this.account_id = account_id;
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


		public int getAdmin_flag() {
			return admin_flag;
		}


		public void setAdmin_flag(int admin_flag) {
			this.admin_flag = admin_flag;
		}


		public int getManager_flag() {
			return manager_flag;
		}


		public void setManager_flag(int manager_flag) {
			this.manager_flag = manager_flag;
		}


		
}
