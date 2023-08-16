package com.team3.bongguu.main;

import javax.servlet.http.HttpServletRequest;

public interface Controller {

	public String execute(HttpServletRequest request) throws Exception;
	
}
