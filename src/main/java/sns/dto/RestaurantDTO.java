package sns.dto;

import org.springframework.web.multipart.MultipartFile;

public class RestaurantDTO {

	
	private String restaurant_number;
	private String e_name;
	private String address;
	private int teamCount;
	private String type;
	private String pay_key;
	private String r_info;
	private String r_time;
	private int openingTime;
	private int closingTime;
	private MultipartFile main_image;
	private MultipartFile detail_image;
	private MultipartFile menu_image;
	private String zipcode;
	private String m_path;
	private String d_path;
	private String mn_path;
	private int avgRanking;
	
	
	public String getD_path() {
		return d_path;
	}
	public void setD_path(String d_path) {
		this.d_path = d_path;
	}
	public String getMn_path() {
		return mn_path;
	}
	public void setMn_path(String mn_path) {
		this.mn_path = mn_path;
	}
	public int getAvgRanking() {
		return avgRanking;
	}
	public void setAvgRanking(int avgRanking) {
		this.avgRanking = avgRanking;
	}
	public String getM_path() {
		return m_path;
	}
	public void setM_path(String m_path) {
		this.m_path = m_path;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public MultipartFile getMain_image() {
		return main_image;
	}
	public void setMain_image(MultipartFile main_image) {
		this.main_image = main_image;
	}
	public MultipartFile getDetail_image() {
		return detail_image;
	}
	public void setDetail_image(MultipartFile detail_image) {
		this.detail_image = detail_image;
	}
	public MultipartFile getMenu_image() {
		return menu_image;
	}
	public void setMenu_image(MultipartFile menu_image) {
		this.menu_image = menu_image;
	}
	public int getOpeningTime() {
		return openingTime;
	}
	public void setOpeningTime(int openingTime) {
		this.openingTime = openingTime;
	}
	
	
	
	public String getRestaurant_number() {
		return restaurant_number;
	}
	public void setRestaurant_number(String restaurant_number) {
		this.restaurant_number = restaurant_number;
	}
	public String getE_name() {
		return e_name;
	}
	public void setE_name(String e_name) {
		this.e_name = e_name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
	public int getTeamCount() {
		return teamCount;
	}
	public void setTeamCount(int teamCount) {
		this.teamCount = teamCount;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getPay_key() {
		return pay_key;
	}
	public void setPay_key(String pay_key) {
		this.pay_key = pay_key;
	}
	public String getR_info() {
		return r_info;
	}
	public void setR_info(String r_info) {
		this.r_info = r_info;
	}
	public String getR_time() {
		return r_time;
	}
	public void setR_time(String r_time) {
		this.r_time = r_time;
	}
	
	
	public int getClosingTime() {
		return closingTime;
	}
	public void setClosingTime(int closingTime) {
		this.closingTime = closingTime;
	}
	
	@Override
	public String toString() {
		return "RestaurantDTO [restaurant_number=" + restaurant_number + ", e_name=" + e_name + ", address=" + address
				+ ", teamCount=" + teamCount + ", type=" + type + ", pay_key=" + pay_key + ", r_info=" + r_info
				+ ", r_time=" + r_time + ", openingTime=" + openingTime + ", closingTime=" + closingTime
				+ ", main_image=" + main_image + ", detail_image=" + detail_image + ", menu_image=" + menu_image
				+ ", zipcode=" + zipcode + ", m_path=" + m_path + ", avgRanking=" + avgRanking + "]";
	}
	
	
	
	
	
	
	
	
	
	
}
