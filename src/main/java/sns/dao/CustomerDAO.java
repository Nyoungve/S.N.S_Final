package sns.dao;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import sns.dto.CustomerDTO;

public class CustomerDAO extends SqlSessionDaoSupport{

	//업체 등록 아이디 customer 테이블에서  찾아서 보내주기
		public CustomerDTO getCustomer(String id){
			CustomerDTO customer = getSqlSession().selectOne("customer.getOne", id);
			return customer;
			
		}
	
	//고객 아이디를 받아서 customer 테이블에서 블랙리스트 가져오기
	public List<CustomerDTO> getBlackList(String id) {
			List<CustomerDTO> CustomerDTOs = getSqlSession().selectList("customer.getList", id);
			return CustomerDTOs;
	}
	
	//고객 아이디를 받아서 customer 테이블에서 노쇼 카운트를 0으로 초기화
	public void noShowCountUpdate(String id){
			getSqlSession().update("customer.update",id);	
		}
	
	
	
	
}
