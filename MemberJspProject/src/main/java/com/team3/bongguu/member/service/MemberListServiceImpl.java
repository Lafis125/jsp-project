package com.team3.bongguu.member.service;

import com.team3.bongguu.main.Service;
import com.team3.bongguu.member.dao.MemberDAO;
import com.webjjang.util.PageObject;

public class MemberListServiceImpl implements Service {

	MemberDAO dao;

	@Override
	public void setDao(Object obj) {
		this.dao = (MemberDAO) obj;

	}

	@Override
	public Object service(Object obj) throws Exception {

		PageObject pageObject = (PageObject) obj;

		pageObject.setTotalRow(dao.getTotalRow(pageObject));

		return dao.listMember(pageObject);
	}
}
