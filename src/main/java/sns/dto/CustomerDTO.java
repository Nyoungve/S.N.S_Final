package sns.dto;

public class CustomerDTO {

	private String userid;
	private String name;
	private String password;
	private String mobile;
	private String email;
	private int noShowCount;
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getNoShowCount() {
		return noShowCount;
	}
	public void setNoShowCount(int noShowCount) {
		this.noShowCount = noShowCount;
	}
	
	
	
	
	
}
