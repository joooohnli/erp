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

public class check_no_ok extends HttpServlet{
ServletContext application;
HttpSession session;
nseer_db_backup1 erp_db = null;

public synchronized void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{

HttpSession session=request.getSession();

PrintWriter out=response.getWriter();
nseer_db_backup1 crm_db = new nseer_db_backup1(dbApplication);
if(crm_db.conn((String)dbSession.getAttribute("unit_db_name"))){

String order_ID = request.getParameter("order_ID") ;
try{
	String sql = "update crm_order set accomplish_tag='0',accomplish_time='' where order_ID='"+order_ID+"'";
	crm_db.executeUpdate(sql) ;

}
catch (Exception ex) {
		out.println("error"+ex);
	}	
  	response.sendRedirect("crm/accomplish/check_list.jsp");
crm_db.commit();
crm_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}