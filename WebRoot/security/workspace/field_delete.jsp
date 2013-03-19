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
nseer_db_backup db = new nseer_db_backup(application);
nseer_db_backup db1 = new nseer_db_backup(application);
if(db.conn((String)session.getAttribute("unit_db_name"))&&db1.conn((String)session.getAttribute("unit_db_name"))){
String human_ID=(String)session.getAttribute("human_IDD");
String divpara=request.getParameter("div") ;
String id=request.getParameter("id") ;
if(id.equals("")){
StringTokenizer token=new StringTokenizer(divpara,",");
int x1=0;
int x2=0;
int y1=0;
int y2=0;
String sql="";
String sql1="";
int xp1=0;
int yp1=0;
ResultSet rs=null;
while(token.hasMoreTokens()){
x1=Integer.parseInt(token.nextToken());
x2=Integer.parseInt(token.nextToken());
y1=Integer.parseInt(token.nextToken());
y2=Integer.parseInt(token.nextToken());
}

		sql="select id,drag_img_top,drag_img_left from drag_img where human_ID='"+human_ID+"'";
		rs=db.executeQuery(sql);
		while(rs.next()){
			if(rs.getString("drag_img_top").indexOf("px")!=-1){
				xp1=Integer.parseInt(rs.getString("drag_img_top").substring(0,rs.getString("drag_img_top").indexOf("px")));
			}else{
				xp1=Integer.parseInt(rs.getString("drag_img_top"));
			}
			if(rs.getString("drag_img_left").indexOf("px")!=-1){
				yp1=Integer.parseInt(rs.getString("drag_img_left").substring(0,rs.getString("drag_img_left").indexOf("px")));
			}else{
				yp1=Integer.parseInt(rs.getString("drag_img_left"));
			}
			if((xp1>=y1&&xp1<=y2)&&(yp1>=x1&&yp1<=x2)){
			sql1="delete from drag_img where id='"+rs.getString("id")+"'";
			db1.executeUpdate(sql1);
			}
		}
}else{
StringTokenizer token=new StringTokenizer(id,",");
while(token.hasMoreTokens()){

String sql="delete from drag_img where img_id='"+token.nextToken()+"' and human_ID='"+human_ID+"'";
db.executeUpdate(sql);
}
}
db.close();
db1.close();

}else{
	response.sendRedirect("error_conn.htm");
}
%>