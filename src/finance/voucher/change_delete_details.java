/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package finance.voucher;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;

public class change_delete_details extends HttpServlet{

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

String id=request.getParameter("id");
String voucher_id=request.getParameter("voucher_id");
String debit_subtotal=request.getParameter("debit_subtotal");
String loan_subtotal=request.getParameter("loan_subtotal");
	
	String sql="delete from finance_voucher_details where id='"+id+"'";
	finance_db.executeUpdate(sql) ;
	String sql2="select * from finance_voucher where id='"+voucher_id+"'";
	ResultSet rs2=finance_db.executeQuery(sql2);
	if(rs2.next()){
		double debit_sum=rs2.getDouble("debit_sum")-Double.parseDouble(debit_subtotal);
		double loan_sum=rs2.getDouble("loan_sum")-Double.parseDouble(loan_subtotal);
		String sql1="update finance_voucher set debit_sum='"+debit_sum+"',loan_sum='"+loan_sum+"',check_tag='0',change_tag='1' where id='"+voucher_id+"'";
	finance_db.executeUpdate(sql1) ;
	}
finance_db.commit();
finance_db.close();

response.sendRedirect("finance/voucher/change.jsp?id="+voucher_id+"");
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}