<%
 /*this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
 %><%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,java.text.*"%>
<%nseer_db db = new nseer_db((String)session.getAttribute("unit_db_name"));%><%
int count=0;
String task_content=(String)session.getAttribute("task_content");
String sql="select count(id) from oa_message where check_tag='2'";
ResultSet rs=db.executeQuery(sql);
if(rs.next()){
	count=rs.getInt("count(id)");
}
String task="";
sql="select * from security_config_public_char where kind='task'";
rs=db.executeQuery(sql);
if(rs.next()){
	task=rs.getString("type_name");
}
if(task_content==null) {
	task_content="123";
}else{
	task_content="321";
	}
if(count==0){
	task_content+="987";
	}else{
		task_content+="789";
	}
if(task.equals("是")){
	task_content+="456";
}else{
	task_content+="654";
}
%><%=task_content%>