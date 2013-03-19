/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package crm.accomplish;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;


public class register_ok extends HttpServlet{
ServletContext application;
HttpSession session;
nseer_db_backup1 erp_db = null;

public synchronized void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{

PrintWriter out=response.getWriter();//实例化out
HttpSession session=request.getSession();
nseer_db_backup1 crm_db = new nseer_db_backup1(dbApplication);
if(crm_db.conn((String)dbSession.getAttribute("unit_db_name"))){

String order_ID = request.getParameter("order_ID") ;
String accomplish_time = request.getParameter("accomplish_time") ;
String accomplish_register = request.getParameter("accomplish_register") ;
String accomplish_register_ID = request.getParameter("accomplish_register_ID") ;
try{
	String sql = "update crm_order set accomplish_tag='1',accomplish_time='"+accomplish_time+"',accomplish_register='"+accomplish_register+"',accomplish_register_ID='"+accomplish_register_ID+"' where order_ID='"+order_ID+"'";
	crm_db.executeUpdate(sql) ;

}
catch (Exception ex) {
		out.println("error"+ex);
	}	
  	response.sendRedirect("crm/accomplish/register_list.jsp");

crm_db.commit();
crm_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}