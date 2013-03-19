/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package crm.config.file;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.io.*;
import include.nseer_db.*;

public class strategyClass_register_ok extends HttpServlet{
ServletContext application;
HttpSession session;
nseer_db_backup1 erp_db = null;

public synchronized void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{
nseer_db_backup1 crm_db = new nseer_db_backup1(dbApplication);
if(crm_db.conn((String)dbSession.getAttribute("unit_db_name"))){

PrintWriter out=response.getWriter();
String type_name=request.getParameter("type_name");
String sqll="select * from crm_config_public_char where kind='客户级别' and type_name='"+type_name+"'";
ResultSet rs=crm_db.executeQuery(sqll);
if(rs.next()){

response.sendRedirect("crm/config/file/strategyClass_register_ok_a.jsp");

}else{
  String sql = "insert into crm_config_public_char(kind,type_name) values('客户级别','"+type_name+"')" ;
   crm_db.executeUpdate(sql) ;
response.sendRedirect("crm/config/file/strategyClass_register_ok_b.jsp");

}
crm_db.commit();
crm_db.close();

}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}