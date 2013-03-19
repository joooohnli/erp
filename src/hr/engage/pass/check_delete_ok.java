/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package hr.engage.pass;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.io.*;
import include.nseer_db.*;
import validata.ValidataTag;


public class check_delete_ok extends HttpServlet{
//创建方法
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
if(hr_db.conn((String)dbSession.getAttribute("unit_db_name"))){
ValidataTag vt= new  ValidataTag();

String details_number=request.getParameter("details_number");
String sql8="select * from hr_resume where details_number='"+details_number+"' and interview_tag='3' and pass_check_tag='1'";
ResultSet rs8 = hr_db.executeQuery(sql8) ;
	if(rs8.next()){
try{
	String sql = "update hr_resume set check_tag='0',interview_tag='0' where details_number='"+details_number+"'" ;
	hr_db.executeUpdate(sql) ;
}
catch (Exception ex) {
		out.println("error"+ex);
	}	
  	response.sendRedirect("hr/engage/pass/check_list.jsp");
}else{
response.sendRedirect("hr/engage/pass/check_delete_ok_a.jsp");
}
hr_db.commit();
hr_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}

