package sns.dto;

public class FileInfoDTO {
	
	private String originalFilename;
	private String filePath;
	private long fileSize;

	public FileInfoDTO(){
		
	}
	
	public FileInfoDTO(String originalFilename, String filePath, long fileSize) {
		this.originalFilename = originalFilename;
		this.filePath = filePath;
		this.fileSize = fileSize;
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

}
