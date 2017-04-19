package sns.dao;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.web.multipart.MultipartFile;

import sns.dto.CustomerDTO;
import sns.dto.FileInfoDTO;
import sns.dto.ReserveDTO;
import sns.dto.ReviewDTO;

public class C_MypageDAO extends SqlSessionDaoSupport {
	
	public List<ReserveDTO> getReserveList(String userid, String end_rno) {
		
		Map<String, String> map = new HashMap<>();
		map.put("userid", userid);
		map.put("end_rno", end_rno);
		
		List<ReserveDTO> reserveDTO = getSqlSession().selectList("reserve.c_getReserve", map);
		return reserveDTO;
	}
	
	public ReserveDTO getNum_Date(int reserveNumber) {
		ReserveDTO reserveDTO = getSqlSession().selectOne("reserve.c_getNum_Date", reserveNumber);
		return reserveDTO;
	}
	
	public void reserveCancel(String reserveNumber) {
		getSqlSession().update("reserve.c_reserveCancel", reserveNumber);
	}
	
	
	
	public void writeReview(ReviewDTO reviewDTO) {
		
		System.out.println(reviewDTO.getReview_image());
		
		
		
		
		
		getSqlSession().insert("review.c_writeReview", reviewDTO);
	}
	
	
	
	public List<ReviewDTO> getReviewList(String userid) {
		List<ReviewDTO> reviewDTO = getSqlSession().selectList("review.c_getReview", userid);
		return reviewDTO;
	}
	
	public void deleteReview(ReviewDTO reviewDto) {
		getSqlSession().delete("review.c_deleteReview", reviewDto);
	}
	
	public CustomerDTO getInfo(String userid) {
		CustomerDTO userInfo = getSqlSession().selectOne("userInfo.getInfo", userid);
		return userInfo;
	}
	
	public void modifyInfo(CustomerDTO userInfo) {
		getSqlSession().update("userInfo.modifyInfo", userInfo);
	}
	
	public void upload(MultipartFile image, String userid) {
		System.out.println("upload");
		long now = System.currentTimeMillis();
		Random r = new Random();
		int i = r.nextInt(50);
		String name = userid + "_" + now + "_" + i;
		String ori_name = image.getOriginalFilename();
		File new_file = new File("f://E_image//" + name + "_" + ori_name);
		System.out.println(new_file);
		try {
			image.transferTo(new_file);
		} catch (Exception e) {
			e.printStackTrace();
		}
		FileInfoDTO f = new FileInfoDTO(image.getOriginalFilename(), new_file.getPath(), image.getSize());
		getSqlSession().insert("file.addFile", f);
	}

}
