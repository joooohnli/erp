/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package hr.engage.questiones;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*; 
import java.io.*;
import include.nseer_db.*;

public class change_delete_ok extends HttpServlet{
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
String id=request.getParameter("id") ;
try{
	String sql = "delete from hr_questiones where id='"+id+"'" ;
	hr_db.executeUpdate(sql) ;
	hr_db.commit();
hr_db.close();
}
catch (Exception ex) {
		out.println("error"+ex);
	}	
  	response.sendRedirect("hr/engage/questiones/change_list.jsp");
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}
