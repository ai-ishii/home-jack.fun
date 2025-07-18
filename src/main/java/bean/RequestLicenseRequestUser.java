package bean;

public class RequestLicenseRequestUser {
	private Request request;
	private LicenseRequest licenseRequest;
	private User user;
	
	
	public Request getRequest() {
		return request;
	}
	public void setRequest(Request request) {
		this.request = request;
	}
	public LicenseRequest getLicenseRequest() {
		return licenseRequest;
	}
	public void setLicenseRequest(LicenseRequest licenseRequest) {
		this.licenseRequest = licenseRequest;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
}
