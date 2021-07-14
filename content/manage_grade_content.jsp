<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mysql.jdbc.Driver" %> 
<%@ page import="java.sql.*" %>
<%! 
	int wrong_insert=0;
	int res_length=0;
	String data="00";
	String s_type="by_default";
	String class_name=" ";
	String current_cno="00";
	String next_page_x=null;
	String tmp=null;
	StringBuffer studentinfo=new StringBuffer();
	ResultSet res;
	ResultSet res_alt; %>
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
    stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
	sql="SELECT DISTINCT student.SNO, student.SNAME, grade.CGRADE, grade.CNO from student,grade WHERE student.SNO=grade.SNO";
	res = stmt.executeQuery(sql);
	if(request.getParameter("type")!=null)
		s_type=request.getParameter("type");
	if(request.getParameter("data")!=null)
		{
			data=request.getParameter("data");
			if(s_type.equals("by_cno"))
				current_cno=data;
		}
	if(request.getParameter("current_cno")!=null)
		current_cno=request.getParameter("current_cno");
	if(request.getParameter("current_type")!=null)
		s_type=request.getParameter("current_type");
	if(request.getParameter("current_data")!=null)
		data=request.getParameter("current_data");
	if(request.getParameter("change_cno")!=null)
	{
		if(request.getParameter("search_type").equals("by_cno"))
		{
			if(request.getParameter("cno")!=null)
			{
				current_cno=request.getParameter("cno");
				data=request.getParameter("cno");
				sql="SELECT DISTINCT student.SNO, student.SNAME, student.SSEX, student.SAGE, grade.CNO, grade.CGRADE from student,grade WHERE student.SNO=grade.SNO AND grade.CNO='"+data+"'";
				res = stmt.executeQuery(sql);
				s_type="by_cno";
			}
			else
				current_cno=request.getParameter("current_cno");
		}
		else if(request.getParameter("search_type").equals("by_cname"))
		{
			if(request.getParameter("cno")!=null){
				current_cno="00";
				data=request.getParameter("cno");
				sql="SELECT DISTINCT student.SNO, student.SNAME, student.SSEX, student.SAGE, grade.CNO, grade.CGRADE from student,grade,class WHERE student.SNO=grade.SNO AND class.CNO=grade.CNO AND class.CNAME LIKE '%"+data+"%'";
				res = stmt.executeQuery(sql);
				s_type="by_cname";
				}
			else
				current_cno=request.getParameter("current_cno");
		}
		else if(request.getParameter("search_type").equals("by_sname"))
		{
			if(request.getParameter("cno")!=null){
				current_cno="00";
				data=request.getParameter("cno");
				sql="SELECT DISTINCT student.SNO, student.SNAME, student.SSEX, student.SAGE, grade.CNO, grade.CGRADE from student,grade WHERE student.SNO=grade.SNO AND student.SNAME LIKE '%"+data+"%'";
				res = stmt.executeQuery(sql);
				s_type="by_sname";
				}
			else
				current_cno=request.getParameter("current_cno");
		}
		else if(request.getParameter("search_type").equals("by_sno"))
		{
			if(request.getParameter("cno")!=null){
				current_cno="00";
				data=request.getParameter("cno");
				sql="SELECT DISTINCT student.SNO, student.SNAME, student.SSEX, student.SAGE, grade.CNO, grade.CGRADE from student,grade,class WHERE student.SNO=grade.SNO AND class.CNO=grade.CNO AND student.SNO='"+data+"'";
				res = stmt.executeQuery(sql);
				s_type="by_sno";
				}
			else
				current_cno=request.getParameter("current_cno");
		}
	}
	else if(request.getParameter("insert_sno")!=null)
	{
		if(request.getParameter("in_sno")!=null && request.getParameter("in_grade")!=null)
		{
			String in_sno=request.getParameter("in_sno");
			String in_grade=request.getParameter("in_grade");
			String in_cno=current_cno;
			if(request.getParameter("in_cno")!=null)
				in_cno=request.getParameter("in_cno");
			sql="SELECT SNO FROM grade WHERE SNO='"+in_sno+"'";
			res = stmt.executeQuery(sql);
			sql="UPDATE grade SET CGRADE='"+in_grade+"' WHERE SNO='"+in_sno+"' AND CNO='"+in_cno+"'";
			count = stmt.executeUpdate(sql);
			if(count!=1){
				wrong_insert=1;
			}
		}
	}
	else if(request.getParameter("sno")!=null && request.getParameter("cno")!=null)
	{
		String delete_sno=request.getParameter("sno");
		String delete_cno=request.getParameter("cno");
		sql="UPDATE grade SET CGRADE=NULL WHERE SNO='"+delete_sno+"' AND CNO='"+delete_cno+"'";
		count = stmt.executeUpdate(sql);
	}

	sql="SELECT DISTINCT class.CNAME FROM class,grade WHERE class.CNO=grade.CNO AND class.CNO='"+current_cno+"'";
	
	res = stmt.executeQuery(sql);
	while(res.next()){
		class_name=res.getString("CNAME");
	}

	if(s_type.equals("by_cno"))
	{
		sql="SELECT DISTINCT student.SNO, student.SNAME, student.SSEX, student.SAGE, grade.CNO, grade.CGRADE from student,grade WHERE student.SNO=grade.SNO AND grade.CNO='"+data+"'";
		res = stmt.executeQuery(sql);
		s_type="by_cno";
	}
	else if(s_type.equals("by_cname"))
	{
		sql="SELECT DISTINCT student.SNO, student.SNAME, student.SSEX, student.SAGE, grade.CNO, grade.CGRADE from student,grade,class WHERE student.SNO=grade.SNO AND class.CNO=grade.CNO AND class.CNAME LIKE '%"+data+"%'";
		res = stmt.executeQuery(sql);
		s_type="by_cname";
	}
	else if(s_type.equals("by_sname"))
	{
		sql="SELECT DISTINCT student.SNO, student.SNAME, student.SSEX, student.SAGE, grade.CNO, grade.CGRADE from student,grade WHERE student.SNO=grade.SNO AND student.SNAME LIKE '%"+data+"%'";
		res = stmt.executeQuery(sql);
		s_type="by_sname";
	}
	else if(s_type.equals("by_sno"))
	{
		sql="SELECT DISTINCT student.SNO, student.SNAME, student.SSEX, student.SAGE, grade.CNO, grade.CGRADE from student,grade,class WHERE student.SNO=grade.SNO AND class.CNO=grade.CNO AND student.SNO='"+data+"'";
		res = stmt.executeQuery(sql);
		s_type="by_sno";
	}
	else if(s_type.equals("by_default"))
	{
		sql="SELECT DISTINCT student.SNO, student.SNAME, student.SSEX, student.SAGE, grade.CNO, grade.CGRADE from student,grade,class WHERE student.SNO=grade.SNO AND class.CNO=grade.CNO";
		res = stmt.executeQuery(sql);
		s_type="by_default";
	}
	
	res.last(); //结果集指针知道最后一行数据
	res_length = res.getRow();
  
	res.beforeFirst();

