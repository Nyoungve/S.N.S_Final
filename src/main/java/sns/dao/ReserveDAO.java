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
	
		System.out.println(reserveDto.getReserve_date());
			
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
	public List<ReserveDTO> c_getReserveList(String userid, String reserve_rno) {
		
		Map<String, String> map = new HashMap<>();
		map.put("userid", userid);
		map.put("reserve_rno", reserve_rno);
		
		List<ReserveDTO> reserveDTO = getSqlSession().selectList("reserve.c_getReserve", map);
		return reserveDTO;
	}
	
	
	
	//업주가 예약 정보를 확인을 이해 reserve테이블에서 알려주는 Dao
	public List<ReserveDTO> e_getReserveList(String restaurant_number) {
		
		Map<String, String> map = new HashMap<>();
		map.put("restaurant_number", restaurant_number);
		
		List<ReserveDTO> reserveDTO = getSqlSession().selectList("reserve.e_getReserve", map);
		System.out.println(reserveDTO);
		return reserveDTO;
		
	}
	
	//고객이 리뷰쓰기위해 예약번호로 사업자등록번호와 예약날짜 가져오기
	public ReserveDTO getNum_Date(int reserveNumber) {
		ReserveDTO reserveDTO = getSqlSession().selectOne("reserve.c_getNum_Date", reserveNumber);
		return reserveDTO;
	}
	
	//고객이 예약 취소 요청
	public void c_reserveCancel(String reserveNumber) {
		getSqlSession().update("reserve.c_reserveCancel", reserveNumber);
	}
	
	
	//업체 예약 승인
	public void e_reserveOk(String reserveNumber) {
		getSqlSession().update("reserve.e_reserveOk", reserveNumber);
	}
	
	//업체 예약 취소
	public void e_reserveCancel(String reserveNumber) {
		getSqlSession().update("reserve.e_reserveCancel", reserveNumber);
	}
	
	
	//업주 마이 페이지에서 노쇼 리스트를 처리하기 위해 reserve 테이블에 접근
	public List<ReserveDTO> noShowList(String restaurant_number){
		List<ReserveDTO> noShowList =getSqlSession().selectList("reserve.noShowList", restaurant_number);
		return noShowList;
		
	}
	
	//업주 마이 페이지에서 노쇼 확정 처리 , 노쇼인 고객은 r_state 6번으로 업데이트
	
	public void updateNotComePeople(String reserveNumber){
		
		getSqlSession().update("reserve.updateNotComePeople", Integer.parseInt(reserveNumber));
		
		
	}
	
	//예약 번호에 해당하는 유저 id를 가져오는 처리
	public String selectId(String reserveNumber){
		
		String userid =getSqlSession().selectOne("reserve.selectId", Integer.parseInt(reserveNumber));
		
		return userid;
	}
	
	
	//업주 마이 페이지에서 노쇼 확정 처리 , 온  고객은 r_state 5번으로 업데이트
	
		public void updateComePeople(String reserveNumber){
			
			getSqlSession().update("reserve.updateComePeople", Integer.parseInt(reserveNumber));
			
			
		}
	
	
	//예약날짜와 시간대에 몇명이나 예약되어 있는지를 확인하는 처리
	public int reserveSituationNum(ReserveDTO reserveDto){
		int reserveSituationNum =getSqlSession().selectOne("reserve.getreserveSituationNum", reserveDto);
				
				return reserveSituationNum;
	}	
		
	//예약 신청 시 사용자에게 예약 번호를 알려주는 처리
	public int getReserveNumber(ReserveDTO reserveDto){
		
		int reserveNumber = getSqlSession().selectOne("reserve.getReserveNumber",reserveDto);
		
		System.out.println("예약번호 : " + reserveNumber);
		return reserveNumber;
	}
	
	
	

	//예약자가 결제 취소시 디비 데이터 삭제
	public void deleteReserveData(int reserveNumber){
	
		System.out.println("예약번호 삭제 :" +reserveNumber);
		getSqlSession().delete("reserve.deleteReserveData", reserveNumber);
	
	}
	
	
	//휴일 등록 시 예약 진행사항이 있는지 확인
	public int reserveCheck(String dateText,String restaurant_number){
		Map<String, String> map = new HashMap<>();
		map.put("dateText", dateText);
		map.put("restaurant_number", restaurant_number);
		
		
		int  reserveCheckNum = getSqlSession().selectOne("reserve.reserveCheck", map);
		return  reserveCheckNum;
	}
	
		
}
