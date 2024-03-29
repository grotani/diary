<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%
	// 로그아웃 
	//session.removeAttribute("loginMember");	

	session.invalidate(); // 세션공간 초기화한 것 (포멧)
	
	response.sendRedirect("/diary/loginForm.jsp");
	
%>