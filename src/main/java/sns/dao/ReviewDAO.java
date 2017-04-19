package sns.dao;

import java.io.File;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import sns.dto.ReviewDTO;
import sns.dto.ReviewImageDTO;

public class ReviewDAO extends SqlSessionDaoSupport{

	
	
		//고객 후기 정보 확인을 위해 review 테이블에서 알려주는 Dao
		public List<ReviewDTO> getReviewList(String userid) {
			List<ReviewDTO> reviewDTO = getSqlSession().selectList("review.c_getReview", userid);
			return reviewDTO;
		}
		
		//고객 후기 지우는 review 테이블에서 알려주는 Dao
		public void deleteReview(String reserveNumber) {
			getSqlSession().delete("review.c_deleteReview", reserveNumber);
		}
		
		//고객 후기 등록
		public void writeReview(ReviewDTO reviewDTO) {
			getSqlSession().insert("review.c_writeReview", reviewDTO);
			getSqlSession().update("review.c_reviewOk", reviewDTO.getReserveNumber());
		}
		
		//후기 업로드
		public String upload(ReviewDTO reviewDTO) {
			System.out.println("upload");
			long now = System.currentTimeMillis();
			String name = reviewDTO.getUserid();
			String ori_name = reviewDTO.getReview_image().getOriginalFilename();
			
			String path = "c://Review_image//" + now + "_" + name + "_" + ori_name;
			File new_file = new File(path);
			System.out.println(new_file);
			try {
				reviewDTO.getReview_image().transferTo(new_file);
			} catch (Exception e) {
				e.printStackTrace();
			}
			ReviewImageDTO imageDTO = new ReviewImageDTO();
			imageDTO.setOriginalFilename(reviewDTO.getReview_image().getOriginalFilename());
			imageDTO.setFilePath(new_file.getPath());
			imageDTO.setFileSize(reviewDTO.getReview_image().getSize());
			imageDTO.setRestaurant_number(reviewDTO.getRestaurant_number());
			imageDTO.setUserid(reviewDTO.getUserid());
			
			getSqlSession().insert("upload.review_image", imageDTO);
			
			return path;
		}
		
}
