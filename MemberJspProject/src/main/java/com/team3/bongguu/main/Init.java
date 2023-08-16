package com.team3.bongguu.main;

import java.util.HashMap;
import java.util.Map;

import com.team3.bongguu.error.controller.ErrorController;
import com.team3.bongguu.main.controller.MainController;
import com.team3.bongguu.member.controller.MemberController;
import com.team3.bongguu.member.dao.MemberDAOImpl;
import com.team3.bongguu.member.service.MemberCondateUpdateServiceImpl;
import com.team3.bongguu.member.service.MemberDeleteServiceImpl;
import com.team3.bongguu.member.service.MemberFindIDServiceImpl;
import com.team3.bongguu.member.service.MemberFindEmailServiceImpl;
import com.team3.bongguu.member.service.MemberIDCheckServiceImpl;
import com.team3.bongguu.member.service.MemberListServiceImpl;
import com.team3.bongguu.member.service.MemberLoginServiceImpl;
import com.team3.bongguu.member.service.MemberSignUpServiceImpl;
import com.team3.bongguu.member.service.MemberTempPwUpdateServiceImpl;
import com.team3.bongguu.member.service.MemberUpdateGradeServiceImpl;
import com.team3.bongguu.member.service.MemberUpdateInFoServiceImpl;
import com.team3.bongguu.member.service.MemberUpdatePwServiceImpl;
import com.team3.bongguu.member.service.MemberUpdateStatusServiceImpl;
import com.team3.bongguu.member.service.MemberViewInFoServiceImpl;

public class Init {

	private static Map<String, Object> controllerMap = new HashMap<>();
	private static Map<String, Service> serviceMap = new HashMap<>();
	private static Map<String, Object> daoMap = new HashMap<>();

