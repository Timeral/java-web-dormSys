<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <!-- 这是导航栏背景图片 --> --%>
<%-- <div id="background_holder">
	<img class="pic" src="./img/BlurBackground.png"> --%>
<%-- </div> --%>
<%-- <!-- 这是贯穿导航栏的背景颜色 --> --%>
<%-- <div id="menu_bg_color"></div> --%>
<%-- <!-- 这是logo --> --%>
<%-- <div id="logo_holder">
	<img class='logo' src='https://www.qhu.edu.cn/images/20161123/logo.png'>
</div>
<div id="logo_holder2">
	<img class='logo' src='https://www.qhu.edu.cn/images/20161123/xiaoxun.png'>
</div> --%>
<%-- <!-- 这些是导航栏按钮 --> --%>
<div id="menu_title_holder">

	<div class="menu_title">
		<span style="z-index:1"><a href="./index.jsp" <% if(nav_page==1) out.print("style='color:#000000'"); %>>首页</a></span>
		<% 
			if(nav_page==1){
				out.println("<div class='nav_selector_first'></div>");
			}
		%>
	</div>
	<div class="menu_title">
		<span style="z-index:1"><a href="./announcement.jsp" <% if(nav_page==2) out.print("style='color:#000000'"); %> >公告</a></span>
		<% 
			if(nav_page==2){
				out.println("<div class='nav_selector'></div>");
			}
		%>
	</div>
	<div class="menu_title">
		<span style="z-index:1"><a href="#" <% if(nav_page==3) out.print("style='color:#000000'"); %>>管理</a></span>
		<div class="menu_holder">
			<a class="menu_content" style="color:#242424;font-weight:bold" href="./manage_grade.jsp">学生成绩</a><br>
			<a class="menu_content" style="color:#242424;font-weight:bold" href="./manage_student.jsp">学生选课</a><br>
			<a class="menu_content" style="color:#242424;font-weight:bold" href="./manage_teacher.jsp">教师模块</a>
		</div>
		<% 
			if(nav_page==3){
				out.println("<div class='nav_selector'></div>");
			}
		%>
	</div>
	<div class="menu_title">
		<span style="z-index:1"><a href="#" <% if(nav_page==4) out.print("style='color:#000000'"); %>>查询</a></span>
		<div class="menu_holder">
			<a class="menu_content" style="color:#242424;font-weight:bold" href="./search_grade.jsp">学生成绩</a><br>
			<a class="menu_content" style="color:#242424;font-weight:bold" href="./search_lesson.jsp">学生选课</a>
		</div>
		<% 
			if(nav_page==4){
				out.println("<div class='nav_selector'></div>");
			}
		%>
	</div>
	<div class="menu_title">
		<span style="z-index:1"><a href="./friend.jsp" <% if(nav_page==5) out.print("style='color:#000000'"); %>>友链</a></span>
		<% 
			if(nav_page==5){
				out.println("<div class='nav_selector'></div>");
			}
		%>
	</div>
	<div class="menu_title">
		<span style="z-index:1"><a href="./about_us.jsp" <% if(nav_page==6) out.print("style='color:#000000'"); %>>关于</a></span>
		<% 
			if(nav_page==6){
				out.println("<div class='nav_selector_last'></div>");
			}
		%>
	</div>
</div>