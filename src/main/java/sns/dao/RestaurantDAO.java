package sns.dao;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.web.multipart.MultipartFile;

import sns.dto.FileInfoDTO;
import sns.dto.ReserveDTO;
import sns.dto.RestaurantDTO;
import sns.dto.RestaurantuploadDTO;
import sns.dto.SearchDTO;


public class RestaurantDAO extends SqlSessionDaoSupport{

	
	public RestaurantDTO  selectRestaurantInfo(String restaurant_number){
		
		RestaurantDTO restaurantDto = getSqlSession().selectOne("restaurant.selectRestaurantInfo", restaurant_number);
		return restaurantDto;
		
	}
	
	
	public void reserveOk(ReserveDTO reserveDTO) {
		getSqlSession().update("reserve.e_reserveOk", reserveDTO);
		
	}
	
	public void reserveCancel(ReserveDTO reserveDTO) {
		getSqlSession().update("reserve.e_reserveCancel", reserveDTO);
		
	}
	

	//업주가 레스토랑 정보 수정을 요청
	public RestaurantDTO getE_info(String restaurant_number) {
	
		RestaurantDTO restaurantDto = getSqlSession().selectOne("restaurant.selectRestaurantInfo", restaurant_number);
		return restaurantDto;
	}
	
	
	//업주가 레스토랑 정보를 update 처리
	public void updateInfo(RestaurantDTO  restaurantDto){
		getSqlSession().update("enterInfo.updateE_info",restaurantDto);
	}
	
	
	//업주가 레스토랑 정보 수정 요청 시 파일 업로드 처리
	public void upload(MultipartFile image, String restaurant_number,RestaurantuploadDTO restaurantuploadDto) {
		
		//파일 수정 사항이 없는 경우 return 시킨다.
		if(image.getOriginalFilename().equals("")){
			System.out.println("파일내용변동사항없음");
			return;
		}
		
		long now = System.currentTimeMillis();
		Random r = new Random();
		int i = r.nextInt(50);
		String name = restaurant_number + "_" + now + "_" + i;
		String ori_name = image.getOriginalFilename();
		//File new_file = new File("f://E_image//" + name + "_" + ori_name);
		
		//동규 노트북
		String donggyuNotebook="C:\\Users\\user\\Documents\\workspace-sts-3.8.3.RELEASE\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\sns_final\\img\\";
		
		//동규 집컴터
		String donggyuDesktop ="C:\\spring\\spring-tool-suite-3.8.3.RELEASE-e4.6.2-win32-x86_64\\sts-bundle\\work\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\sns\\img\\";

		//동규 학원
		String donggyuHak ="C:\\spring\\spring-tool-suite-3.8.3.RELEASE-e4.6.2-win32-x86_64\\sts-bundle\\work\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\sns_final\\img\\";
		
		File new_file = new File(donggyuHak+name+"_"+ori_name);
		System.out.println(new_file);
		
		try {
			
			//파일을 업로드 처리
			image.transferTo(new_file);
			System.out.println("파일 업로드 완료");
			
			if(image.getName().equals("main_image")){
				restaurantuploadDto.setM_path(new_file.getAbsolutePath());
			}
			
			if(image.getName().equals("detail_image")){
				restaurantuploadDto.setD_path1(new_file.getAbsolutePath());
			}
			
			if(image.getName().equals("menu_image")){
				restaurantuploadDto.setMn_path(new_file.getAbsolutePath());
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
		//FileInfoDTO f = new FileInfoDTO(image.getOriginalFilename(), new_file.getPath(), image.getSize());
		//getSqlSession().insert("file.addFile", f);
	}

	
	//업주 로그인 시 업주의 사업장 번호들로부터 레스토랑 정보를 가져오는 메소드
	public List<RestaurantDTO> getRestaurants(List<String> ownerRestaurantNumberList){
		
		List<RestaurantDTO> restaurants = getSqlSession().selectList("restaurant.getRestaurants", ownerRestaurantNumberList);
		
		return restaurants;
	}
	
	
	//메인 페이지에서 레스토랑들을 보여줄 리스트 가져오는 메소드
	public List<RestaurantDTO> selectRestaurantList(int pageNum){
		
		Map<String, Integer> map = new HashMap<>();
		
		// 보여줄 댓글 수
		int commentPageSize = 3;

		// 요청 페이지 번호 commentPageNum

		// 한페이지의시작글번호
		int StartRow = (pageNum - 1) * commentPageSize + 1;
																					
		int EndRow = pageNum * commentPageSize;//
		
		map.put("startRow", StartRow);
		map.put("endRow", EndRow);
		
		
		List<RestaurantDTO> restaurantDtos = getSqlSession().selectList("restaurant.mainRestaurantList",map);
		
		return restaurantDtos;
	}
	
	
	//관리자가 레스토랑을 처음 등록하는 처리
	public void insertRestaurantForm(RestaurantDTO restaurantDto){
		
		getSqlSession().insert("restaurant.insertRestaurantForm", restaurantDto);
		
	}
	
	
	public List<RestaurantDTO> searchRestaurant(SearchDTO searchDto){
		
		List<RestaurantDTO> restaurantDtos = getSqlSession().selectList("restaurant.searchRestaurant", searchDto);
		return restaurantDtos;
	}
	
}
