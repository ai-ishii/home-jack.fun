package bean;

public class AuthorityHaving {

	private int authorityId;		//権限番号(連番)
	private int userId;				//ユーザーID
	private String authorityCode;	//権限コード(8文字)
	
	public int getAuthorityId() {
		return authorityId;
	}
	public void setAuthorityId(int authorityId) {
		this.authorityId = authorityId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getAuthorityCode() {
		return authorityCode;
	}
	public void setAuthorityCode(String authorityCode) {
		this.authorityCode = authorityCode;
	}
	
}
