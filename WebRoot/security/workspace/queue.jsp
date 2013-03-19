<%
/*--
*this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 --*/
 %>
<%@page contentType="text/html; charset=gb2312" language="java" import ="include.nseer_db.*,java.sql.*" import="java.util.*" import="java.io.*" import="java.text.*" import ="include.nseer_db.*"%>
<%
nseer_db db = new nseer_db((String)session.getAttribute("unit_db_name"));
nseer_db db1 = new nseer_db((String)session.getAttribute("unit_db_name"));
String human_ID=(String)session.getAttribute("human_IDD");
//String human_ID=request.getParameter("human_ID");
String sql="select * from drag_img where human_ID='"+human_ID+"' order by drag_img_top,drag_img_left";
ResultSet rs=db.executeQuery(sql);
int mm=0;
int x=70;
int y=10;
while(rs.next()){
	sql="update drag_img set drag_img_top='"+x+"',drag_img_left='"+y+"' where id='"+rs.getString("id")+"'";
	db1.executeUpdate(sql);
	y+=120;
	mm++;
	if(mm>7){
		mm=0;
		x+=100;
		y=10;
	}
}
db.close();
db1.close();
%>