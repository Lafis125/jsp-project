package com.team3.bongguu.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.team3.bongguu.email.MailSend;
import com.team3.bongguu.main.Controller;
import com.team3.bongguu.main.Execute;
import com.team3.bongguu.main.Service;
import com.team3.bongguu.member.vo.LoginVO;
import com.team3.bongguu.member.vo.MemberVO;
import com.webjjang.util.PageObject;

public class MemberController implements Controller {

	// 회원삭제
	private Service MemberDeleteService;
	// 아이디 찾기
	private Service MemberFindIDService;
	// 임시비밀번호 이메일 발급
	private Service MemberFindEmailService;
	// 아이디 중복체크
	private Service MemberIDCheckService;
	// 회원 리스트
	private Service MemberListService;
	// 로그인 서비스
	private Service MemberLoginService;
	// 회원 가입
	private Service MemberSignUpService;
	// 회원 등급 변경
	private Service MemberUpdateGradeService;
	// 회원 정보 변경
	private Service MemberUpdateInFoService;
	// 회원 비밀 번호 변경
	private Service MemberUpdatePwService;
	// 회원 상태 탈퇴 변경
	private Service MemberUpdateStatusService;
	// 회원 내 정보 보기
	private Service MemberViewInFoService;
	// 회원 최근접속일 변경
	private Service MemberConDateUpdateService;
	// 임시비밀번호 발급 후 데이터베이스 변경
	private Service MemberTempPwUpdateService;

	public void setMemberTempPwUpdateService(Service memberTempPwUpdateService) {
		MemberTempPwUpdateService = memberTempPwUpdateService;
	}

	public void setMemberConDateUpdateService(Service memberConDateUpdateService) {
		MemberConDateUpdateService = memberConDateUpdateService;
	}

	public void setMemberDeleteService(Service memberDeleteService) {
		this.MemberDeleteService = memberDeleteService;
	}

	public void setMemberFindIDService(Service memberFindIDService) {
		this.MemberFindIDService = memberFindIDService;
	}

	public void setMemberFindEmailService(Service memberFindEmailService) {
		this.MemberFindEmailService = memberFindEmailService;
	}

	public void setMemberIDCheckService(Service memberIDCheckService) {
		this.MemberIDCheckService = memberIDCheckService;
	}

	public void setMemberListService(Service memberListService) {
		this.MemberListService = memberListService;
	}

	public void setMemberLoginService(Service memberLoginService) {
		this.MemberLoginService = memberLoginService;
	}

	public void setMemberSignUpService(Service memberSignUpService) {
		this.MemberSignUpService = memberSignUpService;
	}

	public void setMemberUpdateGradeService(Service memberUpdateGradeService) {
		this.MemberUpdateGradeService = memberUpdateGradeService;
	}

	public void setMemberUpdateInFoService(Service memberUpdateInFoService) {
		this.MemberUpdateInFoService = memberUpdateInFoService;
	}

	public void setMemberUpdatePwService(Service memberUpdatePwService) {
		this.MemberUpdatePwService = memberUpdatePwService;
	}

	public void setMemberUpdateStatusService(Service memberUpdateStatusService) {
		this.MemberUpdateStatusService = memberUpdateStatusService;
	}

	public void setMemberViewInFoService(Service memberViewInFoService) {
		this.MemberViewInFoService = memberViewInFoService;
	}

