-- 1. ȸ����� ����
DROP TABLE BG_grade CASCADE CONSTRAINTS;

-- 2. ȸ������ ����
DROP TABLE BG_member CASCADE CONSTRAINTS;


-- 1.ȸ����� ���̺�
CREATE TABLE BG_Grade(
  Grade_No number(2) PRIMARY KEY,
  Grade_Name varchar2(21) NOT NULL
);

-- 2.ȸ������ ���̺�
CREATE TABLE BG_Member(
    Member_id varchar2(60) primary key,
    Member_pw varchar2(60) not null,
    Member_name varchar2(100) not null,
    Member_address varchar2(1000) not null,
    Member_gender CHAR(6) CHECK (Member_gender = '����' or Member_gender = '����') NOT NULL,
    Member_birth DATE NOT NULL,
    Member_tel varchar2(20) not null,
    Member_email varchar2(100) not null,
    Member_status CHAR(6)  DEFAULT '����' CHECK(Member_status in('����', 'Ż��', '�޸�')),
    Member_regDate DATE DEFAULT sysdate,
    Member_conDate DATE DEFAULT sysdate,
    Grade_No number(2)  DEFAULT 1 REFERENCES BG_Grade(Grade_No)
);
    
-- trigger conDate���� +90�� ��� -> Status '�޸�' 
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
        :NEW.Member_status := '�޸�';
    END IF;
END;
/

-- ������
-- ȸ������Ʈ
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

-- ȸ�� ��� ����
update BG_Member set grade_No = 9  where Member_id = test;

-- ȸ�� ���� ����
delete from BG_Member where Member_id = test;


-- ȸ�� ����
-- ȸ����� test
insert into BG_Grade(grade_no, grade_name)
values(1, '�Ϲ�ȸ��');
insert into BG_Grade(grade_no, grade_name)
values(9, '������');

-- ȸ������ 
insert into BG_Member( Member_id, Member_pw , Member_name, 
Member_gender, Member_birth, Member_tel,
Member_email, Member_address )
values('test1', '1111', '�׽�Ʈ', '����', '1999-10-11', '010-1111-1111', 'asd@naver.com' , '������ ����');

-- ȸ������ --> ���̵� �ߺ� üũ
select Member_id from BG_member where Member_id = 'test'; 

-- ������ ����
select Member_id id, Member_pw pw, Member_name name, Member_gender gender,Member_gender gender,
to_char(Member_birth ,'yyyy-mm-dd') birth,
Member_tel tel,
to_char(Member_regDate,'yyyy-mm-dd') regDate,
to_char(Member_ConDate,'yyyy-mm-dd') conDate,
Member_Address address
from BG_Member where Member_id = 'test';  

-- ������ ����
update BG_Member set Member_tel = '010-5555-5555' , 
Member_email = 'qwe@daum.net' , Member_address = '����Ȯ��2' 
where Member_id = 'test' and Member_pw = '1111'; 


-- ȸ�� ��� ����
update BG_Member set Member_pw = '1234' where Member_id = 'test' and Member_pw = '1111';

-- ȸ�� ���� Ż��
update BG_Member set Member_status = 'Ż��' where Member_id = 'test1' and Member_pw = '1111'; 

-- �α��� ����
-- �α���
select m.Member_id id, m.Member_pw pw, m.Member_name name,
g.Grade_Name GradeName, g.Grade_No GradeNo from BG_Member m, BG_Grade g 
where (m.Grade_no = g.Grade_no )and Member_id = 'test1' and Member_pw = '1111' and not Member_status in ('Ż��') ;

-- ���̵� ã��
select Member_id id from BG_Member where Member_name = ? and Member_birth = ? and Member_tel = ? ;

-- ��й�ȣ ã�� �̸��� ���ۿ�
select Member_pw pw from BG_Member where Member_id = ? and Member_name = ? and Member_birth = ? and Member_tel = ?;

-- �ֱ� ������ ����
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



