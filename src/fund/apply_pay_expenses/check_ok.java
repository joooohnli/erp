/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package fund.apply_pay_expenses;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.util.*;
import java.io.*;

import include.nseer_cookie.NseerId;
import include.nseer_cookie.exchange;
import include.nseer_db.*;
import java.text.*;
import include.nseer_cookie.counter;
import validata.ValidataRecordNumber;
import validata.ValidataTag;


public class check_ok extends HttpServlet{
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

nseer_db_backup1 fund_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 fund_db1 = new nseer_db_backup1(dbApplication);

if(fund_db.conn((String)dbSession.getAttribute("unit_db_name"))&&fund_db1.conn((String)dbSession.getAttribute("unit_db_name"))){

counter  count= new  counter(dbApplication);
ValidataRecordNumber vrn= new  ValidataRecordNumber();
ValidataTag  vt= new ValidataTag();

try{
String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
time=formatter.format(now);

String apply_pay_ID=request.getParameter("apply_pay_ID") ;
String config_id=request.getParameter("config_id");
String check_time=request.getParameter("check_time") ;
String checker=request.getParameter("checker") ;
String checker_ID=request.getParameter("checker_ID") ;
String bodyc = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyc);
String sql6="select id from fund_workflow where object_ID='"+apply_pay_ID+"' and ((check_tag='0' and config_id<'"+config_id+"') or (check_tag='1' and config_id='"+config_id+"'))";
ResultSet rs6=fund_db.executeQuery(sql6);
if(!rs6.next()){
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"fund_apply_pay","apply_pay_ID",apply_pay_ID,"check_tag").equals("0")){
String sql = "update fund_workflow set checker='"+checker+"',checker_ID='"+checker_ID+"',check_time='"+check_time+"',check_tag='1' where object_ID='"+apply_pay_ID+"' and config_id='"+config_id+"'" ;
	fund_db.executeUpdate(sql);
boolean flag=false;
sql="select id from fund_workflow where object_ID='"+apply_pay_ID+"' and check_tag='0'";
	ResultSet rset=fund_db.executeQuery(sql);
	if(!rset.next()){
		flag=true;
	}
if(flag){
	sql = "update fund_apply_pay set check_time='"+check_time+"',checker='"+checker+"',remark='"+remark+"',check_tag='1' where apply_pay_ID='"+apply_pay_ID+"'" ;
	fund_db.executeUpdate(sql) ;
}else{
	sql = "update fund_apply_pay set check_time='"+check_time+"',checker='"+checker+"',remark='"+remark+"' where apply_pay_ID='"+apply_pay_ID+"'" ;
	fund_db.executeUpdate(sql) ;
}
String currency_name="";
String personal_unit="";
String chain_ID="";
String chain_name="";
String funder="";
String funder_ID="";
String sql11="select * from fund_apply_pay where apply_pay_ID='"+apply_pay_ID+"'";
ResultSet rs11=fund_db.executeQuery(sql11) ;
while(rs11.next()){
	chain_ID=rs11.getString("chain_ID");
	chain_name=rs11.getString("chain_name");
	funder=rs11.getString("human_name");
	funder_ID=rs11.getString("human_ID");
	currency_name=rs11.getString("currency_name");
	personal_unit=rs11.getString("personal_unit");
}
int expenses_amount=0;
sql6="select count(*) from fund_apply_pay_details where apply_pay_ID='"+apply_pay_ID+"'";
rs6=fund_db.executeQuery(sql6) ;
if(rs6.next()){
expenses_amount=rs6.getInt("count(*)");
}
String sql1="select * from fund_apply_pay_details where apply_pay_ID='"+apply_pay_ID+"' order by details_number";
ResultSet rs1=fund_db1.executeQuery(sql1) ;
while(rs1.next()){
if(flag){	
if(vrn.validata((String)dbSession.getAttribute("unit_db_name"),"fund_fund","reasonexact",apply_pay_ID)<expenses_amount){
	String fund_ID=NseerId.getId("fund/pay",(String)dbSession.getAttribute("unit_db_name"));
	  
	String sql2="insert into fund_fund(fund_ID,reason,reasonexact,chain_ID,chain_name,funder,funder_ID,file_chain_ID,file_chain_name,demand_cost_price_sum,currency_name,personal_unit,register_time,register) values('"+fund_ID+"','付款','"+apply_pay_ID+"','"+chain_ID+"','"+chain_name+"','"+funder+"','"+funder_ID+"','"+rs1.getString("file_chain_ID")+"','"+rs1.getString("file_chain_name")+"','"+rs1.getString("cost_price_subtotal")+"','"+currency_name+"','"+personal_unit+"','"+check_time+"','"+checker+"')";
	
	fund_db.executeUpdate(sql2) ;
}
}
}
response.sendRedirect("fund/apply_pay_expenses/check_ok.jsp?finished_tag=0");
}else{
response.sendRedirect("fund/apply_pay_expenses/check_ok.jsp?finished_tag=1");
}
}else{
response.sendRedirect("fund/apply_pay_expenses/check_ok.jsp?finished_tag=2");
}
}
catch (Exception ex){
	ex.printStackTrace();
}
fund_db.commit();
fund_db1.commit();
fund_db.close();
	fund_db1.close();
	}else{
	response.sendRedirect("error_conn.htm");
}
}
catch(Exception ex){
	ex.printStackTrace();
}
}
}