	@Override
	public String execute(HttpServletRequest request) throws Exception {

		String url = request.getServletPath();

		String jsp = null;

		HttpSession session = request.getSession();

		try {

			switch (url) {

			// 회원관리
			case "/member/agreeMent.do": // 약관동의
				System.out.println("Controller - AgreeMent");
				jsp = "/member/agreeMent";
				break;

			case "/member/signUp.do": // 회원가입
				System.out.println("Controller - SignUp");
				if (request.getMethod().equals("GET")) { // get 방식 - 로그인 폼
					System.out.println("signUp - Get 방식 : " + request.getMethod());
					jsp = "/member/signUp";

				} else if (request.getMethod().equals("POST")) { // post 방식 로그인

					System.out.println("signUp - Post 방식 : " + request.getMethod());

					MemberVO vo = new MemberVO();
					vo.setBG_MemberName(request.getParameter("userName")); //
					vo.setBG_MemberId(request.getParameter("userId")); //
					vo.setBG_MemberPw(request.getParameter("userPw")); //
					vo.setBG_MemberGender(request.getParameter("userGender"));
					vo.setBG_MemberBirth(request.getParameter("userBirth"));
					vo.setBG_MemberTel(request.getParameter("userTel")); //

					// 이메일
					String userEmail = request.getParameter("userEmail");

					String domain = request.getParameter("domain");
					String domain2 = request.getParameter("domain2");

					System.out.println("domain 확인 : " + domain);
					System.out.println("domain2 확인 : " + domain2);

					if (domain == null || domain.equals("type") || domain == "") {
						vo.setBG_MemberEmail(userEmail + "@" + domain2);
					} else {
						vo.setBG_MemberEmail(userEmail + "@" + domain);
					}

					// 주소
					String address = "";
					for (int i = 1; i < 6; i++) {
						if (i == 5 || request.getParameter("add" + i) != null) {
							address += request.getParameter("add" + i);
						} else if (request.getParameter("add" + i) != null) {
							address += request.getParameter("add" + i) + " ";
							System.out.println("check address - controller : " + address);
						}
					}
					System.out.println("signup - controller address : " + address);
					vo.setBG_MemberAddress(address);

					Integer result = (Integer) Execute.run(MemberSignUpService, vo);
					if (result == 1) {
						System.out.println("회원가입 완료");
						jsp = "redirect:/main/main.do";
					} else {
						System.out.println("회원 가입 실패");
						request.setAttribute("signup-msg", "회원가입에 실패했습니다.");
						jsp = "/member/signUp.do";
					}

				}

				break;

			case "/member/idCheck.ck": // 아이디체크
				System.out.println("Controller - CheckID");
				String idcheck = request.getParameter("idcheck");
				System.out.println("idCheck.do -> 아이디 체크 : " + idcheck);
				Integer result = (Integer) Execute.run(MemberIDCheckService, idcheck);
				System.out.println(result);
				if (result == 0) {
					System.out.println("사용 가능한 아이디");
					boolean check = true;
					request.setAttribute("check", check);
					System.out.println("controller - checkid true : " + request.getAttribute("check"));
				} else {
					System.out.println("중복된 아이디");
					System.out.println("controller - checkid false : " + request.getAttribute("check"));
				}

				jsp = "/member/idCheck";
				break;

			case "/member/viewInfo.do": // 회원 정보
				System.out.println("Controller - viewInfo");
				System.out.println("회원 정보 보기 아이디 : " + ((LoginVO) session.getAttribute("login")).getLogin_id());
				String viewid = ((LoginVO) session.getAttribute("login")).getLogin_id();
				request.setAttribute("viewInfo", Execute.run(MemberViewInFoService, viewid));
				jsp = "/member/viewInfo";
				break;

			case "/member/updateInfo.ck": // 회원 정보 //수정

				if (request.getMethod().equals("POST")) { // post 방식 - 회원 정보 변경
					String id = ((LoginVO) session.getAttribute("login")).getLogin_id();
					System.out.println("update Info id : " + id);

					String pw = request.getParameter("userPw");
					System.out.println("update Info pw : " + pw);

					String birth = request.getParameter("userBirth");
					System.out.println("update Info birth : " + birth);

					String email = request.getParameter("userEmail");
					System.out.println("update Info email : " + email);

					String tel = request.getParameter("userTel");
					System.out.println("update Info tel : " + tel);

					String address = request.getParameter("userAdd");
					System.out.println("update Info add : " + address);

					MemberVO vo = new MemberVO();
					vo.setBG_MemberId(id);
					vo.setBG_MemberPw(pw);
					vo.setBG_MemberBirth(birth);
					vo.setBG_MemberEmail(email);
					vo.setBG_MemberTel(tel);
					vo.setBG_MemberAddress(address);

					result = (Integer) Execute.run(MemberUpdateInFoService, vo);

					jsp = "/member/updateInfo";
					if (result == 0) {
						System.out.println("회원 정보 변경 실패");
						request.setAttribute("updateinfo-msg", "비밀번호가 일치 하지 않습니다. 다시 시도 해주세요");
					} else {
						System.out.println("회원 정보 변경 완료");
						request.setAttribute("updateinfo-msg", "회원정보가 변경되었습니다. 확인 버튼을 클릭해주세요.");
					}
				}
				break;

			// 회원 상태 변경
			case "/member/updateStatus.do":
				if (request.getMethod().equals("POST")) {
					System.out.println("Controller - updateStatus Post");
					String id = ((LoginVO) session.getAttribute("login")).getLogin_id();
					String pw = request.getParameter("deletepw");
					System.out.println("update - status id : " + id);
					System.out.println("update - status pw : " + pw);

					MemberVO statusVO = new MemberVO();
					statusVO.setBG_MemberId(id);
					statusVO.setBG_MemberPw(pw);

					result = (Integer) Execute.run(MemberUpdateStatusService, statusVO);
					if (result == 0) {
						System.out.println("회원 상태 변경 실패");
						request.setAttribute("updateStatus", "비밀번호가 맞지 않습니다.");
						request.setAttribute("viewInfo", Execute.run(MemberViewInFoService, id));
						jsp = "/member/viewInfo";
					} else {
						System.out.println("회원 상태 변경 완료");
						session.removeAttribute("login");
						jsp = "redirect:/main/main.do";
					}
				}
				break;
			case "/member/updatePw.do":
				if (request.getMethod().equals("POST")) {
					System.out.println("Controller - updatePw Post");
					String id = ((LoginVO) session.getAttribute("login")).getLogin_id();
					String pw = request.getParameter("currentpw");
					String newPw = request.getParameter("changepw");
					MemberVO vo = new MemberVO();
					vo.setPw1(newPw);
					vo.setBG_MemberPw(pw);
					vo.setBG_MemberId(id);

					result = (Integer) Execute.run(MemberUpdatePwService, vo);
					if (result == 0) {
						request.setAttribute("chagePw", "비밀번호가 일치하지 않습니다. 다시 시도 해주세요.");
						System.out.println("updatePW - Controller 비밀번호 변경 실패");
						jsp = "/member/viewInfo";
					} else {
						session.removeAttribute("login");
						System.out.println("updatePW - Controller 비밀번호 변경 완료");
						jsp = "redirect:/main/main.do";
					}
				}
				break;

			// 관리자 == > 내일
			case "/member/manageList.do": // 회원리스트

				if (session.getAttribute("login") != null) {
					System.out.println("Controller - member 리스트");
					String strPage = request.getParameter("page");
					Long page = (strPage == null || strPage.equals("")) ? 1 : Long.parseLong(strPage);
					String strPerPageNum = request.getParameter("perPageNum");
					Long perPageNum = (strPerPageNum == null || strPerPageNum.equals("")) ? 10
							: Long.parseLong(strPerPageNum);

					String key = request.getParameter("key");
					String word = request.getParameter("word");

					PageObject pageObject = new PageObject(page, perPageNum);
					pageObject.setKey(key);
					pageObject.setWord(word);

					request.setAttribute("list", Execute.run(MemberListService, pageObject));
					request.setAttribute("pageObject", pageObject);
					jsp = "/member/manageList";
				} else {
					jsp = "redirect:/main/main.do";
				}
				break;

			case "/member/manageDelete.ck": // 회원 삭제
				System.out.println("Controller - manageDelete");
				String deleteid = request.getParameter("userId");
				System.out.println("Controller - deleteID : " + deleteid);
				result = (Integer) Execute.run(MemberDeleteService, deleteid);
				if (result != 0) {
					System.out.println("Controller  - 회원 삭제 완료");
					request.setAttribute("manageDelete", "삭제된 아이디는 : [" + deleteid + "] 입니다. ");
				} else {
					System.out.println("Controller - 회원 삭제 실패");
					request.setAttribute("manageDelete", "회원 삭제를 실패 했습니다. 다시 시도 해주세요.");
				}
				jsp = "/member/manageDelete";
				break;

			case "/member/updateGrade.ck": // 회원 등급 변경
				System.out.println("Controller - updateGrade");
				String updateid = request.getParameter("userId");
				System.out.println("update Grade - updateID : " + updateid);
				String updategradeNo = request.getParameter("userGradeNo");
				System.out.println("update Grade - updategradeNo : " + updategradeNo);
				Long gradeNo = Long.parseLong(updategradeNo);
				MemberVO updatevo = new MemberVO();
				updatevo.setBG_MemberId(updateid);
				updatevo.setBG_GradeNo(gradeNo);

				result = (Integer) Execute.run(MemberUpdateGradeService, updatevo);
				if (result != 0) {
					System.out.println("Controller - result : 회원등급 변경 : " + result);
					request.setAttribute("updateGrade", "회원등급 : [" + gradeNo + "] 입니다.");
				} else {
					System.out.println("Controller - result : 회원등급 변경 : " + result);
					request.setAttribute("updateGrade", "회원등급 변경을 실패 했습니다.");
				}
				jsp = "/member/updateGrade";

				break;

			// 로그인 관련
			case "/member/login.do": // 로그인
				System.out.println("Controller - login");
				System.out.println("getMethod() - " + request.getMethod());
				if (request.getMethod().equals("GET")) { // get 방식 - 로그인 폼
					System.out.println("Controller Get 방식 - 로그인 페이지 이동");
					jsp = "/member/login";

				} else if (request.getMethod().equals("POST")) {
					System.out.println("Controller Post 방식 - 로그인");
					String id = request.getParameter("id");
					String pw = request.getParameter("pw");
					LoginVO vo = new LoginVO();
					vo.setLogin_id(id);
					vo.setLogin_pw(pw);

					session.setAttribute("login", Execute.run(MemberLoginService, vo));
					if (session.getAttribute("login") == null) {
						System.out.println("로그인 실패");
						request.setAttribute("loginmsg", "fail");
						jsp = "/member/login";
					} else {
						result = (Integer) Execute.run(MemberConDateUpdateService, id);
						if (result != 0) {
							System.out.println("Controller -최근 접속일 변경 완료");
						} else {
							System.out.println("Controller -최근 접속일 변경 실패");
						}
						System.out.println("로그인 성공");
						jsp = "redirect:/main/main.do";
					}
				}

				break;

			case "/member/logout.do": // 로그아웃

				System.out.println("Controller - logout");
				session.removeAttribute("login");
				session.setAttribute("msg", "로그아웃 되었습니다.");
				jsp = "redirect:/main/main.do";
				System.out.println("로그아웃 하셨습니다.");
				break;

			case "/member/findId.ck": // 아이디 찾기
				System.out.println("Controller - Find ID");
				String name = request.getParameter("userName");
				System.out.println("username : " + name);

				String birth = request.getParameter("userBirth");
				System.out.println("userbirth : " + birth);
				String tel = request.getParameter("userTel");
				System.out.println("usertel : " + tel);

				MemberVO vo = new MemberVO();
				vo.setBG_MemberName(name);
				vo.setBG_MemberBirth(birth);
				vo.setBG_MemberTel(tel);

				String id = (String) Execute.run(MemberFindIDService, vo);
				if (id != null) {
					System.out.println("아이디 찾기 성공");
					request.setAttribute("findid", "아이디 : [" + id + "] 입니다.");
				} else {
					System.out.println("찾는 아이디가 없습니다.");
					request.setAttribute("findid", "잘못된 입력이거나 회원 정보가 없습니다.");
				}

				jsp = "/member/findId";
				break;

			case "/member/findPw.ck": // 비밀번호 찾기 > 이메일 추가 수정예정
				System.out.println("Controller - findPW");
				name = request.getParameter("userName");
				birth = request.getParameter("userBirth");
				id = request.getParameter("userId");
				tel = request.getParameter("userTel");
				System.out.println("name : " + name + "\nbirth : " + birth + "\nid : " + id + "\ntel : " + tel);
				vo = new MemberVO();
				vo.setBG_MemberName(name);
				vo.setBG_MemberBirth(birth);
				vo.setBG_MemberId(id);
				vo.setBG_MemberTel(tel);
				String SendEmail = (String) Execute.run(MemberFindEmailService, vo);
				System.out.println("SendEmail 이메일 확인 : " + SendEmail);
				if (SendEmail != null) {
					char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd',
							'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
							'w', 'x', 'y', 'z' };

					String TempPw = "";

					// 문자 배열 길이의 값을 랜덤으로 10개를 뽑아 구문을 작성함
					int idx = 0;
					for (int i = 0; i < 10; i++) {
						idx = (int) (charSet.length * Math.random());
						TempPw += charSet[idx];
					}
					System.out.println("new 새로운 임시빌번호 확인 : " + TempPw);
					MailSend ms = new MailSend();
					String emailcheck = ms.MailSends(SendEmail, TempPw);
					System.out.println("이메일 전송 확인 : " + emailcheck);

					vo = new MemberVO();
					vo.setBG_MemberId(id);
					vo.setBG_MemberPw(TempPw);

					result = (Integer) Execute.run(MemberTempPwUpdateService, vo);

					jsp = "/member/findPw";

					if (result == 0) {
						System.out.println("임시 비밀번호 변경 실패");
						request.setAttribute("newpw", "임시 비밀번호 발급 후 수정이 안되었습니다.");
					} else {
						System.out.println("임시 비밀번호 변경 완료");
						request.setAttribute("newpw", "임시 비밀번호 발급이 완료 되었습니다.");
					}

				} else {
					jsp = "/member/findPw";
					request.setAttribute("newpw", "정확한 정보를 입력해주세요");
					System.out.println("확인용 pw");
				}

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
