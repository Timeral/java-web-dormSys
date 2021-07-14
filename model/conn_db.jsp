<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mysql.jdbc.Driver" %> 
<%@ page import="java.sql.*" %>

<%! String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";  
    String DB_URL = "jdbc:mysql://localhost:3306/Web?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
	String USER = "root";
    String PASS = "123456";
    Connection conn = null;
    Statement stmt = null;
	Cookie cookie= null;
    Cookie[] cookies = null; %>

<%
    Class.forName(JDBC_DRIVER);
    try{
    conn = DriverManager.getConnection(DB_URL,USER,PASS);
	}catch(Exception e){
		out.println("数据库连接失败");
	}
    stmt = conn.createStatement();
%>