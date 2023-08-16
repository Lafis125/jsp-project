package com.team3.bongguu.main.controller;

import javax.servlet.http.HttpServletRequest;

import com.team3.bongguu.main.Controller;

public class MainController implements Controller {

	@Override
	public String execute(HttpServletRequest request) throws Exception {
		String jsp = null;
		String url = request.getServletPath();

		try {
			switch (url) {

			case "/main/main.do":
				System.out.println("MainController - main페이지");

				jsp = "/main/main";
				break;

			default:
				break;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return jsp;
	}

}
