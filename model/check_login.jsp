<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	if(request.getParameter("do_login")!=null || request.getParameter("do_register")!=null)
		login=1;
	cookies=request.getCookies();
	for(int i=0;i<cookies.length;++i){
		cookie=cookies[i];
		if(cookie.getName().equals("is_login") && cookie.getValue().equals("1")){
			login=1;
		}
	}
%>