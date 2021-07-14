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
        
    // 执行查询
	stmt = conn.createStatement();

	String sql="SELECT student.SNO, student.SNAME, class.CNO, class.CNAME, grade.CGRADE FROM student, class, grade WHERE student.SNO=grade.SNO AND grade.CNO=class.CNO AND grade.CGRADE<>'NULL'";
	String search_content=request.getParameter("search_content");
	String temp=request.getParameter("search_type");
	if(search_content!=null && temp.equals("by_num")==true){
		sql="SELECT student.SNO, student.SNAME, class.CNO, class.CNAME, grade.CGRADE FROM student, class, grade WHERE student.SNO=grade.SNO AND grade.CNO=class.CNO AND student.SNO='"+search_content+"' AND grade.CGRADE<>'NULL'";
	}
	else if(search_content!=null && temp.equals("by_name")==true){
		sql="SELECT student.SNO, student.SNAME, class.CNO, class.CNAME, grade.CGRADE FROM student, class, grade WHERE student.SNO=grade.SNO AND grade.CNO=class.CNO AND student.SNAME='"+search_content+"' AND grade.CGRADE<>'NULL'";
	}
%>
<div id="tips" align="center">
	<div class="container">
		<h3>学生成绩</h3>
		<form action='./search_grade.jsp' method="get">
			<select name="search_type">
				<option value="by_num">以学号搜索</option>
				<option value="by_name">以名称搜索</option>
			</select>
			<input type='search' style="outline:none;border:none" name='search_content'>
			<input type='submit' value="搜索">
		</form>
		<br>
		<div class="table-responsive">
			<table class="table table-dark table-hover">
				<thead>
					<tr>
						<th>学号</th>
						<th>姓名</th>
						<th>课程号</th>
						<th>课程名称</th>
						<th>成绩</th>
					</tr>
				</thead>
				<tbody>
					<%  
					res = stmt.executeQuery(sql);
					while(res.next()){
						String sno=res.getString("SNO");
						String sname=res.getString("SNAME");
						String cno=res.getString("CNO");
						String cname=res.getString("CNAME");
						int cgrade=res.getInt("CGRADE");
					%>
					<tr>
						<td><%= sno %></td>
						<td><%= sname %></td>
						<td><%= cno %></td>
						<td><%= cname %></td>
						<td><%= cgrade %></td>
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