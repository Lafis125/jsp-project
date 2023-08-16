package com.team3.bongguu.member.service;

import com.team3.bongguu.main.Service;
import com.team3.bongguu.member.dao.MemberDAO;
import com.team3.bongguu.member.vo.LoginVO;

public class MemberLoginServiceImpl implements Service {

	MemberDAO dao;

	@Override
	public void setDao(Object obj) {
		this.dao = (MemberDAO) obj;

	}

	@Override
	public Object service(Object obj) throws Exception {

		return dao.login((LoginVO) obj);
	}

}
