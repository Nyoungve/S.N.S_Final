package sns.dao;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import sns.dto.ReserveDTO;

public class ReserveDAO extends SqlSessionDaoSupport{

	
	//고객의 예약 정보를 reserve 테이블에 저장하는 Dao
	public int insertReserveData(ReserveDTO reserveDto){
	
		int resultNum =getSqlSession().insert("reserve.insertReserveData",reserveDto);
		return resultNum;
	}
	
	
	//레스토랑 시간별 예약 현황을 reserve 테이블에서 알려주는 Dao
	public LinkedHashMap<Integer,Integer> searchAvailableTeamCount(String restaurant_number,String today){
		
		Map<String, String> map = new HashMap<>();
		map.put("restaurant_number", restaurant_number);
		map.put("today", today);
	

		LinkedHashMap<Integer,Integer> resultMap = getSqlSession().selectOne("reserve.searchAvailableTeamCount", map);
			
		
		return resultMap;
	}
	
	
	//고객 예약 정보 확인을 위해 reserve테이블에서 알려주는 Dao
	public List<ReserveDTO> c_getReserveList(String userid, String end_rno) {
		
		Map<String, String> map = new HashMap<>();
		map.put("userid", userid);
		map.put("end_rno", end_rno);
		
		List<ReserveDTO> reserveDTO = getSqlSession().selectList("reserve.c_getReserve", map);
		return reserveDTO;
	}
	
	
	
	//업주가 예약 정보를 확인을 이해 reserve테이블에서 알려주는 Dao
	public List<ReserveDTO> e_getReserveList(String restaurant_number, String end_rno) {
		
		Map<String, String> map = new HashMap<>();
		map.put("restaurant_number", restaurant_number);
		map.put("end_rno", end_rno);
		
		List<ReserveDTO> reserveDTO = getSqlSession().selectList("reserve.e_getReserve", map);
		return reserveDTO;
		
	}
	
	//고객이 리뷰쓰기위해 예약번호로 사업자등록번호와 예약날짜 가져오기
	public ReserveDTO getNum_Date(int reserveNumber) {
		ReserveDTO reserveDTO = getSqlSession().selectOne("reserve.c_getNum_Date", reserveNumber);
		return reserveDTO;
	}
	
	//고객이 예약 취소 요청
	public void reserveCancel(String reserveNumber) {
		getSqlSession().update("reserve.c_reserveCancel", reserveNumber);
	}
	
}
