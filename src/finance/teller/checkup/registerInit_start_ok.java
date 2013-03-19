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
import validata.ValidataNumber;

public class registerInit_start_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
PrintWriter out=response.getWriter();
ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 finance_db = new nseer_db_backup1(dbApplication);
ValidataNumber validata= new ValidataNumber();
try{

if(finance_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String file_id=request.getParameter("file_id");
String balance_sum=request.getParameter("balance_sum");
String balance_sum1=request.getParameter("balance_sum1");
if(validata.validata(balance_sum)&&validata.validata(balance_sum1)){
String sql2="select id from finance_bill where tag='1' and file_id='"+file_id+"'";
ResultSet rs2=finance_db.executeQuery(sql2);
String sql="";
if(rs2.next()){
	sql="update finance_bill set debit_subtotal='"+balance_sum1+"' where tag='1' and file_id='"+file_id+"'";
}else{

sql="insert into finance_bill(debit_subtotal,file_id,tag) values('"+balance_sum1+"','"+file_id+"','1')";
}
    finance_db.executeUpdate(sql);

	sql2="select id from finance_voucher where account_period='18' and chain_id='"+file_id+"'";
	rs2=finance_db.executeQuery(sql2);
if(rs2.next()){
	sql="update finance_voucher set debit_subtotal='"+balance_sum+"' where account_period='18' and chain_id='"+file_id+"'";
}else{

sql="insert into finance_voucher(debit_subtotal,chain_id,account_period) values('"+balance_sum+"','"+file_id+"','18')";
}
    finance_db.executeUpdate(sql);

    finance_db.commit();
    finance_db.close();
}else{
	out.println("1");
}
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}