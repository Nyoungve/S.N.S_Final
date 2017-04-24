package sns.dao;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import sns.dto.ZipcodeDTO;

public class ZipcodeDAO extends SqlSessionDaoSupport{

	
	
	public List<ZipcodeDTO> zipcodeRead(String area4) {
		
		List<ZipcodeDTO> zipCodeList = getSqlSession().selectList("zipcode.getList", area4);
		return zipCodeList;
		
	}
	
	
	public List<String> getListData(String string) {
		List<String> sido = getSqlSession().selectList("zipcode.listSido",string);
		return sido;
	}

	public List<String> getListData(String string, String city) {
		List<String> selectcity = getSqlSession().selectList("zipcode.listCity", city);
		return selectcity;
	}
	
}
