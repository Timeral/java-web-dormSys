<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mysql.jdbc.Driver" %> 
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*"%>


<%
	conn = null;
    stmt = null;
    // 注册 JDBC 驱动
    Class.forName(JDBC_DRIVER);
        
    // 打开链接
	try{
    conn = DriverManager.getConnection(DB_URL,USER,PASS);
	}catch(Exception e){
		out.println("数据库连接失败");
	}
	stmt = conn.createStatement();

	String order=request.getParameter("order");
	if(order==null){
		order="ASC";
	}
	
	String sql="SELECT student.SNO, student.SNAME, class.CNO, class.CNAME, teacher.TNAME FROM student, class, teacher,grade WHERE student.SNO=grade.SNO AND teacher.TNO=class.TNO AND grade.CNO=class.CNO ORDER BY class.CNO "+order;
	String search_content=request.getParameter("search_content");
	String temp=request.getParameter("search_type");
	if(search_content!=null && temp.equals("by_cnum"))
	{
		sql="SELECT student.SNO, student.SNAME, class.CNO, class.CNAME, teacher.TNAME FROM student, class, teacher,grade WHERE student.SNO=grade.SNO AND teacher.TNO=class.TNO AND grade.CNO=class.CNO AND class.CNO='"+search_content+"' ORDER BY (student.SNO+0) "+order;
	}
	else if(search_content!=null && temp.equals("by_cname"))
	{
		sql="SELECT student.SNO, student.SNAME, class.CNO, class.CNAME, teacher.TNAME FROM student, class, teacher,grade WHERE student.SNO=grade.SNO AND teacher.TNO=class.TNO AND grade.CNO=class.CNO AND class.CNAME LIKE '%"+search_content+"%' ORDER BY class.CNO "+order;
	}
	else if(search_content!=null && temp.equals("by_tname"))
	{
		sql="SELECT student.SNO, student.SNAME, class.CNO, class.CNAME, teacher.TNAME FROM student, class, teacher,grade WHERE student.SNO=grade.SNO AND teacher.TNO=class.TNO AND grade.CNO=class.CNO AND teacher.TNAME='"+search_content+"' ORDER BY class.CNO "+order;
	}

%>
<div id="tips" align="center">
	<div class="container">
		<h3>学生选课</h3>
		<form action='./search_lesson.jsp' method="get">
			<select name="search_type">
				<option value="by_cnum">以课程号搜索</option>
				<option value="by_cname">以课程名称搜索</option>
				<option value="by_tname">以任课老师搜索</option>
			</select>
			<input type='search' style="outline:none;border:none" name='search_content'>
			<input type='submit' value="搜索">
			<br>
			<input type='radio' name="order" value="ASC" checked="true" />升序排列
			<input type='radio' name="order" value="DESC" />降序排列
		</form>
		<br>
		<div class="table-responsive">
			<table class="table table-dark table-hover">
				<thead>
					<tr>
						<th>课程号</th>
						<th>课程名</th>
						<th>任课教师</th>
						<th>选课学生名称</th>
						<th>选课学生学号</th>
					</tr>
				</thead>
				<tbody>
					<% 
					res = stmt.executeQuery(sql);
					while(res.next()){
						String cno=res.getString("CNO");
						String cname=res.getString("CNAME");
						String tname=res.getString("TNAME");
						String sname=res.getString("SNAME");
						String sno=res.getString("SNO");
					%>
					<tr>
						<td><%= cno %></td>
						<td><%= cname %></td>
						<td><%= tname %></td>
						<td><%= sname %></td>
						<td><%= sno %></td>
					</tr>
					<% }
					stmt.close();
					conn.close();
					%>
				</tbody>
			</table>
		</div>
	</div>
</div>