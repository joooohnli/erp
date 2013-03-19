/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package security.config.key;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;

public class key_register_ok extends HttpServlet{

ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


nseer_db_backup1 security_db = new nseer_db_backup1(dbApplication);
try{

if(security_db.conn((String)dbSession.getAttribute("unit_db_name"))){

String tablename=request.getParameter("tablename");
String[] cols=request.getParameterValues("col");

   if(cols==null){

response.sendRedirect("security/config/key/key_register_ok_a.jsp");
}else{
	String column_group="";
	for(int i=0;i<cols.length;i++){
		column_group+=cols[i]+",";
	}
	column_group=column_group.substring(0,column_group.length()-1);
	String sql1="select * from security_publicconfig_key where tablename='"+tablename+"'";
	ResultSet rs=security_db.executeQuery(sql1) ;
	if(rs.next()){
		String sql = "update security_publicconfig_key set column_group='"+column_group+"' where tablename='"+tablename+"'" ;
    	security_db.executeUpdate(sql) ;
	}else{
      String sql = "insert into security_publicconfig_key(tablename,column_group) values('"+tablename+"','"+column_group+"')" ;
    	security_db.executeUpdate(sql) ;
	}
	
response.sendRedirect("security/config/key/key_register_ok_b.jsp");
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