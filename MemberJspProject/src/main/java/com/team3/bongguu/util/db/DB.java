package com.team3.bongguu.util.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DB {

	// 오라클 연결 정보 - public static final
	// Oracle 연결 정보
	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe"; // Oracle sever 주소
	private static final String ID = "java";
	private static final String PW = "java";

	// Oracle 드라이버를 확인하는 static 초기화 블록 - 클래스 이름이 불려지만 자동 실행 된다.
	static {
		// 드라이버 확인 -> Main.main() : Class.forName(DB)
		try {
			Class.forName(DRIVER);
			System.out.println("DB - static 블록 : 드라이버 확인이 되었습니다.\n필요한 프로그램이 로딩되었습니다...");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("DB - static 블록 : 드라이버가 존재하지 않습니다.\n프로그램이 종료됩니다.");
			System.exit(1);
		}
	}
	
	// Connection(연결 객체)를 받아 내는 메서드 - DB.getConnection()
	public static Connection getConnection() throws Exception {
		System.out.println("1, 2. 드라이버 확인과 연결 객체 생성 완료");
		return DriverManager.getConnection(URL, ID, PW);
	}
	
	// con, pstmt를 닫는 메서드
	public static void close(Connection con, PreparedStatement pstmt) throws Exception {
		// 7. 닫기
		try {
			if(con != null) con.close();
			if(pstmt != null) pstmt.close();
			System.out.println("7. 닫기 완료");
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("게시판 글삭제 DB 닫기 오류가 발생되었습니다.");
		}
	}
	
	// con, pstmt, rs를 닫는 메서드
	public static void close(Connection con, PreparedStatement pstmt, ResultSet rs) throws Exception {
		// 7. 닫기
		try {
			close(con, pstmt);
			if(rs != null) rs.close();
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("게시판 글삭제 DB 닫기 오류가 발생되었습니다.");
		}
	}
	
}
