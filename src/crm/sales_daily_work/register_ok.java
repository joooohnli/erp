/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package crm.sales_daily_work;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.util.* ;
import java.io.*;

import include.nseer_cookie.NseerId;
import include.nseer_cookie.exchange;
import include.nseer_db.*;
import java.text.*;
import include.nseer_cookie.counter;

public class register_ok extends HttpServlet{
ServletContext application;
HttpSession session;
nseer_db_backup1 erp_db = null;

public synchronized void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


PrintWriter out=response.getWriter();
	nseer_db_backup1 crm_db = new nseer_db_backup1(dbApplication);
	 nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);
	try{
   
String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
time=formatter.format(now);

if(crm_db.conn((String)dbSession.getAttribute("unit_db_name"))&&hr_db.conn((String)dbSession.getAttribute("unit_db_name"))){
		counter  count= new  counter(dbApplication);

String human_ID=request.getParameter("human_ID") ;
String human_name=request.getParameter("human_name") ;
String register_time=request.getParameter("register_time") ;
String type=request.getParameter("type") ;
String daily_work_ID=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));
String content = new String(request.getParameter("content").getBytes("UTF-8"),"UTF-8");
String sql1="select * from hr_file where human_ID='"+human_ID+"'";
ResultSet rs1=hr_db.executeQuery(sql1);
if(rs1.next()){
	String sql2 = "insert into crm_sales_daily_work(daily_work_ID,chain_ID,chain_name,human_ID,human_name,register,register_time,type,content,check_tag,excel_tag) values ('"+daily_work_ID+"','"+rs1.getString("chain_ID")+"','"+rs1.getString("chain_name")+"','"+human_ID+"','"+human_name+"','"+human_name+"','"+register_time+"','"+type+"','"+content+"','0','2')" ;
	crm_db.executeUpdate(sql2) ;
}
crm_db.commit();
		hr_db.commit();
	crm_db.close();
		hr_db.close();
		response.sendRedirect("crm/sales_daily_work/register_ok_a.jsp");

}else{
	response.sendRedirect("error_conn.htm");
}
	}catch (Exception ex){
	ex.printStackTrace();
}
}
}