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

public class delete_reconfirm extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
PrintWriter out=response.getWriter();
ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 finance_db = new nseer_db_backup1(dbApplication);
try{

if(finance_db.conn((String)dbSession.getAttribute("unit_db_name"))){
	String account_init_time="";
	double last_balance=0.0d;
	double last_balance1=0.0d;
	double current_balance=0.0d;
double current_balance1=0.0d;
	String file_id=request.getParameter("sTa");
	String sql = "select type_name from finance_config_public_char where kind='账务初始时间'";
	ResultSet rs = finance_db.executeQuery(sql) ;
	if(rs.next()){
		account_init_time=rs.getString("type_name");   
	}
    sql = "select debit_subtotal from finance_voucher where chain_id='"+file_id+"' and account_period='18'" ;
	rs = finance_db.executeQuery(sql) ;
	if(rs.next()){
		last_balance=rs.getDouble("debit_subtotal");
	}
	sql = "select debit_subtotal,loan_subtotal from finance_voucher where chain_id='"+file_id+"' and register_time>='"+account_init_time+"' and account_tag='1'" ;
	rs = finance_db.executeQuery(sql) ;
	while(rs.next()){
		last_balance+=rs.getDouble("debit_subtotal")-rs.getDouble("loan_subtotal");
	}
    sql = "select debit_subtotal from finance_bill where file_id='"+file_id+"' and tag='1'" ;
	  rs = finance_db.executeQuery(sql) ;
	if(rs.next()){
		last_balance1=rs.getDouble("debit_subtotal");
	}
	sql = "select debit_subtotal,loan_subtotal from finance_bill where file_id='"+file_id+"' and settle_time>='"+account_init_time+"'" ;
	rs = finance_db.executeQuery(sql) ;
	while(rs.next()){
		last_balance1+=rs.getDouble("debit_subtotal")-rs.getDouble("loan_subtotal");
	}
current_balance=last_balance;
sql = "select debit_subtotal,loan_subtotal from finance_bill where file_id='"+file_id+"' and checkup_tag='0' and tag!='1'" ;
rs = finance_db.executeQuery(sql) ;
while(rs.next()){
	current_balance+=rs.getDouble("debit_subtotal")-rs.getDouble("loan_subtotal");
}

current_balance1=last_balance1;
sql = "select debit_subtotal,loan_subtotal from finance_voucher where chain_id='"+file_id+"' and checkup_tag='0' and (account_period='19' or account_tag='1')" ;
	  rs = finance_db.executeQuery(sql) ;
while(rs.next()){
	current_balance1+=rs.getDouble("debit_subtotal")-rs.getDouble("loan_subtotal");
}
	if(current_balance == current_balance1){
    out.println("0");
	}else{
	out.println("1");
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