%>

<div id="tips" align="center">
  <div class="container">
	<% if(res_length==0 || s_type.equals("by_default")) out.print("<h3>班级成绩管理</h3>");
		else if(s_type.equals("by_cno")) out.print("<h4>当前搜索的关键字为:"+data+"</h4>");
		else if(!current_cno.equals("00")) out.print("<h4>当前管理的班级课程为:"+class_name+"</h4>");%>
	<form action='./manage_grade.jsp' method="post">
		<select name="search_type">
			<option value="by_cno">以课程号搜索</option>
			<option value="by_cname">以课程名搜索</option>
			<option value="by_sno">以学生学号搜索</option>
			<option value="by_sname">以学生姓名搜索</option>
		</select>
		<input type='text' placeholder="请输入搜索关键字" name="cno"/>
		<input type='hidden' name='current_cno' value="<% out.print(current_cno);%>" />
		<input type='hidden' name='current_data' value="<% out.print(data);%>" />
		<input type='hidden' name='current_type' value="<% out.print(s_type);%>" />
		<input type='submit' name='change_cno' value="<% if(res_length==0) out.print("确认");else out.print("搜索");%>"/>
		<% if(res_length!=0) {%>
		<fieldset align="left">
			<legend style="color:#404040;font-size: 1.0rem;">修改学生成绩（注：学号和课程号不能是表中不存在的，如有需要，请先在学生选课界面添加后再录入成绩）</legend>
			<input type='text' name='in_sno' placeholder="请输入学号"/>
			<input type='text' name='in_grade' placeholder="请输入此课程成绩"/><% if(!s_type.equals("by_cno")){ %>
			<input type='text' name='in_cno' placeholder="请输入课程号"/>
			<% }%>
			<input type='submit' name='insert_sno' value="确认"/>
			<% if(wrong_insert==1) out.print("<br><a>录入失败,当前学号学生未选修这门课程</a>"); wrong_insert=0; %>
		</fieldset><br><% }%>
	</form>
	<form action='./manage_grade.jsp' method="get">
		<div class="table-responsive">
			<table class="table table-dark table-hover">
				<thead>
					<tr>
						<th>学号</th>
						<th>姓名</th>
						<% if(!s_type.equals("by_cno")){%>
						<th>课程号</th>
						<% }%>
						<th>成绩</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				<% if(res_length!=0){ while(res.next()){%>
					<tr>
						<td><%=res.getString("SNO")%></td>
						<td><%=res.getString("SNAME")%></td>
						<% if(!s_type.equals("by_cno")){%>
						<td><%=res.getString("CNO")%></td>
						<% }%>
						<td><% if(res.getString("CGRADE")==null) out.print("未录入"); else out.print(res.getString("CGRADE"));%></td>
						<td>
							<%next_page_x="./manage_grade.jsp?sno="+res.getString("SNO")+"&cno="+res.getString("CNO")+"&type="+s_type+"&data="+data; %>
							<a class="register_href" href="<%=next_page_x%>" onClick="return confirm ('确认将该学生的成绩重置？重置后该学生的成绩将显示为未录入')">重置</button>
						</td>
					</tr>
				<% }} else if(current_cno.equals("00")){ %>
					<tr>
						<td colspan="<% if(!s_type.equals("by_cno")) out.print(5);else out.print(4); %>" align="center">当前结果为空，请在上方输入搜索关键字</p>
					</tr>
				<% } else{ %>
					<tr>
						<td colspan="<% if(!s_type.equals("by_cno")) out.print(5);else out.print(4); %>" align="center">搜索结果为空，请重试</p>
					</tr>
				<% }
				s_type="by_default";%>
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