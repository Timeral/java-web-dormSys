<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
if(nav_page!=-1 && nav_page!=-2){
    java.util.Date date = new java.util.Date();
	SimpleDateFormat df = new SimpleDateFormat("HH:mm");
	String time = df.format(date);
	String morning="06:15";
	String noon="11:30";
	String afternoon="14:00";
	String evening="18:10";
	String night="22:30";
	if(time.compareTo(morning)>=0 && time.compareTo(noon)<0) out.print("早安,");
	if(time.compareTo(noon)>=0 && time.compareTo(afternoon)<0) out.print("午安,");
	if(time.compareTo(afternoon)>=0 && time.compareTo(evening)<0) out.print("下午好,");
	if(time.compareTo(evening)>=0 && time.compareTo(night)<0) out.print("晚上好,");
	if(time.compareTo(night)>=0) out.print("晚安,");
	if(time.compareTo(morning)<0)  out.print("该睡了,");
}else if(nav_page==-1) {
		out.print("欢迎登录");
	}
else if(nav_page==-2) {
		out.print("欢迎注册");
	}
%>