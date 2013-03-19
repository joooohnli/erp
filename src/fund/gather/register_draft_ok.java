/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package fund.gather;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.util.*;
import java.io.*;
import java.text.*;

import include.nseer_cookie.GetWorkflow;
import include.nseer_db.*;
import validata.ValidataNumber;
import include.auto_execute.GatherSumLimit;
import include.auto_execute.GatherExpiry;
import purchase.Fieldvalue;

public class register_draft_ok extends HttpServlet{
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
nseer_db_backup1 crm_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);
ValidataNumber validata= new  ValidataNumber();
GatherSumLimit gatherSum= new  GatherSumLimit();
GatherExpiry gatherExpiry= new  GatherExpiry();
Fieldvalue fieldValue= new  Fieldvalue();
if(fund_db.conn((String)dbSession.getAttribute("unit_db_name"))&&crm_db.conn((String)dbSession.getAttribute("unit_db_name"))&&hr_db.conn((String)dbSession.getAttribute("unit_db_name"))){
java.util.Date  now  =  new  java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String fund_ID=request.getParameter("fund_ID");
String[] account_ID=request.getParameterValues("account_ID");
String[] subtotal=request.getParameterValues("subtotal");
int p=0;
for(int i=0;i<account_ID.length;i++){
	if(!subtotal[i].equals("")){
		String subtotal1="";
		StringTokenizer tokenTO = new StringTokenizer(subtotal[i],",");        
		while(tokenTO.hasMoreTokens()) {
			subtotal1+=tokenTO.nextToken();
		}
		if(!validata.validata(subtotal1)){
			p++;
		}
	}
}
if(p==0){
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String currency_name=request.getParameter("currency_name") ;
String personal_unit=request.getParameter("personal_unit") ;
String[] fund_chain_ID=request.getParameterValues("fund_chain_ID");
String[] fund_chain_name=request.getParameterValues("fund_chain_name");
String[] account_bank=request.getParameterValues("account_bank");
String[] cost_price_subtotal=request.getParameterValues("cost_price_subtotal") ;
String[] executed_cost_price_subtotal=request.getParameterValues("executed_cost_price_subtotal") ;
String[] execute_method=request.getParameterValues("execute_method");
String[] bill_ID=request.getParameterValues("bill_ID");
String[] details_number=request.getParameterValues("details_number");
int n=0;
for(int i=0;i<account_ID.length;i++){
	if(!subtotal[i].equals("")){
		String subtotal1="";
		StringTokenizer tokenTO = new StringTokenizer(subtotal[i],",");        
		while(tokenTO.hasMoreTokens()) {
			subtotal1+=tokenTO.nextToken();
		}
		String sql1="select * from fund_executing where fund_ID='"+fund_ID+"' and account_bank='"+account_bank[i]+"' and account_ID='"+account_ID[i]+"' and check_tag='0'";
		ResultSet rs1=fund_db.executeQuery(sql1);
		if(rs1.next()){
			n++;
		}			if(Math.abs(Double.parseDouble(subtotal1)+Double.parseDouble(executed_cost_price_subtotal[i]))>Math.abs(Double.parseDouble(cost_price_subtotal[i]))){
		n++;
		}
		if(bill_ID[i].indexOf("'")!=-1||bill_ID[i].indexOf("\"")!=-1||bill_ID[i].indexOf(",")!=-1){
		n++;
		}
	}
}
if(n==0){
try{

	int gather_time=0;
	String sql="select gather_time from fund_fund where fund_ID='"+fund_ID+"'";
	ResultSet rset=fund_db.executeQuery(sql);
	if(rset.next()){
		gather_time=rset.getInt("gather_time")+1;
	}
	double cost_price_sum=0.0d;
	for(int i=0;i<account_ID.length;i++){
	if(!subtotal[i].equals("")){
		String subtotaling="";
		StringTokenizer tokenTO = new StringTokenizer(subtotal[i],",");        
		while(tokenTO.hasMoreTokens()) {
			subtotaling+=tokenTO.nextToken();
		}
		sql="update fund_details set execute_details_tag='1',execute_check_tag='1' where fund_ID='"+fund_ID+"' and details_number='"+details_number[i]+"'";
		fund_db.executeUpdate(sql);
	
		String sql4="insert into fund_executing(fund_ID,fund_chain_ID,details_number,fund_chain_name,account_bank,account_ID,subtotal,cost_price_subtotal,register,register_time,executed_cost_price_subtotal,execute_method,bill_ID,currency_name,personal_unit,gather_time) values('"+fund_ID+"','"+fund_chain_ID[i]+"','"+details_number[i]+"','"+fund_chain_name[i]+"','"+account_bank[i]+"','"+account_ID[i]+"','"+subtotaling+"','"+cost_price_subtotal[i]+"','"+register+"','"+register_time+"','"+executed_cost_price_subtotal[i]+"','"+execute_method[i]+"','"+bill_ID[i]+"','"+currency_name+"','"+personal_unit+"','"+gather_time+"')";
		fund_db.executeUpdate(sql4);
		
	}
	}
	String sql2="update fund_fund set execute_tag='1',gather_time='"+gather_time+"',check_tag='5' where fund_ID='"+fund_ID+"'";
		fund_db.executeUpdate(sql2);
		
		response.sendRedirect("fund/gather/register_draft_ok.jsp?finished_tag=1");
}
catch (Exception ex){
ex.printStackTrace();
}
}else{
	
response.sendRedirect("fund/gather/register_draft_ok.jsp?finished_tag=3");

}}else{
		

response.sendRedirect("fund/gather/register_draft_ok.jsp?finished_tag=4");

}
fund_db.commit();
hr_db.commit();
crm_db.commit();
    fund_db.close();
	crm_db.close();
	hr_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
ex.printStackTrace();
}
}
}

