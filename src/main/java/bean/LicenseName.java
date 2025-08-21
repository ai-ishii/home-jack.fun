/*
 * 機能：資格名DTO
 * 
 * 作成者：桑原岳
 * 
 * 最終更新日：2025/08/20
 * 
 * */

package bean;

public class LicenseName {
	
	private int licenseId; 					//資格ID
	private String typeCode; 				//資格コード
	private String licenseName ; 					//資格名
	
	
	public int getLicenseId() {
		return licenseId;
	}
	public void setLicenseId(int licenseId) {
		this.licenseId = licenseId;
	}
	public String getTypeCode() {
		return typeCode;
	}
	public void setTypeCode(String typeCode) {
		this.typeCode = typeCode;
	}
	public String getLicenseName() {
		return licenseName;
	}
	public void setLicenseName(String licenseName) {
		this.licenseName = licenseName;
	}
	
	
}
