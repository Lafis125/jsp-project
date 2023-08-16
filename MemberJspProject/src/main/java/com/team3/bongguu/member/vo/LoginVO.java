package com.team3.bongguu.member.vo;

public class LoginVO {

	// 로그인....
	// id = 아이디
	// pw = 비밀번호
	// name = 이름
	// gradeno = 회원등급
	// gradeName = 회원등급이름

	private String login_id, login_pw, login_name, login_gradeName;
	private Long login_gradeNo;

	public String getLogin_id() {
		return login_id;
	}

	public void setLogin_id(String login_id) {
		this.login_id = login_id;
	}

	public String getLogin_pw() {
		return login_pw;
	}

	public void setLogin_pw(String login_pw) {
		this.login_pw = login_pw;
	}

	public String getLogin_name() {
		return login_name;
	}

	public void setLogin_name(String login_name) {
		this.login_name = login_name;
	}

	public String getLogin_gradeName() {
		return login_gradeName;
	}

	public void setLogin_gradeName(String login_gradeName) {
		this.login_gradeName = login_gradeName;
	}

	public Long getLogin_gradeNo() {
		return login_gradeNo;
	}

	public void setLogin_gradeNo(Long login_gradeNo) {
		this.login_gradeNo = login_gradeNo;
	}

	@Override
	public String toString() {
		return "LoginVO [login_id=" + login_id + ", login_pw=" + login_pw + ", login_name=" + login_name
				+ ", login_gradeName=" + login_gradeName + ", login_gradeNo=" + login_gradeNo + "]";
	}

}
