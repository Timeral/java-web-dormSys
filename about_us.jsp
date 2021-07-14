<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8" />
	<title>青海大学-关于</title>
	<link rel="shortcut icon" href="https://portal-minio.qhu.edu.cn/cms/qhufavicon.png" type="image/x-icon">
	<%-- <!-- 导入需要的配置文件 --> --%>
	<%@ include file="./model/required_css.jsp" %>
	<%@ include file="./model/conn_db.jsp" %>
	<%! int nav_page=6; int login=0;%>
</head>

<body>
	<%@ include file="./model/check_login.jsp" %>
	<% if(login==1){ %>
		<div id="about_us">
			<div id="left_holder">
				<%@ include file="./model/nav_bar.jsp" %>
			</div>
			<div id="index_content">
				<%@ include file="./model/user_panel.jsp" %>
				<div class="content">
					<%@ include file="./content/about_us_content.jsp" %>
				</div>
			</div>
		</div>
	<% }else if(login==0){ 
		String s="<script> alert('请先登录！将为您跳转至登录界面');location = 'login.jsp'</script>";
		out.println(s);
	}%>
</body>

</html>