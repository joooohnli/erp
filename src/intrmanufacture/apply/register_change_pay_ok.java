/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package intrmanufacture.apply;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.io.*;
import include.nseer_db.*;
import include.nseer_cookie.counter;
import validata.ValidataNumber;

public class register_change_pay_ok extends HttpServlet{
//创建方法

ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{
HttpSession session=request.getSession();
PrintWriter out=response.getWriter();
counter  count=new  counter(dbApplication);
ValidataNumber  validata=new ValidataNumber();
nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);

if(stock_db.conn((String)dbSession.getAttribute("unit_db_name"))){

String pay_ID=request.getParameter("pay_ID") ;
String product_amount=request.getParameter("product_amount") ;
int num=Integer.parseInt(product_amount);
int p=0;
for(int i=1;i<=num;i++){
	String tem_apply_intrmanufacture_amount="apply_intrmanufacture_amount"+i;
String apply_intrmanufacture_amount=request.getParameter(tem_apply_intrmanufacture_amount) ;
if(apply_intrmanufacture_amount.equals("")) apply_intrmanufacture_amount="0";
if(!validata.validata(apply_intrmanufacture_amount)){
	p++;
}
}
if(p==0){
int n=0;
/*for(int i=1;i<=num;i++){
	String tem_amount="amount"+i;
	String tem_paid_amount="paid_amount"+i;
	String tem_apply_intrmanufacture_amount="apply_intrmanufacture_amount"+i;
String amount=request.getParameter(tem_amount) ;
String paid_amount=request.getParameter(tem_paid_amount) ;
String apply_intrmanufacture_amount=request.getParameter(tem_apply_intrmanufacture_amount) ;
if(apply_intrmanufacture_amount.equals("")) apply_intrmanufacture_amount="0";
	if(Double.parseDouble(apply_intrmanufacture_amount)+Double.parseDouble(paid_amount)>Double.parseDouble(amount)) n++;
}*/
if(n==0){
try{
double apply_intrmanufacture_amount_all=0.0d;
for(int i=1;i<=num;i++){
	String tem_apply_intrmanufacture_amount="apply_intrmanufacture_amount"+i;
String apply_intrmanufacture_amount=request.getParameter(tem_apply_intrmanufacture_amount) ;
if(apply_intrmanufacture_amount.equals("")) apply_intrmanufacture_amount="0";
	apply_intrmanufacture_amount_all+=Double.parseDouble(apply_intrmanufacture_amount);
	String sql1 = "update stock_pay_details set apply_intrmanufacture_amount='"+apply_intrmanufacture_amount+"' where pay_ID='"+pay_ID+"' and details_number='"+i+"'" ;
	stock_db.executeUpdate(sql1) ;
}
	String sql2 = "update stock_pay set apply_intrmanufacture_amount='"+apply_intrmanufacture_amount_all+"',apply_intrmanufacture_amount_tag='1' where pay_ID='"+pay_ID+"'" ;
	stock_db.executeUpdate(sql2) ;
}
catch (Exception ex){
out.println("error"+ex);
}

response.sendRedirect("intrmanufacture/apply/register_change_pay_ok_a.jsp");

}else{
response.sendRedirect("intrmanufacture/apply/register_change_pay_ok_b.jsp?pay_ID="+pay_ID+"");
}}else{
		
response.sendRedirect("intrmanufacture/apply/register_change_pay_ok_c.jsp?pay_ID="+pay_ID+"");
}
stock_db.commit();
stock_db.close();
}
else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}
