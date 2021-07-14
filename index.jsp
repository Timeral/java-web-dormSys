<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8" />
	<title>青大学生管理系统</title>

	<link rel="shortcut icon" href="https://portal-minio.qhu.edu.cn/cms/qhufavicon.png" type="image/x-icon">
	<%@ include file="./model/required_css.jsp" %>
	<%@ include file="./model/conn_db.jsp" %>
	<%! int nav_page=1; int login=0;%>
</head>

<body>
	<%@ include file="./model/check_login.jsp" %>
	<%
	if(request.getParameter("do_logout")!=null)
	{
		cookies = request.getCookies();
		if(cookies!=null){
			for(int i=0;i<cookies.length;++i){
				if(cookies[i].getName().compareTo("name")==0){
					cookies[i].setMaxAge(0);
					response.addCookie(cookies[i]);
				}
				else if(cookies[i].getName().compareTo("user_pic")==0){
					cookies[i].setMaxAge(0);
					response.addCookie(cookies[i]);
				}
				else if(cookies[i].getName().compareTo("login_type")==0){
					cookies[i].setMaxAge(0);
					response.addCookie(cookies[i]);
				}
				else if(cookies[i].getName().compareTo("is_login")==0){
					cookies[i].setMaxAge(0);
					response.addCookie(cookies[i]);
				}
			}
		login=0;
		}
	}%>
	<% if(login==1){ %>
		<div id="index">
			<div id="left_holder">
				<%@ include file="./model/nav_bar.jsp" %>
			</div>
			<div id="index_content">
				<%@ include file="./model/user_panel.jsp" %>
				<div class="content">
					<%@ include file="./content/index_content.jsp" %>
				</div>
			</div>
		</div>
	<% }else if(login==0){ %>
		<%@ include file="./content/index_nologin.jsp" %>
	<% } %>
	
</body>

</html>