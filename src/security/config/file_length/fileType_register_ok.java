/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package security.config.file_length;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.io.*;
import include.nseer_db.*;

public class fileType_register_ok extends HttpServlet{
ServletContext application;
HttpSession session;
nseer_db_backup1 erp_db = null;

public synchronized void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{
PrintWriter out=response.getWriter();
nseer_db_backup1 document_db = new nseer_db_backup1(dbApplication);
if(document_db.conn((String)dbSession.getAttribute("unit_db_name"))){

String type_name=request.getParameter("type_name");
if(type_name.indexOf(".")==0)  type_name=type_name.substring(1);
if(type_name.indexOf("edx")!=-1||type_name.indexOf("dll")!=-1||type_name.indexOf("as")!=-1){
	response.sendRedirect("security/config/file_length/fileType_register_ok_c.jsp");
}else{

String sqll="select * from document_config_public_char where kind='附件类型' and type_name='"+type_name+"'";
ResultSet rs=document_db.executeQuery(sqll);
if(rs.next()){
response.sendRedirect("security/config/file_length/fileType_register_ok_a.jsp");
}else{
	  String sql = "insert into document_config_public_char(kind,type_name) values('附件类型','"+type_name+"')" ;
    	document_db.executeUpdate(sql) ;
response.sendRedirect("security/config/file_length/fileType_register_ok_b.jsp");
}

}
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
