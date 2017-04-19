package sns.dao;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import sns.dto.CustomerDTO;

public class C_JoinDAO extends SqlSessionDaoSupport{

	//회원가입 데이터넣기!
		public int joinCustomer(CustomerDTO customerDTO){
			int i = getSqlSession().insert("join.joinCustomer",customerDTO);
			return i;
		}
		
		//아이디 중복 체크!
		public CustomerDTO idCheck(String userid){
			CustomerDTO customerDTO = getSqlSession().selectOne("join.idCheck",userid);
			return customerDTO;
		}
		
}
