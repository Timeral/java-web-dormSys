<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8" />
	<title>青海大学-用户登录</title>
	<link rel="shortcut icon" href="https://portal-minio.qhu.edu.cn/cms/qhufavicon.png" type="image/x-icon">
	<%-- <!-- 加载需要的css文件 --> --%>
	<%@ include file="./model/required_css.jsp" %>
	<%@ include file="./model/conn_db.jsp" %>
	<%! int nav_page=-1;int login=0; %>
</head>

<body>
	<%
	login=0;
	cookies=request.getCookies();
	for(int i=0;i<cookies.length;++i){
		cookie=cookies[i];
		if(cookie.getName().equals("is_login") && cookie.getValue().equals("1")){
			login=1;
		}
	} %>
	<% if(login==1){
		String s="<script> alert('您已登录，请勿重复访问登录页面');location = 'index.jsp'</script>";
		out.println(s);
		} else { %>
		<%@ include file="./content/index_nologin.jsp" %>
	<% } %>
	
</body>

</html>