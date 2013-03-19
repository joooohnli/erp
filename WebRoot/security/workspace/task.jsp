<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import ="include.nseer_db.*,java.sql.*" import="java.util.*" import="java.io.*" import="java.text.*" import ="include.nseer_db.*" import ="include.tree_index.Nseer"%>
<%
Nseer n=new Nseer();
nseer_db db = new nseer_db((String)session.getAttribute("unit_db_name"));
nseer_db db1 = new nseer_db((String)session.getAttribute("unit_db_name"));
double task_cycle=0.0d;
double task_refresh=0.0d;
String url="";
String urlr="";
String mod="";
String file_path="";
String hreflink="";
String uname=(String)session.getAttribute("usernamec");
String unit_id=uname.substring(0,uname.indexOf("_"));
String check_main_path_temp=unit_id+"_check_main_path";
String check_main_path=(String)application.getAttribute(check_main_path_temp);
if(check_main_path==null){
	application.setAttribute(check_main_path_temp,"finished");
	response.sendRedirect("../../include_auto_execute_reset_ok");
}else{
String tag22=(String)session.getAttribute("tagc");
String app22=(String)application.getAttribute(uname+"c");
String realname1=(String)session.getAttribute("realeditorc");
String human_IDD1=(String)session.getAttribute("human_IDD");
String userName1=(String)session.getAttribute("userName");
String unit_db_name=(String)session.getAttribute("unit_db_name");
String unit_name1=(String)session.getAttribute("unit_name");
String unit_id1=(String)session.getAttribute("unit_id");
String field_type1=(String)session.getAttribute("field_type");
String language1=(String)session.getAttribute("language");
String task_id=(String)session.getAttribute("task_id");
String sql="select * from security_taskcycle";
ResultSet rs=db.executeQuery(sql);
if(rs.next()){
	task_cycle=rs.getDouble("cycle");
	task_refresh=rs.getDouble("refresh");
}
if(task_id==null){
sql="select * from security_task order by id";
rs=db.executeQuery(sql);
while(rs.next()){
	url=rs.getString("url").substring(6);
	mod=url.substring(0,url.indexOf("/"))+"_view";
	file_path=url.substring(0,url.lastIndexOf("/")+1);
	hreflink=url.substring(url.lastIndexOf("/")+1);
	String sql1="select id from "+mod+" where human_ID='"+human_IDD1+"' and hreflink='"+hreflink+"' and file_path='"+file_path+"'";
	
	ResultSet rs1=db1.executeQuery(sql1);
	if(rs1.next()){
		urlr="../../"+file_path+hreflink;
		task_id=(rs.getInt("id")+1)+"";
		session.setAttribute("task_id",task_id);
		break;
	}else{
		continue;
	}
}
}else{
	sql="select * from security_task where id>='"+task_id+"'";
rs=db.executeQuery(sql);
while(rs.next()){
	url=rs.getString("url").substring(6);
	mod=url.substring(0,url.indexOf("/"))+"_view";
	file_path=url.substring(0,url.lastIndexOf("/")+1);
	hreflink=url.substring(url.lastIndexOf("/")+1);
	String sql1="select id from "+mod+" where human_ID='"+human_IDD1+"' and hreflink='"+hreflink+"' and file_path='"+file_path+"'";
	ResultSet rs1=db1.executeQuery(sql1);
	if(rs1.next()){
		urlr="../../"+file_path+hreflink;
		task_id=(rs.getInt("id")+1)+"";
		session.setAttribute("task_id",task_id);
		break;
	}else{
		continue;
	}
}
if(urlr.equals("")){
	sql="select * from security_task order by id";
rs=db.executeQuery(sql);
while(rs.next()){
	url=rs.getString("url").substring(6);
	mod=url.substring(0,url.indexOf("/"))+"_view";
	file_path=url.substring(0,url.lastIndexOf("/")+1);
	hreflink=url.substring(url.lastIndexOf("/")+1);
	String sql1="select id from "+mod+" where human_ID='"+human_IDD1+"' and hreflink='"+hreflink+"' and file_path='"+file_path+"'";
	ResultSet rs1=db1.executeQuery(sql1);
	if(rs1.next()){
		urlr="../../"+file_path+hreflink;
		task_id=(rs.getInt("id")+1)+"";
		session.setAttribute("task_id",task_id);
		break;
	}else{
		continue;
	}
}
}
}
db.close();
db1.close();
if(urlr.equals("")) response.sendRedirect("no_task.jsp");
}
%>
<META HTTP-EQUIV="refresh" content="<%=task_cycle*60%>">
<frameset cols="*,0" frameborder="no" border="0" framespacing="0" scrolling="auto">
  <frame src="task_list.jsp?url=<%=urlr%>&task_refresh=<%=task_refresh%>" name="mainFrame" id="mainFrame"  scrolling="auto"/>
  <frame src="" />
</frameset>
<noframes>
<body>
</body>
</noframes>