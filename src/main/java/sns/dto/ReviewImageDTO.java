package sns.dto;

import java.util.Date;

public class ReviewImageDTO {
	
	private String restaurant_number;
	private String originalFilename;
	private String filePath;
	private long fileSize;
	private String userid;
	private Date write_date;
	
	
	public String getRestaurant_number() {
		return restaurant_number;
	}
	public void setRestaurant_number(String restaurant_number) {
		this.restaurant_number = restaurant_number;
	}
	public String getOriginalFilename() {
		return originalFilename;
	}
	public void setOriginalFilename(String originalFilename) {
		this.originalFilename = originalFilename;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public long getFileSize() {
		return fileSize;
	}
	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public Date getWrite_date() {
		return write_date;
	}
	public void setWrite_date(Date write_date) {
		this.write_date = write_date;
	}
	
}
