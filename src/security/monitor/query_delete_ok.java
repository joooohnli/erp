/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package security.monitor;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.exchange;
import java.text.*;

public class query_delete_ok extends HttpServlet{

ServletContext application;

public void init(ServletConfig config) throws ServletException{
	application = config.getServletContext();
} 

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


HttpSession session=request.getSession();

nseer_db_backup1 security_db = new nseer_db_backup1(dbApplication);

try{

if(security_db.conn((String)dbSession.getAttribute("unit_db_name"))){

String human_ID=request.getParameter("human_ID");
String name=exchange.unURL(request.getParameter("name"));
application.removeAttribute(name+"c");
	String sql1="update security_users set forbid_tag='1',tag='0' where human_ID='"+human_ID+"'";
	security_db.executeUpdate(sql1);
java.util.Date  now  =  new  java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String sql2="select * from security_alive_access where editor='"+name+"' order by time1 desc";
ResultSet rs2=security_db.executeQuery(sql2);
if(rs2.next()){
String sql="update security_alive_access set time2='"+time+"',tag='1' where id='"+rs2.getString("id")+"'";
security_db.executeUpdate(sql);
}
security_db.commit();
security_db.close();	
  	response.sendRedirect("security/monitor/query_delete_ok_a.jsp?human_ID="+human_ID+"");
}else{
	response.sendRedirect("error_conn.htm");
	}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}