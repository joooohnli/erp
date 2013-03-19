/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package crm.config.intranalyse;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*; 
import java.sql.*;
import java.io.*;
import include.nseer_db.*;
import include.nseer_cookie.*;


public class orderRate_change_ok extends HttpServlet{
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
nseer_db_backup1 security_db = new nseer_db_backup1(dbApplication);
counter count= new counter(dbApplication);
if(security_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String human_ID=request.getParameter("human_ID");
String human_name=exchange.unURL(request.getParameter("human_name"));
String order_discount=request.getParameter("order_discount");
order_discount=order_discount.replaceAll(",", "");
String sqll="select * from security_users where human_ID='"+human_ID+"'";
ResultSet rs=security_db.executeQuery(sqll);
if(!rs.next()){

response.sendRedirect("crm/config/intranalyse/orderRate_change_ok_a.jsp");

}else{
String sql2="update security_users set order_discount='"+order_discount+"' where human_ID='"+human_ID+"'";
security_db.executeUpdate(sql2);


response.sendRedirect("crm/config/intranalyse/orderRate_change_ok_b.jsp");


}
security_db.commit();
security_db.close();

}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}




