/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package hr.major_change;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*; 
import java.sql.*;
import java.io.*;
import include.nseer_cookie.exchange;
import include.nseer_db.*;

public class check_delete_ok extends HttpServlet{//创建方法
ServletContext application;
HttpSession session;


public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{
HttpSession session=request.getSession();
PrintWriter out=response.getWriter();
nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 hr_db1 = new nseer_db_backup1(dbApplication);
if(hr_db.conn((String)dbSession.getAttribute("unit_db_name"))&&hr_db1.conn((String)dbSession.getAttribute("unit_db_name"))){
String config_id=request.getParameter("config_id");
String major_time=request.getParameter("major_time");
String choice=request.getParameter("choice");
String human_ID=request.getParameter("human_ID");
String checker=request.getParameter("checker") ;
String check_time=request.getParameter("check_time") ;
String bodyb = new String(request.getParameter("remark2").getBytes("UTF-8"),"UTF-8");
String remark2=exchange.toHtml(bodyb);
String sql6="select id from hr_workflow where object_ID='"+human_ID+"' and major_time='"+major_time+"' and type_id='04' and ((check_tag='0' and config_id<'"+config_id+"') or (check_tag='1' and config_id='"+config_id+"'))";
ResultSet rs6=hr_db.executeQuery(sql6);
if(!rs6.next()){
	String sql8 = "select * from hr_major_change where human_ID='"+human_ID+"' and check_tag='0'" ;
	ResultSet rs8 = hr_db.executeQuery(sql8) ;
	if(rs8.next()){
try{
	if(choice!=null){
	if(choice.equals("")){
	String sql = "update hr_major_change set remark2='"+remark2+"',checker='"+checker+"',check_time='"+check_time+"',check_tag='9' where human_ID='"+human_ID+"' and major_time='"+major_time+"' and check_tag='0'" ;
	hr_db.executeUpdate(sql);
	sql = "delete from hr_workflow where object_ID='"+human_ID+"' and major_time='"+major_time+"' and type_id='04'" ;
		hr_db.executeUpdate(sql) ;
	}else{
	sql6="select id from hr_workflow where object_ID='"+human_ID+"' and major_time='"+major_time+"' and type_id='04' and config_id<'"+config_id+"' and config_id>='"+choice+"'";
	rs6=hr_db.executeQuery(sql6);
	while(rs6.next()){
		String sql = "update hr_workflow set check_tag='0' where id='"+rs6.getString("id")+"' and type_id='04'" ;
		hr_db1.executeUpdate(sql) ;
	}
	}
response.sendRedirect("hr/major_change/check_delete_ok.jsp?finished_tag=0");
}else{
response.sendRedirect("hr/major_change/check_delete_ok.jsp?finished_tag=1");
}

}
catch (Exception ex) {
		ex.printStackTrace();
	}	
  	//response.sendRedirect("hr/major_change/check_list.jsp");
}else{
	

response.sendRedirect("hr/major_change/check_delete_ok_a.jsp");
}
}else{
response.sendRedirect("hr/major_change/check_delete_ok.jsp?finished_tag=2");
}
 hr_db.commit();
 hr_db.close();
 hr_db1.commit();
 hr_db1.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}