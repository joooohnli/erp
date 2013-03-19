/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package oa.planing;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import include.nseer_db.*;
import java.io.*;

public class check_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


try{
//实例化

HttpSession session=request.getSession();
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
nseer_db_backup1 oa_db = new nseer_db_backup1(dbApplication);
if(oa_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String config_id = request.getParameter("config_id");
String check_time = request.getParameter("check_time");
String checker = request.getParameter("checker");
String checker_ID = request.getParameter("checker_ID");
String planing_ID = request.getParameter("planing_ID");
String sql1="select * from oa_planing where planing_ID='"+planing_ID+"' and check_tag='0'";
ResultSet rs=oa_db.executeQuery(sql1);
if(!rs.next()){
	
	response.sendRedirect("oa/planing/check_ok_a.jsp");
}else{	

String sql = "update oa_workflow set checker='"+checker+"',checker_ID='"+checker_ID+"',check_time='"+check_time+"',check_tag='1' where object_ID='"+planing_ID+"' and type_id='01' and config_id='"+config_id+"'" ;
	oa_db.executeUpdate(sql);
	sql="select id from oa_workflow where object_ID='"+planing_ID+"' and type_id='01' and check_tag='0'";
	ResultSet rset=oa_db.executeQuery(sql);
if(!rset.next()){

sql = "update oa_planing set checker='"+checker+"',checker_ID='"+checker_ID+"',check_time='"+check_time+"',check_tag='1' where planing_ID='"+planing_ID+"'";
	oa_db.executeUpdate(sql) ;
	
}

response.sendRedirect("oa/planing/check_ok_b.jsp");
}
oa_db.commit();
oa_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}

}catch(Exception ex){ex.printStackTrace();}
}
}