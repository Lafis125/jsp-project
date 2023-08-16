package com.team3.bongguu.member.dao;

import java.util.List;

import com.team3.bongguu.member.vo.LoginVO;
import com.team3.bongguu.member.vo.MemberVO;
import com.webjjang.util.PageObject;

public interface MemberDAO {

	// 관리자 --------------------------------------------------------------

	// 회원리스트 (관리자)
	public List<MemberVO> listMember(PageObject pageobj) throws Exception;

	// 전체 회원 수 (관리자)
	public long getTotalRow(PageObject pageObject) throws Exception;

	// 회원 등급 변경 (관리자)
	public Integer updateGrade(MemberVO vo) throws Exception;

	// 회원 정보 삭제 (관리자)
	public Integer deleteMember(String id) throws Exception;

	// 회원 ----------------------------------------------------------------

	// 회원 가입
	public Integer signup(MemberVO vo) throws Exception;

	// 회원 가입 -- 아이디 중복 체크
	public Integer IdCheck(String id) throws Exception;

	// 내 정보 보기
	public MemberVO viewInfo(String id) throws Exception;

	// 내 정보 수정 (비밀번호 제외)
	public Integer updateInfo(MemberVO vo) throws Exception;

	// 비밀번호 변경 (비밀번호 제한)
	public Integer updatepw(MemberVO vo) throws Exception;

	// 회원 탈퇴
	public Integer updateStatus(MemberVO vo) throws Exception;

	// 로그인 ---------------------------------------------------------------

	// 로그인
	public LoginVO login(LoginVO vo) throws Exception;

	// 아이디 찾기
	public String findid(MemberVO vo) throws Exception;

	// 임시 비밀번호 발급용 이메일
	public String findemail(MemberVO vo) throws Exception;

	// 임시비밀번호로 변경
	public Integer temppw(MemberVO vo) throws Exception;
	
	// 최근접속일 변경
	public Integer conDateupdate(String id)throws Exception;
	
	
}
