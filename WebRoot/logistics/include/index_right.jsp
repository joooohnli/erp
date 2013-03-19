<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import="java.text.*" import ="include.nseer_db.*"  import ="include.tree_index.Nseer"%>
<%
Nseer n=new Nseer();
nseer_db db = new nseer_db((String)session.getAttribute("unit_db_name"));
nseer_db db1 = new nseer_db((String)session.getAttribute("unit_db_name"));
String mod_c=request.getParameter("mod_c");
String mod=request.getParameter("mod");
String main_code=request.getParameter("main_code");
String human_IDD=(String)session.getAttribute("human_IDD");
String sql="select * from drag_img where drag_text='"+mod_c+"' and human_ID='"+human_IDD+"'";
ResultSet rs=db.executeQuery(sql);
if(rs.next()){
String path="../../"+rs.getString("firstworkname");
response.sendRedirect(path);
}else{
String sql1="select * from "+mod+"_view where human_ID='"+human_IDD+"' order by id";
ResultSet rs1=db1.executeQuery(sql1);
while(rs1.next()){
	if(rs1.getString("file_path").indexOf("config")==-1&&!rs1.getString("hreflink").equals("")){
String file_path=rs1.getString("file_path");
String href_link=rs1.getString("hreflink");
String path1="../../"+file_path+href_link;
response.sendRedirect(path1);
	rs1.last();
	}
}
}
db.close();
db1.close();
%>