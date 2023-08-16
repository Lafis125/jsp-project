package com.team3.bongguu.util.filter;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.team3.bongguu.member.vo.LoginVO;

/**
 * Servlet Filter implementation class AuthorityFilter
 */
public class AuthorityFilter extends HttpFilter implements Filter {

	private static final long serialVersionUID = 1L;

	private Map<String, Integer> authMap = new HashMap<>();

	/**
	 * @see HttpFilter#HttpFilter()
	 */
	public AuthorityFilter() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here

		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;

		String uri = req.getRequestURI();
		System.out.println("AuthorityFilter.doFilter().uri - " + uri);

		Integer pageGradeNo = authMap.get(uri);

		System.out.println("AuthorityFilter.doFilter() - 처리 전 권한처리");

		if (pageGradeNo != null) {
			HttpSession session = req.getSession();

			LoginVO vo = (LoginVO) session.getAttribute("login");

			if (vo == null) {
				res.sendRedirect("/error/error.do");
				return;
			}
			
			if(pageGradeNo == 1 && !(vo.getLogin_gradeNo() >= 1)) {
				res.sendRedirect("error/404.do");
			}
			
			if (pageGradeNo == 9 && vo.getLogin_gradeNo() != 9) {
				res.sendRedirect("/error/auth.do");
				return;
			}

		}
		
		chain.doFilter(request, response);

		System.out.println("AuthorityFilter.doFilter() - 처리 후 권한처리");

	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
		System.out.println("AuthorityFilter.init() - 권한 정보 세팅");


		// member
		authMap.put("/member/manageList.do", 9);
		authMap.put("/member/manageDelete.do", 9);
		authMap.put("/member/updateGrade.ck", 9);
		authMap.put("/member/manageDelete.ck", 9);
		
		authMap.put("/member/updatePw.do", 1);
		authMap.put("/member/logout.do", 1);
		authMap.put("/member/updateInfo.ck", 1);
		authMap.put("/member/updateStatus.do", 1);
		authMap.put("/member/viewInfo.do", 1);
		
		
		//회원 관리자
		authMap.put("/product/writeForm.do", 9);
		authMap.put("/product/write.do", 9);
		authMap.put("/product/updateForm.do", 9);
		authMap.put("/product/update.do", 9);
		authMap.put("/product/delete.do", 9);
		
		authMap.put("/category/writeForm.do", 9);
		authMap.put("/category/write.do", 9);
		authMap.put("/category/updateForm.do", 9);
		authMap.put("/category/update.do", 9);
		authMap.put("/category/delete.do", 9);
	}

}
