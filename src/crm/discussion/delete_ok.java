/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package crm.discussion;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import java.io.* ;
import include.nseer_db.*;

public class delete_ok extends HttpServlet{
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
PrintWriter out=response.getWriter();
if(crm_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String id = request.getParameter("id") ;
String discussion_ID="";
try{
	String sql = "select * from crm_discussion where id='"+id+"'";
	ResultSet rs=crm_db.executeQuery(sql);
	if(rs.next()){
		discussion_ID=rs.getString("discussion_ID");
	}
	String sql1="delete from crm_discussion_details where discussion_ID='"+discussion_ID+"'";
	crm_db.executeUpdate(sql1) ;
	String sql2="delete from crm_discussion where id='"+id+"'";
	crm_db.executeUpdate(sql2) ;

}
catch (Exception ex) {
		out.println("error"+ex);
	}
	crm_db.commit();
	crm_db.close();
  	response.sendRedirect("crm/discussion/delete_list.jsp");
}else{
	response.sendRedirect("error_conn.htm");
}
}catch (Exception ex) {}
}
}