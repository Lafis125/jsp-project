package com.team3.bongguu.member.vo;

public class MemberVO {

	private String BG_MemberId, BG_MemberPw, BG_MemberName;
	private String BG_MemberGender, BG_MemberBirth, BG_MemberTel;
	private String BG_MemberEmail, BG_MemberStatus, BG_MemberRegDate;
	private String BG_MemberConDate, BG_GradeName, BG_MemberAddress;

	// 비밀번호 변경시에
	private String pw1;
	private Long BG_GradeNo;

	public String getPw1() {
		return pw1;
	}

	public void setPw1(String pw1) {
		this.pw1 = pw1;
	}

	public String getBG_MemberId() {
		return BG_MemberId;
	}

	public void setBG_MemberId(String bG_MemberId) {
		BG_MemberId = bG_MemberId;
	}

	public String getBG_MemberPw() {
		return BG_MemberPw;
	}

	public void setBG_MemberPw(String bG_MemberPw) {
		BG_MemberPw = bG_MemberPw;
	}

	public String getBG_MemberName() {
		return BG_MemberName;
	}

	public void setBG_MemberName(String bG_MemberName) {
		BG_MemberName = bG_MemberName;
	}

	public String getBG_MemberGender() {
		return BG_MemberGender;
	}

	public void setBG_MemberGender(String bG_MemberGender) {
		BG_MemberGender = bG_MemberGender;
	}

	public String getBG_MemberBirth() {
		return BG_MemberBirth;
	}

	public void setBG_MemberBirth(String bG_MemberBirth) {
		BG_MemberBirth = bG_MemberBirth;
	}

	public String getBG_MemberTel() {
		return BG_MemberTel;
	}

	public void setBG_MemberTel(String bG_MemberTel) {
		BG_MemberTel = bG_MemberTel;
	}

	public String getBG_MemberEmail() {
		return BG_MemberEmail;
	}

	public void setBG_MemberEmail(String bG_MemberEmail) {
		BG_MemberEmail = bG_MemberEmail;
	}

	public String getBG_MemberStatus() {
		return BG_MemberStatus;
	}

	public void setBG_MemberStatus(String bG_MemberStatus) {
		BG_MemberStatus = bG_MemberStatus;
	}

	public String getBG_MemberRegDate() {
		return BG_MemberRegDate;
	}

	public void setBG_MemberRegDate(String bG_MemberRegDate) {
		BG_MemberRegDate = bG_MemberRegDate;
	}

	public String getBG_MemberConDate() {
		return BG_MemberConDate;
	}

	public void setBG_MemberConDate(String bG_MemberConDate) {
		BG_MemberConDate = bG_MemberConDate;
	}

	public String getBG_GradeName() {
		return BG_GradeName;
	}

	public void setBG_GradeName(String bG_GradeName) {
		BG_GradeName = bG_GradeName;
	}

	public Long getBG_GradeNo() {
		return BG_GradeNo;
	}

	public void setBG_GradeNo(Long bG_GradeNo) {
		BG_GradeNo = bG_GradeNo;
	}

	public String getBG_MemberAddress() {
		return BG_MemberAddress;
	}

	public void setBG_MemberAddress(String bG_MemberAddress) {
		BG_MemberAddress = bG_MemberAddress;
	}

	@Override
	public String toString() {
		return "MemberVO [BG_MemberId=" + BG_MemberId + ", BG_MemberPw=" + BG_MemberPw + ", BG_MemberName="
				+ BG_MemberName + ", BG_MemberGender=" + BG_MemberGender + ", BG_MemberBirth=" + BG_MemberBirth
				+ ", BG_MemberTel=" + BG_MemberTel + ", BG_MemberEmail=" + BG_MemberEmail + ", BG_MemberStatus="
				+ BG_MemberStatus + ", BG_MemberRegDate=" + BG_MemberRegDate + ", BG_MemberConDate=" + BG_MemberConDate
				+ ", BG_GradeName=" + BG_GradeName + ", BG_MemberAddress=" + BG_MemberAddress + ", pw1=" + pw1
				+ ", BG_GradeNo=" + BG_GradeNo + "]";
	}

}