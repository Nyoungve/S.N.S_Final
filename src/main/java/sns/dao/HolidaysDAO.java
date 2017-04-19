package sns.dao;

import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.HashedMap;
import org.mybatis.spring.support.SqlSessionDaoSupport;

import sns.dto.HolidayDTO;

public class HolidaysDAO extends SqlSessionDaoSupport{

	//업주가 홀리데이 신청한 것 insert
	public void insertHoliday(String dateText, String restaurant_number){
		
		Map<String, String> map = new HashedMap();
		
		map.put("dateText", dateText);
		map.put("restaurant_number", restaurant_number);
		
		getSqlSession().insert("holidays.insert",map);
		
		
	}
	
	//업주 페이지에서 휴일정보에서 보여줄 휴일 리스트,
	//고객이 레스토랑을 클릭한 경우 레스토랑의 휴일 정보를 보여줄 휴일 리스트
	public List<HolidayDTO> selectListHoliday(String restaurant_number){
		
		List<HolidayDTO> holidays =  getSqlSession().selectList("holidays.selectList", restaurant_number);
		
		return holidays;
	}
	
	
	//업주가 요일을 클릭했을 때 디비에 휴일 정보가 이미 있는지 비교하는 메소드
	public int compareholiday(String dateText, String restaurant_number){
		int resultNum =-1;
		Map<String, String> map = new HashedMap();
		
		map.put("dateText", dateText);
		map.put("restaurant_number", restaurant_number);
		
		resultNum = getSqlSession().selectOne("holidays.compareholiday", map);
		
		//resultNum이 0이면 등록
		//resultNum이 1이면 삭제
		
		return resultNum;
	}
	
	
	//업주가 휴일을 삭제하는 메소드
	public void deleteHoliday(String dateText, String restaurant_number){

		Map<String, String> map = new HashedMap();
		
		map.put("dateText", dateText);
		map.put("restaurant_number", restaurant_number);
		
		getSqlSession().insert("holidays.delete",map);
	}
	
	
}
