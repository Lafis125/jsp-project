<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

[${param.idcheck}]은(는) ${not empty check?"사용 가능한 아이디입니다.":"중복된 아이디입니다. 다른 아이디를 선택해 주세요."}
