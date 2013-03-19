/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package finance.account;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;
import java.text.*;

public class periodFinish_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 finance_db = new nseer_db_backup1(dbApplication);

try{
String account_period=request.getParameter("account_period");
String account_finished_time=request.getParameter("timea");
if(finance_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String sql = "select * from finance_voucher where check_tag='0' and account_period='"+account_period+"'" ;
ResultSet rs = finance_db.executeQuery(sql) ;
if(!rs.next()){
	sql = "select * from finance_voucher where check_tag='1' and account_tag='0' and account_period='"+account_period+"'" ;
	rs = finance_db.executeQuery(sql) ;
	if(!rs.next()){
		sql="select * from finance_voucher where account_tag='1' and profit_or_cost='0' and cost_tag='0' and account_period='"+account_period+"'";
		rs=finance_db.executeQuery(sql);
		if(!rs.next()){
			sql="select * from finance_voucher where account_tag='1' and (profit_or_cost='1' or profit_or_cost='0') and profit_tag='0' and account_period='"+account_period+"'";
			rs=finance_db.executeQuery(sql);
			if(!rs.next()){
			sql="update finance_account_period set account_finished_tag='1',account_finished_time='"+account_finished_time+"' where account_period='"+account_period+"'";
			finance_db.executeUpdate(sql);
	response.sendRedirect("finance/account/periodFinish_ok_a.jsp");
}else{
	response.sendRedirect("finance/account/periodFinish.jsp");
}
}else{
	response.sendRedirect("finance/account/periodFinish.jsp");
}
}else{
	response.sendRedirect("finance/account/periodFinish.jsp");
}
}else{
	response.sendRedirect("finance/account/periodFinish.jsp");
}
finance_db.commit();
finance_db.close();
}else{
	response.sendRedirect("/error_conn.htm");
}
}catch(Exception ex){
	ex.printStackTrace();
}
}
}