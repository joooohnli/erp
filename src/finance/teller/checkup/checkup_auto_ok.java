/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package finance.teller.checkup;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import java.util.* ;
import include.nseer_db.*;

public class checkup_auto_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 finance_db = new nseer_db_backup1(dbApplication);

try{

if(finance_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String id_group=request.getParameter("id_group");
String id_group1=request.getParameter("id_group1");
String sql="";
StringTokenizer tk=new StringTokenizer(id_group,"◇");
while(tk.hasMoreTokens()){
 
  sql="update finance_voucher set checkup_tag='2' where id='"+tk.nextToken()+"'";
  finance_db.executeUpdate(sql);
}
StringTokenizer tk1=new StringTokenizer(id_group1,"◇");
while(tk1.hasMoreTokens()){
 
  sql="update finance_bill set checkup_tag='2' where id='"+tk1.nextToken()+"'";
  finance_db.executeUpdate(sql);
}

    finance_db.commit();
    finance_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}