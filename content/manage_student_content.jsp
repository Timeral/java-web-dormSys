<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mysql.jdbc.Driver" %> 
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*"%>

<%

	conn = null;
    //stmt = null;
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

	int change_time=0;
	String current_cno="00";
	String data="00";
	int wrong_insert=0;
	String s_type="by_default";
	String sql="SELECT DISTINCT student.SNO, student.SNAME, student.SSEX, student.SAGE, grade.CNO from student,grade WHERE student.SNO=grade.SNO";
	//$res=mysqli_query($link,$sql);
	res = stmt.executeQuery(sql);

	if(request.getParameter("type")!=null){
		s_type=request.getParameter("type");
	}

	if(request.getParameter("data")!=null){
		data=request.getParameter("data");
		if(s_type.equals("by_cno")){
			current_cno=data;
		}
	}

	if(request.getParameter("current_cno")!=null){
		current_cno=request.getParameter("current_cno");
	}

	if(request.getParameter("current_type")!=null){
		s_type=request.getParameter("current_type");
	}

	if(request.getParameter("current_data")!=null){
		data=request.getParameter("current_data");
	}

	if(request.getParameter("change_cno")!=null)
	{

		if(request.getParameter("search_type").equals("by_cno"))
		{
			if(request.getParameter("cno")!=null)
			{
				current_cno=request.getParameter("cno");
				data=request.getParameter("cno");
				sql="SELECT DISTINCT student.SNO, student.SNAME, student.SSEX, student.SAGE, grade.CNO from student,grade WHERE student.SNO=grade.SNO AND grade.CNO='"+data+"'";
				res = stmt.executeQuery(sql);
				s_type="by_cno";
			}
			else
				current_cno=request.getParameter("current_cno");
		}
		else if(request.getParameter("search_type").equals("by_cname"))
		{
			if(request.getParameter("cno")!=null)
			{
				current_cno="00";
				data=request.getParameter("cno");
				sql="SELECT DISTINCT student.SNO, student.SNAME, student.SSEX, student.SAGE, grade.CNO from student,grade,class WHERE student.SNO=grade.SNO AND class.CNO=grade.CNO AND class.CNAME LIKE '%"+data+"%'";
				res = stmt.executeQuery(sql);
				s_type="by_cname";
				}
			else
				current_cno=request.getParameter("current_cno");
		}
		else if(request.getParameter("search_type").equals("by_sname"))
		{
			if(request.getParameter("cno")!=null)
			{
				current_cno="00";
				data=request.getParameter("cno");
				sql="SELECT DISTINCT student.SNO, student.SNAME, student.SSEX, student.SAGE, grade.CNO from student,grade WHERE student.SNO=grade.SNO AND student.SNAME LIKE '%"+data+"%'";
				res = stmt.executeQuery(sql);
				s_type="by_sname";
				}
			else
				current_cno=request.getParameter("current_cno");
		}
		else if(request.getParameter("search_type").equals("by_sno"))
		{
			if(request.getParameter("cno")!=null)
			{
				current_cno="00";
				data=request.getParameter("cno");
				sql="SELECT DISTINCT student.SNO, student.SNAME, student.SSEX, student.SAGE, grade.CNO from student,grade,class WHERE student.SNO=grade.SNO AND class.CNO=grade.CNO AND student.SNO='"+data+"'";
				res = stmt.executeQuery(sql);
				s_type="by_sno";
				}
			else
				current_cno=request.getParameter("current_cno");
		}
		
	}
	else if(request.getParameter("insert_sno")!=null)
	{
		if(request.getParameter("in_sno")!=null)
		{
			String in_sno=request.getParameter("in_sno");
			String in_cno=current_cno;
			if(request.getParameter("in_cno")!=null){
				in_cno=request.getParameter("in_cno");
			}
			String in_sname=request.getParameter("in_sname"), in_ssex=request.getParameter("in_ssex");
			String in_sage=request.getParameter("in_sage");

			if(in_sname!=null && in_ssex!=null && in_sage!=null)
			{
				//检查输入信息是否和已存在信息冲突
				sql="SELECT SNAME,SSEX,SAGE FROM student WHERE SNO='"+in_sno+"'";
				res=stmt.executeQuery(sql);
				if(res.next() && (!res.getString("SNAME").equals(in_sname) || !res.getString("SSEX").equals(in_ssex) || !(res.getInt("SAGE")+"").equals(in_sage)))
				{
					String s="<script> alert('学号与其他信息不符') </script>";
					out.println(s);
				}
				else{
					//判断学生是否已选课
					sql="SELECT student.SNO FROM student WHERE student.SNO='"+in_sno+"'";
					res=stmt.executeQuery(sql);
					if(res.next()){
						
					}
					else{
						sql="INSERT INTO student VALUES('"+in_sno+"','"+in_sname+"','"+in_ssex+"','"+in_sage+"')";
						change_time = stmt.executeUpdate(sql);
					}
					//判断课程号是否是已有课程
					int judgeCno=0;
					sql="SELECT CNO FROM class";
					res=stmt.executeQuery(sql);
					while(res.next()){
						String jCNo=res.getString("CNO");
						if(in_cno.equals(jCNo)){
							judgeCno=1;break;
						}
					}
					if(judgeCno==0) wrong_insert=3;
					else{
						sql="INSERT INTO grade VALUES('"+in_sno+"','"+in_cno+"',NULL)";
						change_time = stmt.executeUpdate(sql);
					}
				}
			}
			else
			{
				wrong_insert=1;
			}
		}
	}
	else if(request.getParameter("sno")!=null && request.getParameter("cno")!=null)
	{
		String delete_sno=request.getParameter("sno");
		String delete_cno=request.getParameter("cno");
		sql="DELETE FROM grade where SNO='"+delete_sno+"' AND CNO='"+delete_cno+"'";
		change_time=stmt.executeUpdate(sql);
	}

	sql="SELECT DISTINCT class.CNAME FROM class,grade WHERE class.CNO=grade.CNO AND class.CNO='"+current_cno+"'";
	String class_name="";
	res = stmt.executeQuery(sql);
	while(res.next()){
		class_name=res.getString("CNAME");
	}

	if(s_type.equals("by_cno"))
	{
		sql="SELECT DISTINCT student.SNO, student.SNAME, student.SSEX, student.SAGE, grade.CNO from student,grade WHERE student.SNO=grade.SNO AND grade.CNO='"+data+"'";
		res = stmt.executeQuery(sql);
		s_type="by_cno";
	}
	else if(s_type.equals("by_cname"))
	{
		sql="SELECT DISTINCT student.SNO, student.SNAME, student.SSEX, student.SAGE, grade.CNO from student,grade,class WHERE student.SNO=grade.SNO AND class.CNO=grade.CNO AND class.CNAME LIKE '%"+data+"%'";
		res = stmt.executeQuery(sql);
		s_type="by_cname";
	}
	else if(s_type.equals("by_sname"))
	{
		sql="SELECT DISTINCT student.SNO, student.SNAME, student.SSEX, student.SAGE, grade.CNO from student,grade WHERE student.SNO=grade.SNO AND student.SNAME LIKE '%"+data+"%'";
		res = stmt.executeQuery(sql);
		s_type="by_sname";
	}
	else if(s_type.equals("by_sno"))
	{
		sql="SELECT DISTINCT student.SNO, student.SNAME, student.SSEX, student.SAGE, grade.CNO from student,grade,class WHERE student.SNO=grade.SNO AND class.CNO=grade.CNO AND student.SNO='"+data+"'";
		res = stmt.executeQuery(sql);
		s_type="by_sno";
	}
	else if(s_type.equals("by_default"))
	{
		sql="SELECT DISTINCT student.SNO, student.SNAME, student.SSEX, student.SAGE, grade.CNO from student,grade,class WHERE student.SNO=grade.SNO AND class.CNO=grade.CNO";
		res = stmt.executeQuery(sql);
		s_type="by_default";
	}

