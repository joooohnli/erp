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
import java.io.* ;
import include.nseer_db.*;
import java.text.*;
import validata.ValidataNumber;
import include.auto_execute.GatherSumLimit;
import include.auto_execute.GatherExpiry;
import purchase.Fieldvalue;

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
nseer_db_backup1 crm_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);
if(fund_db.conn((String)dbSession.getAttribute("unit_db_name"))&&crm_db.conn((String)dbSession.getAttribute("unit_db_name"))&&hr_db.conn((String)dbSession.getAttribute("unit_db_name"))){

ValidataNumber validata= new  ValidataNumber();
GatherSumLimit gatherSum= new  GatherSumLimit();
GatherExpiry gatherExpiry= new  GatherExpiry();
Fieldvalue fieldValue= new  Fieldvalue();

java.util.Date  now  =  new  java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String fund_ID=request.getParameter("fund_ID");
String config_id=request.getParameter("config_id");
String gather_time=request.getParameter("gather_time");
String checker=request.getParameter("checker") ;
String checker_ID=request.getParameter("checker_ID") ;
String check_time=request.getParameter("check_time") ;
String currency_name=request.getParameter("currency_name") ;
String personal_unit=request.getParameter("personal_unit") ;
String[] id=request.getParameterValues("id") ;
String[] fund_chain_ID=request.getParameterValues("fund_chain_ID");
String[] fund_chain_name=request.getParameterValues("fund_chain_name");
String[] account_bank=request.getParameterValues("account_bank");
String[] account_ID=request.getParameterValues("account_ID");
String[] cost_price_subtotal=request.getParameterValues("cost_price_subtotal") ;
String[] executed_cost_price_subtotal=request.getParameterValues("executed_cost_price_subtotal") ;
String[] execute_method=request.getParameterValues("execute_method");
String[] bill_ID=request.getParameterValues("bill_ID");
String[] subtotal=request.getParameterValues("subtotal");
String[] details_number=request.getParameterValues("details_number");
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
		if(bill_ID[i].indexOf("'")!=-1||bill_ID[i].indexOf("\"")!=-1||bill_ID[i].indexOf(",")!=-1){
		p++;
		}
	}
}
String sql6="select id from fund_workflow where object_ID='"+fund_ID+"' and gather_time='"+gather_time+"' and ((check_tag='0' and config_id<'"+config_id+"') or (check_tag='1' and config_id='"+config_id+"'))";
ResultSet rs6=fund_db.executeQuery(sql6);
if(!rs6.next()){
if(p==0){
int n=0;
	String account_ID_control=account_ID[0];
	String account_ID_control1=fund_chain_ID[0];
	double fund_control=0.0d;
for(int i=0;i<account_ID.length;i++){
	if(!subtotal[i].equals("")){
		String subtotal1="";
		StringTokenizer tokenTO = new StringTokenizer(subtotal[i],",");        
		while(tokenTO.hasMoreTokens()) {
			subtotal1+=tokenTO.nextToken();
		}
if(Math.abs(Double.parseDouble(subtotal1)+Double.parseDouble(executed_cost_price_subtotal[i]))>Math.abs(Double.parseDouble(cost_price_subtotal[i]))){
		n++;
		}
	if(account_ID[i].equals(account_ID_control)&&fund_chain_ID[i].equals(account_ID_control1)){
		fund_control+=Double.parseDouble(subtotal1);
		if(Math.abs(fund_control+Double.parseDouble(executed_cost_price_subtotal[i]))>Math.abs(Double.parseDouble(cost_price_subtotal[i]))){
		n++;
		}
		}else{
		account_ID_control=account_ID[i];
		account_ID_control1=fund_chain_ID[i];
		fund_control=Double.parseDouble(subtotal1);
		}
	}
}
if(n==0){
String sql8="select * from fund_executing where fund_ID='"+fund_ID+"' and check_tag='0' and gather_time='"+gather_time+"' order by details_number";
	ResultSet rs8=fund_db.executeQuery(sql8);
	if(rs8.next()){
boolean flag=false; 
sql8 = "update fund_workflow set checker='"+checker+"',checker_ID='"+checker_ID+"',check_time='"+check_time+"',check_tag='1' where object_ID='"+fund_ID+"' and config_id='"+config_id+"' and gather_time='"+gather_time+"'" ;
	fund_db.executeUpdate(sql8);
sql8="select id from fund_workflow where object_ID='"+fund_ID+"' and gather_time='"+gather_time+"' and check_tag='0'";
	rs8=fund_db.executeQuery(sql8);
	if(!rs8.next()){
		flag=true;
	}
try{
if(flag){
for(int i=0;i<account_ID.length;i++){
		String sql4="update fund_executing set check_tag='1' where id='"+id[i]+"' and check_tag='0'";
		fund_db.executeUpdate(sql4);
	}
}
double cost_price_sum=0.0d;
for(int i=0;i<account_ID.length;i++){
	if(subtotal[i].equals("")) subtotal[i]="0";
		String subtotaling="";
		StringTokenizer tokenTO = new StringTokenizer(subtotal[i],",");        
		while(tokenTO.hasMoreTokens()) {
			subtotaling+=tokenTO.nextToken();
		}
	if(Double.parseDouble(subtotaling)!=0){
	cost_price_sum+=Double.parseDouble(subtotaling);
		String sql4="update fund_executing set subtotal='"+subtotaling+"',checker='"+checker+"',check_time='"+check_time+"',execute_method='"+execute_method[i]+"',bill_ID='"+bill_ID[i]+"' where id='"+id[i]+"'";
		fund_db.executeUpdate(sql4);
		if(flag){
		String sql11="select * from fund_details where fund_ID='"+fund_ID+"' and details_number='"+details_number[i]+"'";
		ResultSet rs11=fund_db.executeQuery(sql11);
		if(rs11.next()){
			double subtotal5=rs11.getDouble("executed_cost_price_subtotal")+Double.parseDouble(subtotaling);
			if(rs11.getDouble("cost_price_subtotal")==subtotal5){
				String sql="update fund_details set executed_cost_price_subtotal='"+subtotal5+"',execute_details_tag='2',execute_check_tag='0' where fund_ID='"+fund_ID+"' and details_number='"+details_number[i]+"'";
				fund_db.executeUpdate(sql);
			}else{
				String sql12="update fund_details set executed_cost_price_subtotal='"+subtotal5+"',execute_check_tag='0' where fund_ID='"+fund_ID+"' and details_number='"+details_number[i]+"'";
				fund_db.executeUpdate(sql12);
			}
		}
		}
	}else if(Double.parseDouble(subtotaling)==0){

		String sql44="delete from fund_executing where id='"+id[i]+"'";
		fund_db.executeUpdate(sql44);
		if(flag){
		String sql11="select * from fund_details where fund_ID='"+fund_ID+"' and details_number='"+details_number[i]+"'";
		ResultSet rs11=fund_db.executeQuery(sql11);
		if(rs11.next()){
			double subtotal5=rs11.getDouble("executed_cost_price_subtotal")+Double.parseDouble(subtotaling);
			if(rs11.getDouble("cost_price_subtotal")==subtotal5){
				String sql="update fund_details set executed_cost_price_subtotal='"+subtotal5+"',execute_details_tag='2',execute_check_tag='0' where fund_ID='"+fund_ID+"' and details_number='"+details_number[i]+"'";
				fund_db.executeUpdate(sql);
			}else{
				String sql12="update fund_details set executed_cost_price_subtotal='"+subtotal5+"',execute_check_tag='0' where fund_ID='"+fund_ID+"' and details_number='"+details_number[i]+"'";
				fund_db.executeUpdate(sql12);
			}
		}
		}
	}
}

if(flag){
String apply_ID_group="";
String sql18="select * from fund_fund where fund_ID='"+fund_ID+"'"; 
	ResultSet rs18=fund_db.executeQuery(sql18);
	if(rs18.next()){
		apply_ID_group=rs18.getString("apply_ID_group");
		double subtotal7=rs18.getDouble("executed_cost_price_sum")+cost_price_sum;
		String sql19="update fund_fund set executed_cost_price_sum='"+subtotal7+"',checker='"+checker+"',check_time='"+check_time+"' where fund_ID='"+fund_ID+"'";
		fund_db.executeUpdate(sql19);
	}
gatherSum.cost(dbApplication);
	String sql16="select * from fund_details where fund_ID='"+fund_ID+"' and execute_details_tag!='2'";
	ResultSet rs16=fund_db.executeQuery(sql16);
	if(!rs16.next()){
		StringTokenizer tokenTO1 = new StringTokenizer(apply_ID_group,", ");        
		while(tokenTO1.hasMoreTokens()) {
		String order_ID=tokenTO1.nextToken();
		String sql20="update crm_order set gather_tag='3' where order_ID='"+order_ID+"'";
		crm_db.executeUpdate(sql20);
String sales_ID=fieldValue.getValue((String)dbSession.getAttribute("unit_db_name"),"crm_order","order_ID",order_ID,"sales_ID");
double order_profit_bonus_sum=Double.parseDouble(fieldValue.getValue((String)dbSession.getAttribute("unit_db_name"),"crm_order","order_ID",order_ID,"order_profit_bonus_sum"));
double order_sale_bonus_sum=Double.parseDouble(fieldValue.getValue((String)dbSession.getAttribute("unit_db_name"),"crm_order","order_ID",order_ID,"order_sale_bonus_sum"));


		String sale_bonus_type="";
String sql_hr2="select * from hr_config_public_char where kind='订单销售绩效计算方式'"; 
   ResultSet rs_hr2=hr_db.executeQuery(sql_hr2);
if(rs_hr2.next()){ sale_bonus_type=rs_hr2.getString("type_name");
}
double sale_bonus_sum=0.0d;
String sql_hr1="select * from hr_file where human_ID='"+sales_ID+"'"; 
ResultSet rs_hr1=hr_db.executeQuery(sql_hr1);
if(rs_hr1.next()){if(sale_bonus_type.equals("按毛利润计算")){
	


	sale_bonus_sum=rs_hr1.getDouble("sale_bonus_sum")+order_profit_bonus_sum;
	}else{	sale_bonus_sum=rs_hr1.getDouble("sale_bonus_sum")+order_sale_bonus_sum;
	}
String sql_hr="update hr_file set sale_bonus_sum='"+sale_bonus_sum+"' where human_ID='"+sales_ID+"'";
hr_db.executeUpdate(sql_hr);
}
		String sql21="select * from crm_order where gather_tag='3' and invoice_tag='3' and logistics_tag='3' and receive_tag='3' and pay_tag='3' and check_tag='1' and order_ID='"+order_ID+"'";
		ResultSet rs21=crm_db.executeQuery(sql21);
		if(rs21.next()){
		String sql22="update crm_order set order_tag='2',order_status='完成',accomplish_time='"+check_time+"' where order_ID='"+order_ID+"'";
		crm_db.executeUpdate(sql22);
		}
		}
		gatherExpiry.back(dbApplication);
		String sql17="update fund_fund set finish_time='"+time+"',execute_tag='2',fund_tag='1' where fund_ID='"+fund_ID+"'";
		fund_db.executeUpdate(sql17);		
response.sendRedirect("fund/gather/check_ok.jsp?finished_tag=0");
}else{
response.sendRedirect("fund/gather/check_ok.jsp?finished_tag=1");
}
}else{
		response.sendRedirect("fund/gather/check_ok.jsp?finished_tag=6");
	}
}
catch (Exception ex){
ex.printStackTrace();
}
}else{	
response.sendRedirect("fund/gather/check_ok.jsp?finished_tag=2");
}
}else{
response.sendRedirect("fund/gather/check_ok.jsp?finished_tag=3");
}
}else{	
response.sendRedirect("fund/gather/check_ok.jsp?finished_tag=4");
}
}else{
response.sendRedirect("fund/gather/check_ok.jsp?finished_tag=5");
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

