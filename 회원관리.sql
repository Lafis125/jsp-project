-- 1. 회원등급 삭제
DROP TABLE BG_grade CASCADE CONSTRAINTS;

-- 2. 회원관리 삭제
DROP TABLE BG_member CASCADE CONSTRAINTS;


-- 1.회원등급 테이블
CREATE TABLE BG_Grade(
  Grade_No number(2) PRIMARY KEY,
  Grade_Name varchar2(21) NOT NULL
);

-- 2.회원관리 테이블
CREATE TABLE BG_Member(
    Member_id varchar2(60) primary key,
    Member_pw varchar2(60) not null,
    Member_name varchar2(100) not null,
    Member_address varchar2(1000) not null,
    Member_gender CHAR(6) CHECK (Member_gender = '남자' or Member_gender = '여자') NOT NULL,
    Member_birth DATE NOT NULL,
    Member_tel varchar2(20) not null,
    Member_email varchar2(100) not null,
    Member_status CHAR(6)  DEFAULT '정상' CHECK(Member_status in('정상', '탈퇴', '휴면')),
    Member_regDate DATE DEFAULT sysdate,
    Member_conDate DATE DEFAULT sysdate,
    Grade_No number(2)  DEFAULT 1 REFERENCES BG_Grade(Grade_No)
);
    
-- trigger conDate기준 +90일 경과 -> Status '휴먼' 
CREATE OR REPLACE TRIGGER trigger_updateStatus
BEFORE UPDATE ON BG_Member
FOR EACH ROW
DECLARE
    v_date_threshold DATE;
BEGIN
    -- Calculate the date threshold (90 days ago)
    v_date_threshold := SYSDATE - 90;
    
    -- Check if the last access date is more than 90 days old
    IF :NEW.Member_conDate < v_date_threshold THEN
        -- Set the status to 'human'
        :NEW.Member_status := '휴면';
    END IF;
END;
/

-- 관리자
-- 회원리스트
select Member_id id, Member_name name, Member_gender gender, 
member_birth birth, Member_tel tel, Member_status status, 
to_char(Member_regDate,'yyyy-mm-dd') regDate, 
to_char(Member_ConDate,'yyyy-mm-dd') conDate,  
Grade_No gradeNo, Grade_name gradeName 
from (select rownum rnum, Member_id , Member_name , 
Member_gender , Member_birth , Member_tel , Member_status , 
Member_regDate , Member_ConDate , Grade_No ,Grade_name 
from( select m.Member_id , m.Member_name , m.Member_gender , m.Member_birth , 
m.Member_tel , m.Member_status , m.Member_regDate , m.Member_ConDate , g.Grade_No ,
g.Grade_name from BG_Member m, BG_Grade g 
 where (1=0 or m.Member_status like 'test' ) and (g.grade_No = m.grade_No) order by Member_id desc
)
)
where rnum between 10 and 1;

-- 회원 등급 변경
update BG_Member set grade_No = 9  where Member_id = test;

-- 회원 정보 삭제
delete from BG_Member where Member_id = test;


-- 회원 관리
-- 회원등급 test
insert into BG_Grade(grade_no, grade_name)
values(1, '일반회원');
insert into BG_Grade(grade_no, grade_name)
values(9, '관리자');

-- 회원가입 
insert into BG_Member( Member_id, Member_pw , Member_name, 
Member_gender, Member_birth, Member_tel,
Member_email, Member_address )
values('test1', '1111', '테스트', '남자', '1999-10-11', '010-1111-1111', 'asd@naver.com' , '의정부 이젠');

-- 회원가입 --> 아이디 중복 체크
select Member_id from BG_member where Member_id = 'test'; 

-- 내정보 보기
select Member_id id, Member_pw pw, Member_name name, Member_gender gender,Member_gender gender,
to_char(Member_birth ,'yyyy-mm-dd') birth,
Member_tel tel,
to_char(Member_regDate,'yyyy-mm-dd') regDate,
to_char(Member_ConDate,'yyyy-mm-dd') conDate,
Member_Address address
from BG_Member where Member_id = 'test';  

-- 내정보 수정
update BG_Member set Member_tel = '010-5555-5555' , 
Member_email = 'qwe@daum.net' , Member_address = '이젠확원2' 
where Member_id = 'test' and Member_pw = '1111'; 


-- 회원 비번 변경
update BG_Member set Member_pw = '1234' where Member_id = 'test' and Member_pw = '1111';

-- 회원 상태 탈퇴
update BG_Member set Member_status = '탈퇴' where Member_id = 'test1' and Member_pw = '1111'; 

-- 로그인 관련
-- 로그인
select m.Member_id id, m.Member_pw pw, m.Member_name name,
g.Grade_Name GradeName, g.Grade_No GradeNo from BG_Member m, BG_Grade g 
where (m.Grade_no = g.Grade_no )and Member_id = 'test1' and Member_pw = '1111' and not Member_status in ('탈퇴') ;

-- 아이디 찾기
select Member_id id from BG_Member where Member_name = ? and Member_birth = ? and Member_tel = ? ;

-- 비밀번호 찾기 이메일 전송용
select Member_pw pw from BG_Member where Member_id = ? and Member_name = ? and Member_birth = ? and Member_tel = ?;

-- 최근 접속일 변경
update BG_Member set Member_ConDate = sysdate where Member_id = 'test1';


commit;

--test
select Member_id id, Member_name name, Member_gender gender,  member_birth birth, Member_tel tel, Member_status status, 
to_char(Member_regDate,'yyyy-mm-dd') regDate,  to_char(Member_ConDate,'yyyy-mm-dd') conDate,
Grade_No gradeNo, Grade_name gradeName  from (  select rownum rnum, Member_id , Member_name ,
Member_gender , Member_birth , Member_tel , Member_status ,  Member_regDate , Member_ConDate ,
Grade_No , Grade_name  from(  select m.Member_id , m.Member_name , m.Member_gender , m.Member_birth , 
m.Member_tel , m.Member_status , m.Member_regDate , m.Member_ConDate , g.Grade_No , 
g.Grade_name from BG_Member m, BG_Grade g and (g.grade_No = m.grade_No)  order by Member_id desc  )  ) where rnum between ? and ? 



