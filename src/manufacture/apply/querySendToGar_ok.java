/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package manufacture.apply;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;

import include.nseer_db.*;

public class querySendToGar_ok extends HttpServlet{

ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
nseer_db_backup1 manufacture_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 manufacture_db1 = new nseer_db_backup1(dbApplication);

PrintWriter out=response.getWriter();
try{
if(manufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))&&manufacture_db1.conn((String)dbSession.getAttribute("unit_db_name"))){
String tableName=request.getParameter("tableName");
String ids_str=request.getParameter("ids_str");
String[] value1=ids_str.split("⊙");
for(int i=0;i<value1.length;i++){
	String id=value1[i];
	String sql1="select apply_ID from "+tableName+" where apply_ID='"+id+"'";
	ResultSet rs=manufacture_db.executeQuery(sql1);
	while(rs.next()){
		sql1="update "+tableName+" set gar_tag='1' where apply_ID='"+id+"'";
			manufacture_db1.executeUpdate(sql1);
	}
}
out.println("1");
manufacture_db.commit();
manufacture_db1.commit();
manufacture_db.close();
manufacture_db1.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
		ex.printStackTrace();
	}
}
}