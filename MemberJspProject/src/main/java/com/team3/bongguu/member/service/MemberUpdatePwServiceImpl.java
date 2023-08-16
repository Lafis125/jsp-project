package com.team3.bongguu.member.service;

import com.team3.bongguu.main.Service;
import com.team3.bongguu.member.dao.MemberDAO;
import com.team3.bongguu.member.vo.MemberVO;

public class MemberUpdatePwServiceImpl implements Service {

	MemberDAO dao;

	@Override
	public Object service(Object obj) throws Exception {

		return dao.updatepw((MemberVO) obj);
	}

	@Override
	public void setDao(Object obj) {
		this.dao = (MemberDAO) obj;
	}

}
