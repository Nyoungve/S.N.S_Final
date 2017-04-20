package sns.dao;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import sns.dto.RestaurantuploadDTO;

public class RestaurantuploadDAO extends SqlSessionDaoSupport{

	// 처음에 이미지를 등록하는  처리
	public void insertInfo(RestaurantuploadDTO restaurantuploadDto){
		System.out.println("인서트 시작 전");
		
		
		getSqlSession().insert("restaurantupload.insertPath", restaurantuploadDto);
		
		
		System.out.println("인서트 시작 후");
	}
	
	
	//이미지가 이미 등록되어 있는지 파악하는 처리
	public int searchNumber(String restaurant_number){
		
		int resultNum = getSqlSession().selectOne("restaurantupload.searchNumber",  restaurant_number);
		
		
		return resultNum;
	}
	
	//이미 이미지가 등록되어 있으면 update하는 처리
	
	public void updateInfo(RestaurantuploadDTO restaurantuploadDto){
		
		System.out.println("파일 업데이트 수행 전");
		System.out.println(restaurantuploadDto.getRestaurant_number());
		System.out.println(restaurantuploadDto.getM_path());
		System.out.println(restaurantuploadDto.getD_path1());
		
		System.out.println(restaurantuploadDto.getMn_path());
		
		getSqlSession().update("restaurantupload.updatePath", restaurantuploadDto);
		
	}
	
	
	
	//업주가 정보수정을 요구했을 때 원래 있던 초기 값을 보여주는 로직
	public RestaurantuploadDTO selectImageList(String restaurant_number){
	
		
		RestaurantuploadDTO restaurantuploadDTO  = getSqlSession().selectOne("restaurantupload.selectPath", restaurant_number);
		
		return restaurantuploadDTO;
	}
	
	
	
}
