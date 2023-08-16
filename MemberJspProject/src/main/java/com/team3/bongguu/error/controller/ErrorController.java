package com.team3.bongguu.error.controller;

import javax.servlet.http.HttpServletRequest;

import com.team3.bongguu.main.Controller;

public class ErrorController implements Controller {

	@Override
	public String execute(HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		// 리턴 데이터
		String jsp = null;

		// 요청한 url에 따라서 처리 - /board/~~.do
		String uri = request.getServletPath();
		switch (uri) {
		case "/error/error.do":
			System.out.println("보편적인 오류 처리");
			jsp = "/error/error";
			break;
		case "/error/auth.do":
			System.out.println("권한 오류 처리");
			jsp = "/error/auth";
			break;
		case "/error/404.do":
			System.out.println("리소스 찾을 수 없음. 처리");
			jsp = "/error/404";
		}
		return jsp;
	}

}
