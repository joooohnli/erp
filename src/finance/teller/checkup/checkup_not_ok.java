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
import finance.AccountPeriodTime;

public class checkup_not_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 finance_db = new nseer_db_backup1(dbApplication);
PrintWriter out=response.getWriter();
try{
AccountPeriodTime apt=new AccountPeriodTime();
String[] time=apt.getTime((String)dbSession.getAttribute("unit_db_name"));

if(finance_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String date_start=request.getParameter("date_start");
if(date_start.equals("")) date_start=time[0];
String date_end=request.getParameter("date_end");
if(date_end.equals("")) date_end=time[1];
String selected=request.getParameter("selected");
String select1="";
String select2="";
if(selected.equals("0")){
	select1="1";
	select2="2";
}else if(selected.equals("1")){
	select1="1";
	select2="1";
}else if(selected.equals("2")){
	select1="2";
	select2="2";
}
String id_group="◇";
String id_group1="◇";
String sql="select id from finance_voucher where register_time>='"+date_start+"' and register_time<='"+date_end+"' and (checkup_tag='"+select1+"' or checkup_tag='"+select2+"') and delete_tag='0'";
ResultSet rs=finance_db.executeQuery(sql);
while(rs.next()){
   id_group+=rs.getString("id")+"◇";
}
	sql="update finance_voucher set checkup_tag='0' where register_time>='"+date_start+"' and register_time<='"+date_end+"' and (checkup_tag='"+select1+"' or checkup_tag='"+select2+"') and delete_tag='0'";
		finance_db.executeUpdate(sql);

	 sql="select id from finance_bill where settle_time>='"+date_start+"' and settle_time<='"+date_end+"' and (checkup_tag='"+select1+"' or checkup_tag='"+select2+"') and delete_tag='0'";
	 rs=finance_db.executeQuery(sql);
while(rs.next()){
   id_group1+=rs.getString("id")+"◇";
}
	sql="update finance_bill set checkup_tag='0' where settle_time>='"+date_start+"' and settle_time<='"+date_end+"' and (checkup_tag='"+select1+"' or checkup_tag='"+select2+"') and delete_tag='0'";
		finance_db.executeUpdate(sql);

    finance_db.commit();
    finance_db.close();
String group=id_group+"□"+id_group1;
out.println(group);
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}