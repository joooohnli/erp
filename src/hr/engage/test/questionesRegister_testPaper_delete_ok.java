/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package hr.engage.test;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.io.*;
import include.nseer_cookie.*;
import include.nseer_db.*;

public class questionesRegister_testPaper_delete_ok extends HttpServlet{
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

String test_ID=request.getParameter("test_ID") ;
String first_kind_ID=request.getParameter("first_kind_ID");
String first_kind_name=request.getParameter("first_kind_name");
String second_kind_ID=request.getParameter("second_kind_ID");
String second_kind_name=request.getParameter("second_kind_name");

try{
	String sql = "delete from hr_test where test_ID='"+test_ID+"'" ;
	hr_db.executeUpdate(sql) ;
	String sql1="delete from hr_test_details where test_ID='"+test_ID+"'";
	hr_db.executeUpdate(sql1) ;
	String sql2="select * from hr_config_major_second_kind where first_kind_ID='"+first_kind_ID+"' and first_kind_name='"+first_kind_name+"' and second_kind_ID='"+second_kind_ID+"' and second_kind_name='"+second_kind_name+"'";
	ResultSet rs=hr_db.executeQuery(sql2) ;
	if(rs.next()){
		int test_amount=rs.getInt("test_amount")-1;
		String sql3="update hr_config_major_second_kind set test_amount='"+test_amount+"' where first_kind_ID='"+first_kind_ID+"' and first_kind_name='"+first_kind_name+"' and second_kind_ID='"+second_kind_ID+"' and second_kind_name='"+second_kind_name+"'";
		hr_db.executeUpdate(sql3) ;
	}	
}
catch (Exception ex) {
		out.println("error"+ex);
}	
 hr_db.commit();
 hr_db.close();
response.sendRedirect("hr/engage/test/questionesRegister_testPaper_delete_ok_a.jsp?first_kind_ID="+first_kind_ID+"&&first_kind_name="+toUtf8String.utf8String(exchange.toURL(first_kind_name))+"&&second_kind_ID="+second_kind_ID+"&&second_kind_name="+toUtf8String.utf8String(exchange.toURL(second_kind_name))+"");
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}


