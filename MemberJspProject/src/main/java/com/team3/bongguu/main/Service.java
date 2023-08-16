package com.team3.bongguu.main;

public interface Service {

	// 서비스를 처리해 주는 메서드
	public Object service(Object obj) throws Exception;
	
	// DB를 세팅해 주는 메서드
	public void setDao(Object obj);
	
}
