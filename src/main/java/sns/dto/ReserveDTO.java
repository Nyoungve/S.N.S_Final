package sns.dto;

import java.util.Date;

public class ReserveDTO {
	
	private String restaurant_number;
	private Date reserve_date;
	private String userid;
	private String deposit;
	private int r_state;
	private String e_name;
	private int guestCount;
	private int reserveNumber;
	private int reviewCheck;
	
	
	public int getReviewCheck() {
		return reviewCheck;
	}
	public void setReviewCheck(int reviewCheck) {
		this.reviewCheck = reviewCheck;
	}
	public int getReserveNumber() {
		return reserveNumber;
	}
	public void setReserveNumber(int reserveNumber) {
		this.reserveNumber = reserveNumber;
	}
	public int getGuestCount() {
		return guestCount;
	}
	public void setGuestCount(int guestCount) {
		this.guestCount = guestCount;
	}
	public int getR_state() {
		return r_state;
	}
	public void setR_state(int r_state) {
		this.r_state = r_state;
	}
	public String getE_name() {
		return e_name;
	}
	public void setE_name(String e_name) {
		this.e_name = e_name;
	}
	public String getRestaurant_number() {
		return restaurant_number;
	}
	public void setRestaurant_number(String restaurant_number) {
		this.restaurant_number = restaurant_number;
	}
	public Date getReserve_date() {
		return reserve_date;
	}
	public void setReserve_date(Date reserve_date) {
		this.reserve_date = reserve_date;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getDeposit() {
		return deposit;
	}
	public void setDeposit(String deposit) {
		this.deposit = deposit;
	}
	
	
	@Override
	public String toString() {
		return "ReserveDTO [restaurant_number=" + restaurant_number + ", reserve_date=" + reserve_date + ", userid="
				+ userid + ", deposit=" + deposit + ", r_state=" + r_state + ", e_name=" + e_name + ", guestCount="
				+ guestCount + "]";
	}
	
	
	
	
	
	
	
}
