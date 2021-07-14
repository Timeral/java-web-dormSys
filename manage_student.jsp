<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>

<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8" />
	<title>青海大学-管理学生选课</title>
	<link rel="shortcut icon" href="https://portal-minio.qhu.edu.cn/cms/qhufavicon.png" type="image/x-icon">
	<%-- <!-- 加载需要的css文件 --> --%>
	<%@ include file="./model/required_css.jsp" %>
	<%@ include file="./model/conn_db.jsp" %>
	<%! int nav_page=3;int login=0; %>
</head>

<body>
<%		
	cookie = null;
	cookies = request.getCookies();
	int judge1=0, judge2=0;
	if(cookies!=null){
		for(int i=0; i<cookies.length; i++){
			cookie = cookies[i];
			if(cookie.getName().equals("is_login") && cookie.getValue().equals("1")){
				judge1=1;break;
			}
		}
		if(judge1==1){
			for(int i=0; i<cookies.length; i++){
				cookie = cookies[i];
				if(cookie.getName().equals("login_type") && cookie.getValue().equals("1")){
					judge2=1;break;
				}
			}
			if(judge2==0){
				out.print("<script>alert('您是普通用户，只可进行查询操作！将为您导航至首页');location = 'index.jsp'</script>");
			}
		}
	}
	if(judge1==0){
		String s="<script> alert('您是普通用户，只可进行查询操作！将为您导航至首页');location = 'index.jsp'</script>";
		out.println(s);
	}
%>
	<div id="index">
		<div id="left_holder">
			<%@ include file="./model/nav_bar.jsp" %>
		</div>
		<div id="index_content">
			<%@ include file="./model/user_panel.jsp" %>
			<div class="content">
				<%@ include file="./content/manage_student_content.jsp" %>
			</div>
		</div>
	</div>
</body>

</html>