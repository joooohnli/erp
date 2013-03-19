/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package security.config.task;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*; 
import java.sql.* ;
import java.io.* ;
import include.nseer_db.*;
import validata.ValidataNumber;

public class taskRefresh_change_ok extends HttpServlet{

ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


nseer_db_backup1 security_db = new nseer_db_backup1(dbApplication);
ValidataNumber validata=new ValidataNumber();

try{

if(security_db.conn((String)dbSession.getAttribute("unit_db_name"))){

String task_refresh=request.getParameter("task_refresh");
if(validata.validata(task_refresh)&&Double.parseDouble(task_refresh) > 0){
String sqll="select * from security_taskcycle";
ResultSet rs=security_db.executeQuery(sqll);
if(rs.next()){
	String sql2="update security_taskcycle set refresh='"+task_refresh+"'";
	security_db.executeUpdate(sql2);
}else{
	String sql3="insert into security_taskcycle(refresh) values('"+task_refresh+"')";
	security_db.executeUpdate(sql3);
}

response.sendRedirect("security/config/task/taskRefresh_change_ok_a.jsp");
}else{
	
response.sendRedirect("security/config/task/taskRefresh_change_ok_b.jsp");
}
security_db.commit();
security_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
	catch (Exception ex) {
		ex.printStackTrace();
	}
}
}
