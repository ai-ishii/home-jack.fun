package bean;

public class NameRequest {

	private int nameRequestId; 		//氏名申請ID
	private int requestId;			 	//申請ID
	private String oldName; 			//旧氏名
	private String newName; 			//新氏名
	private String oldNameKana; 		//旧氏名(かな)
	private String newNameKana; 		//新氏名(かな)
	
	
	
	public int getNameRequestId() {
		return nameRequestId;
	}
	public void setNameRequestId(int nameRequestId) {
		this.nameRequestId = nameRequestId;
	}
	public int getRequestId() {
		return requestId;
	}
	public void setRequestId(int requestId) {
		this.requestId = requestId;
	}
	public String getOldName() {
		return oldName;
	}
	public void setOldName(String oldName) {
		this.oldName = oldName;
	}
	public String getNewName() {
		return newName;
	}
	public void setNewName(String newName) {
		this.newName = newName;
	}
	public String getOldNameKana() {
		return oldNameKana;
	}
	public void setOldNameKana(String oldNameKana) {
		this.oldNameKana = oldNameKana;
	}
	
	public String getNewNameKana() {
		return newNameKana;
	}
	public void setNewNameKana(String newNameKana) {
		this.newNameKana = newNameKana;
	}

	
}
