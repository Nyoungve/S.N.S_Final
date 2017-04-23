package sns.dao;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import sns.dto.ReviewDTO;
import sns.dto.ReviewImageDTO;

public class ReviewDAO extends SqlSessionDaoSupport{

	
	
		//고객 후기 정보 확인을 위해 review 테이블에서 알려주는 Dao
		public List<ReviewDTO> getReviewList(String userid, String review_rno) {
			
			Map<String, String> map = new HashMap<>();
			map.put("userid", userid);
			map.put("review_rno", review_rno);
			
			List<ReviewDTO> reviewDTO = getSqlSession().selectList("review.c_getReviewList", map);
			return reviewDTO;
		}
		
		//레스토랑의 후기들을 보기 위해 review 테이블에서 알려주는 Dao
		public List<ReviewDTO> getReviewList(String restaurant_number){
			
			List<ReviewDTO> reviewDTOs = getSqlSession().selectList("review.r_getReviewList", restaurant_number);
			
			
			return reviewDTOs;
		}
		
		
		
		
		
		public ReviewDTO getReviewInfo(String reserveNumber) {
			
			ReviewDTO reviewDTO = getSqlSession().selectOne("review.c_getReviewInfo", reserveNumber);
			
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
		
		//고객 후기 수정
		public void modifyReview(ReviewDTO reviewDTO) {
			getSqlSession().update("review.c_modifyReview", reviewDTO);
		}
		
		//후기 업로드
		public String imageUpload(ReviewDTO reviewDTO) {
			System.out.println("upload");
			long now = System.currentTimeMillis();
			String name = reviewDTO.getUserid();
			String ori_name = reviewDTO.getReview_image().getOriginalFilename();
			
			// 빛찬 학원 컴퓨터
			String projectPath = "C:\\Users\\user2\\workspace2\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp1\\wtpwebapps\\S.N.S_Final\\img\\";
			
			// 빛찬 집 컴퓨터
			String projectPath2 = "C:\\Users\\Chan\\Spring\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\S.N.S\\img\\";
			
			String path = projectPath + now + "_" + name + "_" + ori_name;
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
			imageDTO.setReserveNumber(reviewDTO.getReserveNumber());
			
			getSqlSession().insert("upload.review_image", imageDTO);
			
			return path;
		}
		
		public String imageModify(ReviewDTO reviewDTO) {
			System.out.println("Review Modify");
			long now = System.currentTimeMillis();
			String name = reviewDTO.getUserid();
			String ori_name = reviewDTO.getReview_image().getOriginalFilename();
			
			// 빛찬 학원 컴퓨터
			String projectPath = "C:\\Users\\user2\\workspace2\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp1\\wtpwebapps\\S.N.S_Final\\img\\";
						
			// 빛찬 집 컴퓨터
			String projectPath2 = "C:\\Users\\Chan\\Spring\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\S.N.S\\img\\";
						
			String path = projectPath + now + "_" + name + "_" + ori_name;
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
			imageDTO.setReserveNumber(reviewDTO.getReserveNumber());
			
			getSqlSession().update("upload.review_imageModify", imageDTO);
			
			return path;
		}
		
		
}
