package sns.dao;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import sns.dto.CustomerDTO;

public class C_LoginDAO extends SqlSessionDaoSupport{
	//패스워드 하나만 가져오는 쿼리문
		public CustomerDTO selectIdPass(String userid){
			
	
			CustomerDTO customerDto = getSqlSession().selectOne("login.selectIdPass",userid);
			
			
			return customerDto;
			
		}
}