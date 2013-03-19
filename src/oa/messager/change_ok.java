/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package oa.messager;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import include.nseer_db.*;
import java.io.*;

public class change_ok extends HttpServlet{

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

String changer = request.getParameter("changer");
String changer_ID = request.getParameter("changer_ID");
String change_time = request.getParameter("change_time");
String content = request.getParameter("content");
String messager_type = request.getParameter("messager_type");
String tool_type = request.getParameter("tool_type");
String id = request.getParameter("id");
	String sql = "update oa_messager set changer='"+changer+"',changer_ID='"+changer_ID+"',change_time='"+change_time+"',content='"+content+"',type='"+messager_type+"',tool_type='"+tool_type+"' where id='"+id+"'";
	oa_db.executeUpdate(sql) ;
	oa_db.commit();
	oa_db.close();
response.sendRedirect("oa/messager/change_ok_b.jsp");
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){ex.printStackTrace();}
}
}