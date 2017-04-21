package sns.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import sns.dto.OwnerDTO;

public class OwnerDAO extends SqlSessionDaoSupport{

	
	//owner 정보를 받아서 owner 테이블에 정보를 넣는 Dao
	public void insertOwner(OwnerDTO ownerDto){
	getSqlSession().update("enterprise.insert",ownerDto);	
	}

	//레스토랑 정보를 보여줄 때 업주 정보도 owner테이블에서 가져온다.
	public  OwnerDTO  getOwnerInfo(String restaurant_number){
		OwnerDTO owerDto = getSqlSession().selectOne("enterprise.getOwnerInfo", restaurant_number);
		
		return owerDto;
	}
	
	//업주 페이지에서 로그인 처리시 아이디와 비밀번호와 일치하는 컬럼이 있는지 확인
	public String searchIdPw(String user_id,String password){
		
		Map<String, String> map = new HashMap<>();
		map.put("user_id", user_id);
		map.put("password", password);
		
		String userid =getSqlSession().selectOne("enterprise.searchIdPw",map);
		System.out.println(userid);
		
		return userid;
	}
	
	//업주 로그인 성공시 업주의 레스토랑 목록을 보내준다.
	public List<String> ownerRestaurantNumberList(String userid){
		List<String> ownerRestaurantNumberList= getSqlSession().selectList("enterprise.ownerRestaurantNumberList", userid);
		return ownerRestaurantNumberList;
	}
	
	
	
}
