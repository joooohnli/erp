/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package document.module.main;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import include.nseer_db.*;
import include.nseer_cookie.*;
import java.io.*;
import java.util.*;
import java.text.*;
import com.jspsmart.upload.*;
import include.get_sql.getInsertSql;


public class change_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
try{
HttpSession session=request.getSession();
ServletContext context=session.getServletContext();
nseer_db_backup1 document_db = new nseer_db_backup1(dbApplication);
if(document_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String reason=request.getParameter("reason");
String main_picture=request.getParameter("main_picture");
String sql="update document_main set picture='"+main_picture+"' where reason='"+reason+"'";
document_db.executeUpdate(sql);
response.sendRedirect("erpPlatform/module/design_change.jsp?reason="+reason);
document_db.commit();
document_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
	ex.printStackTrace();
}
}
}