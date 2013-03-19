/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package hr.config.file;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;  
import java.sql.*;
import java.io.* ;
import include.nseer_db.*;

public class title_delete_ok extends HttpServlet{
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
int i;
int intRowCount;
String sqll = "select * from hr_config_public_char where kind='职称' order by type_ID" ;
ResultSet rs=hr_db.executeQuery(sqll) ;
rs.next();
rs.last();
intRowCount=rs.getRow();
String[] del=new String[intRowCount];
del=(String[])session.getAttribute("del");
if(del!=null){
for(i=1;i<=intRowCount;i++){
try{
	if(del[i-1]!=null){
	String sql = "delete from hr_config_public_char where id='"+del[i-1]+"'" ;
    hr_db.executeUpdate(sql) ;
	}
	}
	catch (Exception ex) {
		out.println("error"+ex);
	}
	}
}
hr_db.commit();
hr_db.close();

response.sendRedirect("hr/config/file/title.jsp");
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}