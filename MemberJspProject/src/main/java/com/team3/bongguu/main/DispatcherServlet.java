package com.team3.bongguu.main;

import java.io.IOException;

import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.Session;

import com.team3.bongguu.error.controller.ErrorController;
import com.team3.bongguu.main.controller.MainController;
import com.team3.bongguu.member.controller.MemberController;

/**
 * Servlet implementation class DispatcherServlet
 */
@WebServlet("/DispatcherServlet")
public class DispatcherServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DispatcherServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {

		try {
			Class.forName("com.team3.bongguu.util.db.DB");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();

		} // end of try catch

		// 객체 생성과 조립 (넣어주기)
		Init.init();
		System.out.println("DispatcherServlet.init() - 객체 생성 완료....");
	}

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("DispatcherServlet.service() - 실행중...");

		// encoding utf-8
		request.setCharacterEncoding("UTF-8");

		try {

			// client using path
			String uri = request.getServletPath();
			System.out.println("DispatcherServlet.service() - 요청한 페이지 : " + uri);
			String jsp = null;

			if (uri.indexOf("/main/") == 0) {

				System.out.println("dispatcher - main");
				jsp = ((MainController) Init.getController("MainController")).execute(request);// main controller 만들 예정

			} else if (uri.indexOf("/member/") == 0) {

				System.out.println("dispatcher - member");
				jsp = ((MemberController) Init.getController("MemberController")).execute(request);

			} else {

				System.out.println("dispatcher - error");
				jsp = ((ErrorController) Init.getController("ErrorController")).execute(request);

			}

			System.out.println("jsp 확인 : " + jsp);
			// redirect 확인
			if (jsp != null) {
				int pos = jsp.indexOf("redirect:");
				System.out.println("DispatcherServlet.service().pos : " + pos);

				if (pos == 0) {
					System.out.println("DispatcherServlet.service() - redirect >>>> 정보로 페이지 이동");
					System.out.println("jsp substring : " + jsp.substring("redirect:".length()));
					response.sendRedirect(jsp.substring("redirect:".length()));

				}
				// jsp로 이동시키는 메서드를 호출한다.
				else {
					System.out.println("DispatcherServlet.service() - forward >>>> 정보로 이동");
					request.getRequestDispatcher("/WEB-INF/views" + jsp + ".jsp").forward(request, response);
				}

			}

		} catch (Exception e) {
			e.printStackTrace();
			request.getSession().setAttribute("exception", e);
			// 추후 예정
			response.sendRedirect("/error/500.do");
		}
	}

}
