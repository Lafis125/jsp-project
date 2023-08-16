package com.team3.bongguu.member.service;

import com.team3.bongguu.main.Service;
import com.team3.bongguu.member.dao.MemberDAO;

public class MemberViewInFoServiceImpl implements Service {

	MemberDAO dao;

	@Override
	public Object service(Object obj) throws Exception {

		return dao.viewInfo((String) obj);
	}

	@Override
	public void setDao(Object obj) {

		this.dao = (MemberDAO) obj;
	}

}
