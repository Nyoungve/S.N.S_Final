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
	
	//아이디 찾기 (이메일인증)
	//이메일을 입력받아서 이름과 이메일을 찾아낸다. 
	public CustomerDTO idFind(String email){
		CustomerDTO cDto = 
		getSqlSession().selectOne("join.findId",email);
		return cDto;
	}
	
	//비밀번호 업데이트 
	//이메일과 아이디를 입력받는다.
	//비밀번호를 난수로 변경해서 이메일로 보내준다.
	public int PasswordIssue(CustomerDTO customerDto){
		int i = getSqlSession().update("join.issuePass",customerDto); 
		return i;
	}
}
