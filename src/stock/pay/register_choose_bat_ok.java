/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package stock.pay;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;

public class register_choose_bat_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);

try{
if(stock_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String stock_ID=request.getParameter("stock_ID");
String product_ID=request.getParameter("product_ID");
String pay_ID=request.getParameter("pay_ID");
String[] serial_number_group=request.getParameterValues("serial_number");
String[] paid_amount=request.getParameterValues("paid_amount");
String serial_number="";
String amount_number="";
int p=0;
if(serial_number_group!=null){
for(int i=0;i<serial_number_group.length;i++){
	String sql2="select * from stock_balance_details_details where product_ID='"+product_ID+"' and stock_ID='"+stock_ID+"' and serial_number='"+serial_number_group[i]+"'";
	ResultSet rs2=stock_db.executeQuery(sql2);
	if(rs2.next()){
		if(!paid_amount[i].equals("")){
		if(Double.parseDouble(paid_amount[i])>rs2.getDouble("amount")){
			p++;
		}
		}
	}
}
if(p==0){
double amount=0.0d;
for(int i=0;i<serial_number_group.length;i++){
	if(!paid_amount[i].equals("")&&Double.parseDouble(paid_amount[i])!=0){
	serial_number+=serial_number_group[i];
	amount_number+=paid_amount[i]+", ";
		amount+=Double.parseDouble(paid_amount[i]);
	}
}
String sql="delete from stock_paying_temp where pay_ID='"+pay_ID+"' and product_ID='"+product_ID+"' and stock_ID='"+stock_ID+"'";
stock_db.executeUpdate(sql);

String sql1="insert into stock_paying_temp(pay_ID,product_ID,stock_ID,serial_number,amount_number,amount) values('"+pay_ID+"','"+product_ID+"','"+stock_ID+"','"+serial_number+"','"+amount_number+"','"+amount+"')";
stock_db.executeUpdate(sql1);
response.sendRedirect("stock/pay/register.jsp?pay_ID="+pay_ID+"");
}else{
response.sendRedirect("stock/pay/register_choose_bat_ok_b.jsp?product_ID="+product_ID+"&&stock_ID="+stock_ID+"&&pay_ID="+pay_ID+"");
}
}else{
response.sendRedirect("stock/pay/register_choose_bat_ok_c.jsp?product_ID="+product_ID+"&&stock_ID="+stock_ID+"&&pay_ID="+pay_ID+"");
}
stock_db.commit();
stock_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}