/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package stock.stock;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.*;
import validata.ValidataNumber;

public class gather_product_details_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);
counter count=new counter(dbApplication);
ValidataNumber validata=new ValidataNumber();

try{
	 
if(stock_db.conn((String)dbSession.getAttribute("unit_db_name"))){

String[] stock_name=request.getParameterValues("stock_name");
String[] amount=request.getParameterValues("amount");
String gather_ID=request.getParameter("gather_ID");
String product_ID=request.getParameter("product_ID");
String reason=request.getParameter("reason") ;
String reasonexact=request.getParameter("reasonexact") ;
String reasonexact_details=request.getParameter("reasonexact_details") ;
String product_name=request.getParameter("product_name");
String cost_price=request.getParameter("cost_price");
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String demand_amount=request.getParameter("demand_amount") ;
String gathered_amount=request.getParameter("gathered_amount") ;
String gathered_subtotal=request.getParameter("gathered_subtotal");
String[] stock_ID=request.getParameterValues("stock_ID");
String[] nick_name=request.getParameterValues("nick_name");
String[] max_capacity_amount=request.getParameterValues("max_capacity_amount");
String[] details_number=request.getParameterValues("details_number");
String[] available_amount=request.getParameterValues("available_amount");
int p=0;
for(int i=0;i<stock_name.length;i++){
	if(!amount[i].equals("")){
		if(!validata.validata(amount[i])){
			p++;
		}
	}
}
String sql8="select * from stock_gather_details where gather_ID='"+gather_ID+"' and product_ID='"+product_ID+"' and gather_tag='0'";
ResultSet rs8=stock_db.executeQuery(sql8);
if(rs8.next()){
if(p==0){

int n=0;
double amount_sum=0.0d;
for(int i=0;i<stock_name.length;i++){
	if(!amount[i].equals("")){
		amount_sum+=Double.parseDouble(amount[i]);
		if(Double.parseDouble(amount[i])>Double.parseDouble(available_amount[i])){
		n++;
	}
	}
}
if(n==0&&amount_sum==Double.parseDouble(demand_amount)){
String sqlll="update stock_gather_details set gather_tag='1' where gather_ID='"+gather_ID+"' and product_ID='"+product_ID+"'";
stock_db.executeUpdate(sqlll);
try{
		
String address_group="";
double amount1=Double.parseDouble(gathered_amount);
double subtotal1=Double.parseDouble(gathered_subtotal);
if(stock_name!=null){
	for(int i=0;i<stock_name.length;i++){
	if(!amount[i].equals("")&&Double.parseDouble(amount[i])!=0){
	double subtotal=Double.parseDouble(cost_price)*Double.parseDouble(amount[i]);
	amount1+=Double.parseDouble(amount[i]);
	subtotal1+=subtotal;
	String address=stock_name[i];
	address_group+=address+", ";
		String sql4="insert into stock_pre_gathering(gather_ID,product_ID,details_number,product_name,amount,ungather_amount,cost_price,subtotal,register,register_time,stock_ID,stock_name,max_capacity_amount,nick_name) values('"+gather_ID+"','"+product_ID+"','"+details_number[i]+"','"+product_name+"','"+amount[i]+"','"+amount[i]+"','"+cost_price+"','"+subtotal+"','"+register+"','"+register_time+"','"+stock_ID[i]+"','"+stock_name[i]+"','"+max_capacity_amount[i]+"','"+nick_name[i]+"')";
		stock_db.executeUpdate(sql4);
	}
	}
}
String sql="update stock_gather_details set address_group='"+address_group+"' where gather_ID='"+gather_ID+"' and product_ID='"+product_ID+"'";
stock_db.executeUpdate(sql);
String sql1="update stock_gather set gather_tag='1' where gather_ID='"+gather_ID+"'";
stock_db.executeUpdate(sql1);
if(reason.equals("采购入库")){
		String sql19="update purchase_details set stock_gather_tag='1' where purchase_ID='"+reasonexact+"' and provider_name='"+reasonexact_details+"'";
		stock_db.executeUpdate(sql19);
}
String sql16="select * from stock_gather_details where gather_ID='"+gather_ID+"' and gather_tag!='1'";
	ResultSet rs16=stock_db.executeQuery(sql16);
	if(!rs16.next()){
		String sql17="update stock_gather set gather_pre_tag='1' where gather_ID='"+gather_ID+"'";
		stock_db.executeUpdate(sql17);
response.sendRedirect("stock/stock/gather_product_details_ok_a.jsp");
}else{
response.sendRedirect("stock/stock/gather_product_details_ok_b.jsp?gather_ID="+gather_ID+"");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}else{
response.sendRedirect("stock/stock/gather_product_details_ok_c.jsp?gather_ID="+gather_ID+"&&product_ID="+product_ID+"&&reasonexact="+toUtf8String.utf8String(exchange.toURL(reasonexact))+"&&reason="+toUtf8String.utf8String(exchange.toURL(reason))+"&&reasonexact_details="+toUtf8String.utf8String(exchange.toURL(reasonexact_details)));
}}else{
response.sendRedirect("stock/stock/gather_product_details_ok_d.jsp?gather_ID="+gather_ID+"&&product_ID="+product_ID+"&&reasonexact="+toUtf8String.utf8String(exchange.toURL(reasonexact))+"&&reason="+toUtf8String.utf8String(exchange.toURL(reason))+"&&reasonexact_details="+toUtf8String.utf8String(exchange.toURL(reasonexact_details)));
}
}else{
response.sendRedirect("stock/stock/gather_product_details_ok_e.jsp?gather_ID="+gather_ID+"");
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