	public static void init() {

		// main
		// controller
		controllerMap.put("MainController", new MainController());

		// service > dao
		serviceMap.get("MainListServiceImpl").setDao(daoMap.get("MainListDAO"));

		// member
		// member controller
		controllerMap.put("MemberController", new MemberController());

		// member service

		serviceMap.put("MemberDeleteServiceImpl", new MemberDeleteServiceImpl()); // 회원삭제
		serviceMap.put("MemberFindIDServiceImpl", new MemberFindIDServiceImpl()); // 아이디 찾기

		serviceMap.put("MemberFindEmailServiceImpl", new MemberFindEmailServiceImpl()); // 임시비밀번호 전송 이메일 확인
		serviceMap.put("MemberIDCheckServiceImpl", new MemberIDCheckServiceImpl()); // 아이디 중복 체크

		serviceMap.put("MemberListServiceImpl", new MemberListServiceImpl()); // 회원 리스트
		serviceMap.put("MemberLoginServiceImpl", new MemberLoginServiceImpl()); // 로그인 서비스

		serviceMap.put("MemberSignUpServiceImpl", new MemberSignUpServiceImpl()); // 회원 가입
		serviceMap.put("MemberUpdateGradeServiceImpl", new MemberUpdateGradeServiceImpl()); // 회원 등급 변경

		serviceMap.put("MemberUpdateInFoServiceImpl", new MemberUpdateInFoServiceImpl()); // 회원 정보 변경
		serviceMap.put("MemberUpdatePwServiceImpl", new MemberUpdatePwServiceImpl()); // 회원 비밀번호 변경

		serviceMap.put("MemberUpdateStatusServiceImpl", new MemberUpdateStatusServiceImpl()); // 회원 상태 탈퇴 변경
		serviceMap.put("MemberViewInFoServiceImpl", new MemberViewInFoServiceImpl()); // 회원 정보 보기

		serviceMap.put("MemberConDateUpdateServiceImpl", new MemberCondateUpdateServiceImpl()); // 로그인시 최근 접속일 변경
		serviceMap.put("MemberTempPwUpdateServiceImpl", new MemberTempPwUpdateServiceImpl());

		// member dao
		daoMap.put("MemberDAO", new MemberDAOImpl());

		// member controller - service
		((MemberController) controllerMap.get("MemberController"))
				.setMemberDeleteService(serviceMap.get("MemberDeleteServiceImpl"));
		((MemberController) controllerMap.get("MemberController"))
				.setMemberFindIDService(serviceMap.get("MemberFindIDServiceImpl"));

		((MemberController) controllerMap.get("MemberController"))
				.setMemberFindEmailService(serviceMap.get("MemberFindEmailServiceImpl"));
		((MemberController) controllerMap.get("MemberController"))
				.setMemberIDCheckService(serviceMap.get("MemberIDCheckServiceImpl"));

		((MemberController) controllerMap.get("MemberController"))
				.setMemberListService(serviceMap.get("MemberListServiceImpl"));
		((MemberController) controllerMap.get("MemberController"))
				.setMemberLoginService(serviceMap.get("MemberLoginServiceImpl"));

		((MemberController) controllerMap.get("MemberController"))
				.setMemberSignUpService(serviceMap.get("MemberSignUpServiceImpl"));
		((MemberController) controllerMap.get("MemberController"))
				.setMemberUpdateGradeService(serviceMap.get("MemberUpdateGradeServiceImpl"));

		((MemberController) controllerMap.get("MemberController"))
				.setMemberUpdateInFoService(serviceMap.get("MemberUpdateInFoServiceImpl"));
		((MemberController) controllerMap.get("MemberController"))
				.setMemberUpdatePwService(serviceMap.get("MemberUpdatePwServiceImpl"));

		((MemberController) controllerMap.get("MemberController"))
				.setMemberUpdateStatusService(serviceMap.get("MemberUpdateStatusServiceImpl"));
		((MemberController) controllerMap.get("MemberController"))
				.setMemberViewInFoService(serviceMap.get("MemberViewInFoServiceImpl"));

		((MemberController) controllerMap.get("MemberController"))
				.setMemberConDateUpdateService(serviceMap.get("MemberConDateUpdateServiceImpl"));
		((MemberController) controllerMap.get("MemberController"))
				.setMemberTempPwUpdateService(serviceMap.get("MemberTempPwUpdateServiceImpl"));

		// memebr service - dao
		serviceMap.get("MemberDeleteServiceImpl").setDao(daoMap.get("MemberDAO"));
		serviceMap.get("MemberFindIDServiceImpl").setDao(daoMap.get("MemberDAO"));

		serviceMap.get("MemberFindEmailServiceImpl").setDao(daoMap.get("MemberDAO"));
		serviceMap.get("MemberIDCheckServiceImpl").setDao(daoMap.get("MemberDAO"));

		serviceMap.get("MemberListServiceImpl").setDao(daoMap.get("MemberDAO"));
		serviceMap.get("MemberLoginServiceImpl").setDao(daoMap.get("MemberDAO"));

		serviceMap.get("MemberSignUpServiceImpl").setDao(daoMap.get("MemberDAO"));
		serviceMap.get("MemberUpdateGradeServiceImpl").setDao(daoMap.get("MemberDAO"));

		serviceMap.get("MemberUpdateInFoServiceImpl").setDao(daoMap.get("MemberDAO"));
		serviceMap.get("MemberUpdatePwServiceImpl").setDao(daoMap.get("MemberDAO"));

		serviceMap.get("MemberUpdateStatusServiceImpl").setDao(daoMap.get("MemberDAO"));
		serviceMap.get("MemberViewInFoServiceImpl").setDao(daoMap.get("MemberDAO"));

		serviceMap.get("MemberConDateUpdateServiceImpl").setDao(daoMap.get("MemberDAO"));
		serviceMap.get("MemberTempPwUpdateServiceImpl").setDao(daoMap.get("MemberDAO"));

		// error controller
		controllerMap.put("ErrorController", new ErrorController());

	}

	public static Object getController(String key) {
		return controllerMap.get(key);
	}
}
