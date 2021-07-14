<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%! String sql=" ";
	String login_state="0";
	String register_state="0";
	String username="待定";
	String user_pic="./img/logo_default.jpg"; %>
<% 
	ResultSet res;

	sql="";
	login_state="0";
	register_state="0";
	login = 0;
	username="待定";
	user_pic="./img/logo_default.jpg";
	cookie= null;
	cookies = request.getCookies();
	int count=0;
	// 得到显示用户所需的信息
	if(cookies!=null){
		for (int i = 0; i < cookies.length; i++) {
                if(cookies[i].getName().equals("login_type")){
                    login=Integer.parseInt(cookies[i].getValue());
					continue;
				}
                if(cookies[i].getName().equals("name")){
                    username=cookies[i].getValue();
					continue;
				}
                if(cookies[i].getName().equals("user_pic")){
                    user_pic=cookies[i].getValue();
					continue;
				}
            }
	}

    //处理用户提交的登录信息
	if(request.getParameter("do_login")!=null)
	{
		String user=request.getParameter("user");
		String passwd=request.getParameter("passwd");
		sql="SELECT NAME, PIC, LOGIN FROM utable WHERE USERNAME='"+user+"' AND PASSWD='"+passwd+"'";
		res = stmt.executeQuery(sql);
		while(res.next()){
			count+=1;
		}
		if(count>0)
		{
    		res = stmt.executeQuery(sql);
			
			String NAME="name";
			String PIC="pic";
			String TYPE="type";
			while(res.next()){
				NAME = res.getString("NAME");
				PIC = res.getString("PIC");
				TYPE = res.getString("LOGIN");
			}
			int time = 0;
			if(request.getParameter("24h_nologin")=="checked")
				time = 60*60*24;
			else
				time=60*60*12;
			

			Cookie name=new Cookie("name",NAME);
			Cookie is_login_x=new Cookie("is_login","1");
			Cookie login_type=new Cookie("login_type",TYPE);
			Cookie user_pic_x=new Cookie("user_pic",PIC);
			name.setMaxAge(time);
			is_login_x.setMaxAge(time);
			login_type.setMaxAge(time);
			user_pic_x.setMaxAge(time);

			response.addCookie(name);
			response.addCookie(is_login_x);
			response.addCookie(login_type);
			response.addCookie(user_pic_x);

			login_state="1";
			login=Integer.parseInt(TYPE);
			username=NAME;
			user_pic=PIC;
		}
		else login_state="-1";
	}
	else if(request.getParameter("do_register")!=null)
	{
		String user=request.getParameter("user");
		String name=request.getParameter("name");
		String passwd=request.getParameter("passwd");
		sql="SELECT NAME FROM utable WHERE USERNAME='"+user+"'";
		
    	res = stmt.executeQuery(sql);
		count = 0;
		while(res.next()){
			count+=1;
		}
		if(count>0)
		{
			register_state="-1";
		}
		else
		{
			sql="INSERT INTO utable VALUES('"+user+"','"+name+"','./img/logo_default.jpg','"+passwd+"',2)";
			
    		res = stmt.executeQuery(sql);
			register_state="1";
		}
	}
%>
	<div id="index_holder">
		<img class='panel_pic_large' src='<%=user_pic%>'>
	</div>
	<p class="index_title" ><% if(nav_page!=-1 && nav_page!=-2){ %>
		<%@ include file="../model/get_time.jsp" %>
	<% } 
	else if(nav_page==-1) {
		//out.print("欢迎登录,");
	}
	else if(nav_page==-2) {
		//out.print("欢迎注册,");
	}%>
	<% String default_name="游客";
	if(login==0) out.print(default_name);
	else if(nav_page!=-1 && nav_page!=-2) out.print(username);
	else out.print(" ");%></p>
	<%-- <% if(login_state=="-1" || register_state=="-1") {%> --%>
	<%-- <p class="fail_type">
		<% if(login_state=="-1") out.print("用户名不存在或密码错误");
		if(register_state=="-1") out.print("该用户名已经存在");%>
	</p> --%>
	<%-- <% } if(register_state=="1") {%>
	<p class="success_type">
		<% if(register_state=="1") out.print("注册成功，赶紧登录吧！");%>
	</p>
	<% }if(login==0) {
		out.print("<a class='login_href' href='./login.jsp'>登录</a>");
		out.print("<a class='register_href' href='./register.jsp'>注册</a>");
	}else{if(login_state=="0" && register_state=="0"){
		if(login==2) out.print("<p class='user_type'>普通用户</p>");
		if(login==1) out.print("<p class='user_type'>管理员</p>");
	%>
	<% }else if(login_state=="1" || register_state=="1"){ %>
		<p class="success_type">
			<% if(login_state=="1") out.print("登录成功，欢迎回来");%>
		</p> --%>
		<%-- <% } %> --%>
	<% out.print("<div id='button_area'><br><form action='./index.jsp' method='post'><input type='submit' class='login_href_index' name='do_logout' value='登出' /></form><br></div>");%>
	<%-- <div class="panel_banner">
		<div align="center" style="width: 100%;height: auto;padding:0.5rem;">
			<div class="text_banner">掌上青大APP</div>
			<img src="https://www.qhu.edu.cn/images/APP.png" style="width:50%;height:auto;">
			<p class="text_banner" style="margin:auto;">地址：青海省西宁市宁大路251号<br>邮编：810016</p>
			<p class="text_banner">Copyright ©2020</p>
		</div>
	</div> --%>
<%
stmt.close();
conn.close();
%>