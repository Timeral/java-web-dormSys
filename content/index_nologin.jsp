<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="index">
	<div id="index_content">
		<div id="index_holder">
			<img class="panel_pic_large" src="./img/logo_default.jpg" >
		</div>
		<% if(nav_page==-1){ %>
			<p class="index_title">欢迎使用青大学生管理系统</p>
			<div id="button_area">
				<br>
				<a class='login_href_index' href='./index.jsp'>返回 →</a>
				<br>
			</div>
			<%@ include file="login_content.jsp" %>
		<% }else{ %>
			<p class="index_title"><%@ include file="../model/get_time.jsp" %> 青大游子</p>
			<div id="button_area">
				<br>
				<a class='login_href_index' href='./login.jsp'>登录/注册 →</a>
				<br>
			</div>
			<div id="index_announce">
				<%@ include file="announcement_content.jsp" %>
			</div>
		<% } %>
	</div>
</div>