%>
<div id="tips" align="center">
	<div class="container">

		 <%
			if(res==null || s_type.equals("by_default")) out.print("<h3>班级学生管理</h3>");
			else if(s_type.equals("by_cno")==false){
				String ss="<h4>当前搜索的关键字为:"+data+"</h4>";
				out.print(ss);
			}
			else if(current_cno.equals("00")==false){
				String ss="<h4>当前管理的班级课程为:"+class_name+"</h4>";
				out.print(ss);
			}
		%> 

		<form action='./manage_student.jsp' method="post">
			<select name="search_type">
				<option value="by_cno">以课程号搜索</option>
				<option value="by_cname">以课程名搜索</option>
				<option value="by_sno">以学生学号搜索</option>
				<option value="by_sname">以学生姓名搜索</option>
			</select>
			<input type='text' placeholder="请输入搜索关键字" name="cno" />
			<input type='hidden' name='current_cno' value="<%= current_cno %>" />
			<input type='hidden' name='current_data' value="<%= data %>" />
			<input type='hidden' name='current_type' value="<%= s_type %>" />
			<input type='submit' name='change_cno'
				value="<%= (res==null ? "确认" : "搜索") %>" /><br>

			<% if(res!=null){ %>
			<% if(wrong_insert==1) out.print("<br><a class='fail_type' style='color:whitesmoke;'>操作失败,输入完整信息不完整</a>"); %>
			<% if(wrong_insert==2) out.print("<br><a class='fail_type' style='color:whitesmoke;'>操作失败,您输入的数据不合规范</a>"); %>
			<% if(wrong_insert==3) out.print("<br><a class='fail_type' style='color:whitesmoke;'>操作失败,该课程不存在</a>"); %>
			<% if(wrong_insert==4) out.print("<br><a class='fail_type' style='color:whitesmoke;'>学生信息成功录入但课程信息录入失败，请检查课程号是否正确</a>"); %><br>
			<% }%>
			<div class="table-responsive">
				<table class="table table-dark table-hover">
					<thead>
						<tr>
							<th>学号</th>
							<th>姓名</th>
							<th>性别</th>
							<th>年龄</th>
							<% if(!s_type.equals("by_cno")){%>
							<th>课程号</th>
							<% }%>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>

						<% if(res!=null){ %>
						<tr>
							<td><input type='text' style="max-width: 5rem;" name='in_sno' /></td>
							<td><input type='text' style="max-width: 5rem;" name='in_sname' /></td>
							<td><input type='text' style="max-width: 5rem;" name='in_ssex' /></td>
							<td><input type='text' style="max-width: 5rem;" name='in_sage' /></td>
							<% if(!s_type.equals("by_cno")){%>
							<td><input type='text' style="max-width: 5rem;" name='in_cno' /></td>
							<% }%>
							<td>
								<input type='submit' class="register_href" style="border: none;" name='insert_sno'
									value="确认" />
								<input type='button' class="login_href" style="border: none;" value="帮助"
									onclick="alert('输入相关信息,以加入学生至指定班级;\n当输入学号不在已有学生名单中时,默认添加新学生信息,此时每一项都需完整填写;\n若学号已存在，则输入信息必须与已存在信息相符才能添加课程;\n课程号不能是不存在的.\n注意：\n学号必须是六位数，\n姓名长度小于20且不为空，\n性别为一个字，\n课程号为两位数。')" />
							</td>
						</tr>

						<%
							while(res.next()){
								String sno=res.getString("SNO");
								String sname=res.getString("SNAME");
								String ssex=res.getString("SSEX");
								int sage=res.getInt("SAGE");
								String cno=res.getString("CNO");
						%>
						<tr>
							<td><%= sno %></td>
							<td><%= sname %></td>
							<td><%= ssex %></td>
							<td><%= sage %></td>
							<% if(!s_type.equals("by_cno")){%>
							<td><%= cno %></td>
							<% }%>
							<td>
								<%-- <% $sno=$row['SNO'];$cno=$row['CNO'];%> --%>
								<% String temp="./manage_student.jsp?sno="+sno+"&cno="+cno+"&type="+s_type+"&data="+data; %>
								<a class="register_href"
									href="<%= temp %>"
									onClick="return confirm ('确认将该学生移出此课程？移出后若该学生存在此课程成绩也会被一并删除')">删除</button>
							</td>
						</tr>
						<% }} else if(current_cno.equals("00")){ %>
							<tr>
								<td colspan="<% if(!s_type.equals("by_cno")) out.print(6);else out.print(5); %>" align="center">当前结果为空，请在上方输入搜索关键字</p>
							</tr>
						<% } else{ %>
							<tr>
								<td colspan="<% if(!s_type.equals("by_cno")) out.print(6);else out.print(5); %>" align="center">搜索结果为空，请重试</p>
							</tr>
						<% }%>
					</tbody>
				</table>
			</div>
		</form>
	</div>
</div>
<%
stmt.close();
conn.close();
%>