package com.team3.bongguu.member.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.team3.bongguu.member.vo.LoginVO;
import com.team3.bongguu.member.vo.MemberVO;
import com.team3.bongguu.util.db.DB;
import com.webjjang.util.PageObject;

public class MemberDAOImpl implements MemberDAO {

	private Connection con;
	private PreparedStatement ps;
	private ResultSet rs;

	// 관리자 --------------------------------------------
	@Override // 회원 리스트 (관리자)
	public List<MemberVO> listMember(PageObject pageobj) throws Exception {
		List<MemberVO> list = null;
		try {
			con = DB.getConnection();
			System.out.println("List Connection : " + con);

			String sql = " select m.Member_id , m.Member_name , m.Member_gender , m.Member_birth ,  "
					+ " m.Member_tel , m.Member_status , m.Member_regDate , m.Member_ConDate , g.Grade_No , "
					+ " g.Grade_name from BG_Member m, BG_Grade g where ";

			sql += searchSQL(pageobj);
			System.out.println("List pageobj 메서드 : " + sql);

			sql += " (g.grade_No = m.grade_No) " + " order by Member_id desc ";

			sql = " select rownum rnum, Member_id , Member_name , "
					+ " Member_gender , Member_birth , Member_tel , Member_status , "
					+ " Member_regDate , Member_ConDate , Grade_No , Grade_name " + " from( " + sql + " ) ";

			sql = " select Member_id id, Member_name name, Member_gender gender, "
					+ " member_birth birth, Member_tel tel, Member_status status, "
					+ " to_char(Member_regDate,'yyyy-mm-dd') regDate, "
					+ " to_char(Member_ConDate,'yyyy-mm-dd') conDate, " + " Grade_No gradeNo, Grade_name gradeName "
					+ " from ( " + sql + " ) where rnum between ? and ? ";

			System.out.println("List sql 문장 : " + sql);

			ps = con.prepareStatement(sql);

			System.out.println("List PreparedStatement : " + ps);
			int idx = 1;
			idx = searchDataSet(pageobj, idx);
			System.out.println("List searchDataSet 메서드 인덱스 : " + idx);

			ps.setLong(idx, pageobj.getStartRow());
			ps.setLong(++idx, pageobj.getEndRow());

			rs = ps.executeQuery();
			System.out.println("List ResultSet : " + rs);
			if (rs != null) {
				if (list == null)
					list = new ArrayList<>();
				while (rs.next()) {
					MemberVO vo = new MemberVO();
					vo.setBG_MemberId(rs.getString("id"));
					vo.setBG_MemberName(rs.getString("name"));
					vo.setBG_MemberGender(rs.getString("gender"));
					vo.setBG_MemberBirth(rs.getString("birth"));
					vo.setBG_MemberTel(rs.getString("tel"));
					vo.setBG_MemberStatus(rs.getString("status"));
					vo.setBG_MemberRegDate(rs.getString("regDate"));
					vo.setBG_MemberConDate(rs.getString("conDate"));
					vo.setBG_GradeNo(rs.getLong("gradeNo"));
					vo.setBG_GradeName(rs.getString("gradeName"));
					list.add(vo);
				}
			} else {
				System.out.println("List 불러오기 실패");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.close(con, ps, rs);
		}
		return list;
	}

	// 페이지 처리를 위한 메서드
	private String searchSQL(PageObject pageObject) {

		System.out.println("searchSQL 메서드 불어오기 완료");
		String sql = "";
		String word = pageObject.getWord();
		String key = pageObject.getKey();

		if (word != null && !(word.equals(""))) {

			sql += " (1=0 ";

			if (key.indexOf("i") >= 0)
				sql += " or m.Member_id like ? ";
			if (key.indexOf("r") >= 0)
				sql += " or m.Member_regDate like ? ";
			if (key.indexOf("c") >= 0)
				sql += " or m.Member_conDate like ? ";
			if (key.indexOf("s") >= 0)
				sql += " or m.Member_status like ? ";
			sql += " ) and ";
		}
		return sql;
	}

	// 검색을 위한 데이터 세팅
	private int searchDataSet(PageObject pageObject, int idx) throws SQLException {

		System.out.println("searchDataSet 메서드 불어오기 완료");
		String word = pageObject.getWord();
		String key = pageObject.getKey();

		if (word != null && !(word.equals(""))) {

			if (key.indexOf("i") >= 0)
				ps.setString(idx++, "%" + word + "%");
			if (key.indexOf("r") >= 0)
				ps.setString(idx++, "%" + word + "%");
			if (key.indexOf("c") >= 0)
				ps.setString(idx++, "%" + word + "%");
			if (key.indexOf("s") >= 0)
				ps.setString(idx++, "%" + word + "%");
		}
		return idx;
	}

	@Override // 회원 총 수 (관리자)
	public long getTotalRow(PageObject pageObject) throws Exception {
		long totalRow = 0;

		try {

			con = DB.getConnection();
			System.out.println("getTotalRow Connection : " + con);
			String sql = " select count(*) from BG_Member ";

			sql += searchSQL(pageObject);

			System.out.println(" getTotalRow sql 문장 : " + sql);

			ps = con.prepareStatement(sql);
			searchDataSet(pageObject, 1);
			System.out.println("getTotalRow PreparedStatement : " + ps);

			rs = ps.executeQuery();
			System.out.println("getTotalRow Resultset : " + rs);

			if (rs != null | rs.next()) {

				totalRow = rs.getLong(1);

			} else {
				System.out.println("회원 총 불러오기 실패");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.close(con, ps, rs);
		}
		return totalRow;
	}

	@Override // 회원 등급 변경 (관리자)
	public Integer updateGrade(MemberVO vo) throws Exception {
		Integer result = 0;
		try {
			con = DB.getConnection();
			System.out.println("updateGrade Connection : " + con);
			String sql = "update BG_Member set grade_No=? where Member_id=? ";

			ps = con.prepareStatement(sql);
			System.out.println("updateGrade PreparedStatMent : " + ps);

			ps.setLong(1, vo.getBG_GradeNo());
			ps.setString(2, vo.getBG_MemberId());

			result = ps.executeUpdate();
			if (result == 0) {
				System.out.println("updateGrade result : " + result);
				System.out.println("등급 변경 실패");
			} else {
				System.out.println("등급 변경 완료");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.close(con, ps);
		}
		return result;
	}

	@Override // 회원 정보 삭제 (관리자)
	public Integer deleteMember(String id) throws Exception {
		Integer result = 0;
		try {
			con = DB.getConnection();
			System.out.println("deleteMember Connection : " + con);

			String sql = "delete from BG_Member where Member_id = ? ";
			System.out.println("deleteMember sql 문장 : " + sql);

			ps = con.prepareStatement(sql);
			System.out.println("deleteMember PreparedStateMent : " + ps);
			ps.setString(1, id);

			result = ps.executeUpdate();
			System.out.println("deleteMember result : " + result);

			if (result == 0) {
				System.out.println("회원 삭제 실패");
			} else {
				System.out.println("회원 삭제 완료");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.close(con, ps);
		}
		return result;
	}

	// 회원 ---------------------------------------------
	@Override // 회원가입
	public Integer signup(MemberVO vo) throws Exception {
		Integer result = 0;
		try {
			con = DB.getConnection();
			System.out.println("signup Connection : " + con);

			String sql = "insert into BG_Member( Member_id , Member_pw , Member_name, Member_gender, "
					+ " Member_birth, Member_tel, Member_email, Member_address )"
					+ " values( ? , ? , ? , ? , ? , ? , ? , ? ) ";
			System.out.println("signup sql 문장 : " + sql);

			ps = con.prepareStatement(sql);
			System.out.println("signup PreparedStateMent : " + ps);
			ps.setString(1, vo.getBG_MemberId());
			ps.setString(2, vo.getBG_MemberPw());
			ps.setString(3, vo.getBG_MemberName());
			ps.setString(4, vo.getBG_MemberGender());
			ps.setString(5, vo.getBG_MemberBirth());
			ps.setString(6, vo.getBG_MemberTel());
			ps.setString(7, vo.getBG_MemberEmail());
			ps.setString(8, vo.getBG_MemberAddress());

			result = ps.executeUpdate();
			System.out.println("signup result : " + result);

			if (result == 0) {
				System.out.println("회원가입 실패");
			} else {
				System.out.println("회원가입 완료");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.close(con, ps);
		}
		return result;
	}

	@Override
	public Integer IdCheck(String id) throws Exception {
		Integer result = 0;

		try {
			con = DB.getConnection();
			System.out.println("IDCheck Connection : " + con);

			String sql = "select Member_id from BG_member where Member_id = ? ";
			System.out.println("IDCheck sql 문장 : " + sql);

			ps = con.prepareStatement(sql);
			System.out.println("IDCheck PreparedStateMent : " + ps);
			ps.setString(1, id);

			rs = ps.executeQuery();
			System.out.println("IDCheck Resultset : " + rs);

			if (rs != null && rs.next()) {
				System.out.println("중복된 아이디가 있습니다");
				result = 1;
			} else {
				System.out.println("중복된 아이디가 없습니다.");
				result = 0;
			}

		} catch (Exception e) {

		} finally {
			DB.close(con, ps, rs);
		}

		return result;
	}

	@Override // 내정보 보기
	public MemberVO viewInfo(String id) throws Exception {
		MemberVO vo = null;
		try {
			con = DB.getConnection();
			System.out.println("ViewInfo Connection : " + con);

			String sql = "select Member_id id, Member_name name, Member_gender gender, "
					+ " to_char(Member_birth ,'yyyy-mm-dd') birth, Member_tel tel,"
					+ " to_char(Member_regDate,'yyyy-mm-dd') regDate, Member_email email, "
					+ " to_char(Member_ConDate,'yyyy-mm-dd') conDate, Member_Address address "
					+ " from BG_Member where Member_id = ?  ";
			System.out.println("ViewInfo sql 문장 : " + sql);

			ps = con.prepareStatement(sql);
			System.out.println("ViewInfo PreparedStateMent : " + ps);
			ps.setString(1, id);

			rs = ps.executeQuery();
			System.out.println("ViewInfo Resultset : " + rs);

			if (rs != null && rs.next()) {
				if (vo == null)
					vo = new MemberVO();
				String address = rs.getString("address");
				System.out.println("address : " + address);

				if (address.contains("/")) {
					String[] splitadd = address.split("/");
					System.out.println("splitadd : " + splitadd);
					String Alladdress = "";
					for (String add : splitadd) {
						Alladdress += add;
					}
					System.out.println("Alladdress 확인 : " + Alladdress);
					vo.setBG_MemberAddress(Alladdress);
				} else {
					vo.setBG_MemberAddress(address);
				}
				vo.setBG_MemberId(rs.getString("id"));
				vo.setBG_MemberName(rs.getString("name"));
				vo.setBG_MemberGender(rs.getString("gender"));
				vo.setBG_MemberBirth(rs.getString("birth"));
				vo.setBG_MemberTel(rs.getString("tel"));
				vo.setBG_MemberRegDate(rs.getString("regDate"));
				vo.setBG_MemberConDate(rs.getString("conDate"));
				vo.setBG_MemberEmail(rs.getString("email"));
			} else {
				System.out.println("회원 정보 불러오기 실패");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.close(con, ps, rs);
		}
		return vo;
	}

	@Override // 내정보 수정 (비밀번호 제외)
	public Integer updateInfo(MemberVO vo) throws Exception {
		Integer result = 0;
		try {
			con = DB.getConnection();
			System.out.println("UpdateInfo Connection : " + con);

			String sql = "update BG_Member set Member_tel = ? , Member_email = ? ,"
					+ " Member_address = ?, Member_birth = ? where Member_id = ? and Member_pw = ? ";
			System.out.println("UpdateInfo sql 문장 : " + sql);

			ps = con.prepareStatement(sql);
			System.out.println("UpdateInfo PreparedStateMent : " + ps);
			ps.setString(1, vo.getBG_MemberTel());
			ps.setString(2, vo.getBG_MemberEmail());
			ps.setString(3, vo.getBG_MemberAddress());
			ps.setString(4, vo.getBG_MemberBirth());
			ps.setString(5, vo.getBG_MemberId());
			ps.setString(6, vo.getBG_MemberPw());

			result = ps.executeUpdate();
			System.out.println("UpdateInfo Result : " + result);

			if (result == 0) {
				System.out.println("회원 정보 수정 실패");
			} else {
				System.out.println("회원 정보 수정 완료");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.close(con, ps);
		}
		return result;
	}

	@Override // 비밀번호 변경
	public Integer updatepw(MemberVO vo) throws Exception {
		Integer result = 0;
		try {
			con = DB.getConnection();
			System.out.println("UpdatePw Connection : " + con);

			String sql = "update BG_Member set Member_pw = ? where Member_id = ? and Member_pw = ? ";
			System.out.println("UpdatePw Sql 문장 : " + sql);

			ps = con.prepareStatement(sql);
			System.out.println("UpdatePw PreparedStateMent : " + ps);
			ps.setString(1, vo.getPw1());
			ps.setString(2, vo.getBG_MemberId());
			ps.setString(3, vo.getBG_MemberPw());

			result = ps.executeUpdate();
			System.out.println("UpdatePw Result : " + ps);

			if (result == 0) {
				System.out.println("비밀번호 변경 실패");
			} else {
				System.out.println("비밀번호 변경 완료");
				vo.setPw1(null);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.close(con, ps);
		}
		return result;
	}

	@Override // 회원 탈퇴
	public Integer updateStatus(MemberVO vo) throws Exception {
		Integer result = 0;
		try {
			con = DB.getConnection();
			System.out.println("UpdateStatus Connection : " + ps);

			String sql = "update BG_Member set Member_status = '탈퇴' where Member_id = ? and Member_pw = ? ";
			System.out.println("UpdateStatus sql 문장 : " + sql);

			ps = con.prepareStatement(sql);
			System.out.println("UpdateStatus PreparedStateMent : " + ps);

			ps.setString(1, vo.getBG_MemberId());
			ps.setString(2, vo.getBG_MemberPw());
			result = ps.executeUpdate();
			System.out.println("UpdateStatus result : " + result);

			if (result == 0) {
				System.out.println("회원 상태 변경 실패");
			} else {
				System.out.println("회원 상태 변경 완료");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.close(con, ps);
		}
		return result;
	}

	// 로그인 --------------------------------------------
	@Override // 로그인
	public LoginVO login(LoginVO vo) throws Exception {
		LoginVO loginvo = null;
		try {
			con = DB.getConnection();
			System.out.println("Login Connection : " + con);

			String sql = "select m.Member_id id, m.Member_name name,"
					+ " g.Grade_Name GradeName, g.Grade_No GradeNo from BG_Member m, BG_Grade g "
					+ " where (m.Grade_no = g.Grade_no )and Member_id = ? and Member_pw = ? and  not Member_status in ('탈퇴') ";
			System.out.println("Login Sql 문장 : " + sql);

			ps = con.prepareStatement(sql);
			System.out.println("Login PreparedStateMent : " + ps);
			ps.setString(1, vo.getLogin_id());
			ps.setString(2, vo.getLogin_pw());

			rs = ps.executeQuery();
			System.out.println("Login Resultset : " + rs);

			if (rs != null && rs.next()) {
				if (loginvo == null)
					loginvo = new LoginVO();
				loginvo.setLogin_id(rs.getString("id"));
				loginvo.setLogin_name(rs.getString("name"));
				loginvo.setLogin_gradeName(rs.getString("GradeName"));
				loginvo.setLogin_gradeNo(rs.getLong("GradeNo"));
			} else {
				System.out.println("로그인 실패");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.close(con, ps, rs);
		}
		return loginvo;
	}

	@Override
	public Integer conDateupdate(String id) throws Exception {
		Integer result = 0;
		try {
			con = DB.getConnection();
			String sql = "update BG_Member set Member_ConDate = sysdate where Member_id = ? ";
			ps = con.prepareStatement(sql);
			ps.setString(1, id);

			result = ps.executeUpdate();
			if (result == 0) {
				System.out.println("dao - condateUpdate 최근접속일 변경 실패");
			} else {
				System.out.println("dao - condateUpdate 최근접속일 변경 성공");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.close(con, ps);
		}
		return result;
	}

	@Override // 아이디 찾기
	public String findid(MemberVO vo) throws Exception {
		String id = null;
		try {
			con = DB.getConnection();
			System.out.println("FindID Connection : " + con);

			String sql = "select Member_id id from BG_Member where Member_name = ? and Member_birth = ? and Member_tel = ? ";
			System.out.println("FindID Sql 문장 : " + sql);

			ps = con.prepareStatement(sql);
			System.out.println("FindID PreparedStateMent : " + ps);
			ps.setString(1, vo.getBG_MemberName());
			ps.setString(2, vo.getBG_MemberBirth());
			ps.setString(3, vo.getBG_MemberTel());

			rs = ps.executeQuery();
			System.out.println("FindID Resultset : " + rs);

			if (rs != null && rs.next()) {
				id = rs.getString("id");
			} else {
				System.out.println("아이디 찾기 실패");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.close(con, ps, rs);
		}
		return id;
	}

	@Override // 비밀번호 찾기 이메일 전송
	public String findemail(MemberVO vo) throws Exception {
		String email = null;
		try {
			con = DB.getConnection();
			System.out.println("FindEmail Connection : " + con);

			String sql = "select Member_email email from BG_Member where Member_id = ? and Member_name = ? and Member_birth = ? and Member_tel = ?";
			System.out.println("FindEmail Sql 문장 : " + sql);

			ps = con.prepareStatement(sql);
			System.out.println("FindEmail PreparedStateMent : " + ps);
			ps.setString(1, vo.getBG_MemberId());
			ps.setString(2, vo.getBG_MemberName());
			ps.setString(3, vo.getBG_MemberBirth());
			ps.setString(4, vo.getBG_MemberTel());

			rs = ps.executeQuery();
			System.out.println("FindEmail Resultset : " + rs);

			if (rs != null && rs.next()) {
				email = rs.getString("email");
				System.out.println("이메일 찾기 성공");
			} else {
				System.out.println("이메일 찾기 실패");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.close(con, ps, rs);
		}
		return email;
	}

	@Override // 비밀번호 찾기 이메일 전송
	public Integer temppw(MemberVO vo) throws Exception {
		Integer result = 0;
		try {
			con = DB.getConnection();
			System.out.println("tempPW Connection : " + con);

			String sql = "update BG_Member set Member_pw = ? where Member_id = ?";
			System.out.println("tempPW Sql 문장 : " + sql);

			ps = con.prepareStatement(sql);
			System.out.println("tempPW PreparedStateMent : " + ps);
			ps.setString(1, vo.getBG_MemberPw());
			ps.setString(2, vo.getBG_MemberId());

			result = ps.executeUpdate();
			System.out.println("tempPW Resultset : " + result);
			if (result != 0) {
				System.out.println("임시 비밀번호 변경 완료");
			} else {
				System.out.println("임시 비밀번호 변경 실패");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.close(con, ps, rs);
		}
		return result;

	}

}
