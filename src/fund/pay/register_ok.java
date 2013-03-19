/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package fund.pay;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.util.*;
import java.io.*;

import include.nseer_cookie.GetWorkflow;
import include.nseer_db.*;
import validata.ValidataNumber;

public class register_ok extends HttpServlet{
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
nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);
if(fund_db.conn((String)dbSession.getAttribute("unit_db_name"))&&hr_db.conn((String)dbSession.getAttribute("unit_db_name"))){

ValidataNumber validata= new  ValidataNumber();

String file_chain_name=request.getParameter("file_chain_name");
String fund_ID=request.getParameter("fund_ID");
String funder=request.getParameter("funder");
String apply_ID_group=request.getParameter("apply_ID_group");
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String currency_name=request.getParameter("currency_name") ;
String personal_unit=request.getParameter("personal_unit") ;
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
if(p==0){
int n=0;
for(int i=0;i<account_ID.length;i++){
	if(!subtotal[i].equals("")){
		String sql1="select * from fund_executing where fund_ID='"+fund_ID+"' and account_bank='"+account_bank[i]+"' and account_ID='"+account_ID[i]+"' and check_tag='0'";
		ResultSet rs1=fund_db.executeQuery(sql1);
		if(rs1.next()){
			n++;
		}
		StringTokenizer tokenTO4 = new StringTokenizer(subtotal[i],",");        
		String subtotal1="";
		while(tokenTO4.hasMoreTokens()) {
			subtotal1+= tokenTO4.nextToken();
		}
if(Math.abs(Double.parseDouble(subtotal1)+Double.parseDouble(executed_cost_price_subtotal[i]))>Math.abs(Double.parseDouble(cost_price_subtotal[i]))){
		n++;
		}
	}
}
if(n==0){
try{
List rsList = GetWorkflow.getList(fund_db, "fund_config_workflow", "03");
	int pay_time=0;
	String sql="select pay_time from fund_fund where fund_ID='"+fund_ID+"'";
	ResultSet rset=fund_db.executeQuery(sql);
	if(rset.next()){
		pay_time=rset.getInt("pay_time")+1;
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
	if(rsList.size()==0){
		if(Double.parseDouble(subtotaling)!=0){
	cost_price_sum+=Double.parseDouble(subtotaling);
		String sql4="insert into fund_executing(fund_ID,fund_chain_ID,details_number,fund_chain_name,account_bank,account_ID,subtotal,cost_price_subtotal,register,register_time,executed_cost_price_subtotal,execute_method,bill_ID,currency_name,personal_unit,check_tag,pay_time) values('"+fund_ID+"','"+fund_chain_ID[i]+"','"+details_number[i]+"','"+fund_chain_name[i]+"','"+account_bank[i]+"','"+account_ID[i]+"','"+subtotaling+"','"+cost_price_subtotal[i]+"','"+register+"','"+register_time+"','"+executed_cost_price_subtotal[i]+"','"+execute_method[i]+"','"+bill_ID[i]+"','"+currency_name+"','"+personal_unit+"','1','"+pay_time+"')";
		fund_db.executeUpdate(sql4);
		String sql11="select * from fund_details where fund_ID='"+fund_ID+"' and details_number='"+details_number[i]+"'";
		ResultSet rs11=fund_db.executeQuery(sql11);
		if(rs11.next()){
			double subtotal5=rs11.getDouble("executed_cost_price_subtotal")+Double.parseDouble(subtotaling);
			if(rs11.getDouble("cost_price_subtotal")==subtotal5){
				sql="update fund_details set executed_cost_price_subtotal='"+subtotal5+"',execute_details_tag='2',execute_check_tag='0' where fund_ID='"+fund_ID+"' and details_number='"+details_number[i]+"'";
				fund_db.executeUpdate(sql);
			}else{
				String sql12="update fund_details set executed_cost_price_subtotal='"+subtotal5+"',execute_check_tag='0' where fund_ID='"+fund_ID+"' and details_number='"+details_number[i]+"'";
				fund_db.executeUpdate(sql12);
			}
		}
	}else if(Double.parseDouble(subtotaling)==0){
		String sql11="select * from fund_details where fund_ID='"+fund_ID+"' and details_number='"+details_number[i]+"'";
		ResultSet rs11=fund_db.executeQuery(sql11);
		if(rs11.next()){
			double subtotal5=rs11.getDouble("executed_cost_price_subtotal")+Double.parseDouble(subtotaling);
			if(rs11.getDouble("cost_price_subtotal")==subtotal5){
				sql="update fund_details set executed_cost_price_subtotal='"+subtotal5+"',execute_details_tag='2',execute_check_tag='0' where fund_ID='"+fund_ID+"' and details_number='"+details_number[i]+"'";
				fund_db.executeUpdate(sql);
			}else{
				String sql12="update fund_details set executed_cost_price_subtotal='"+subtotal5+"',execute_check_tag='0' where fund_ID='"+fund_ID+"' and details_number='"+details_number[i]+"'";
				fund_db.executeUpdate(sql12);
			}
		}
	}
	}else{
		String sql4="insert into fund_executing(fund_ID,fund_chain_ID,details_number,fund_chain_name,account_bank,account_ID,subtotal,cost_price_subtotal,register,register_time,executed_cost_price_subtotal,execute_method,bill_ID,currency_name,personal_unit,pay_time) values('"+fund_ID+"','"+fund_chain_ID[i]+"','"+details_number[i]+"','"+fund_chain_name[i]+"','"+account_bank[i]+"','"+account_ID[i]+"','"+subtotaling+"','"+cost_price_subtotal[i]+"','"+register+"','"+register_time+"','"+executed_cost_price_subtotal[i]+"','"+execute_method[i]+"','"+bill_ID[i]+"','"+currency_name+"','"+personal_unit+"','"+pay_time+"')";
		fund_db.executeUpdate(sql4);
	}
	}
	}


	String sql2="update fund_fund set execute_tag='1',pay_time='"+pay_time+"' where fund_ID='"+fund_ID+"'";
	fund_db.executeUpdate(sql2);
	if(funder.indexOf("工资")!=-1){
		StringTokenizer tokenTO1 = new StringTokenizer(apply_ID_group,", ");        
		while(tokenTO1.hasMoreTokens()) {
			hr_db.executeUpdate("update hr_salary set pay_tag='2' where salary_ID='"+tokenTO1.nextToken()+"'");
		}
	}else if(file_chain_name.indexOf("费用")!=-1){
		StringTokenizer tokenTO1 = new StringTokenizer(apply_ID_group,", ");        
		while(tokenTO1.hasMoreTokens()) {
			String apply_pay_ID=tokenTO1.nextToken();
			fund_db.executeUpdate("update fund_apply_pay set pay_tag='1' where apply_pay_ID='"+apply_pay_ID+"'");
		}
	}
//**********************
if(rsList.size()==0){
	String sql18="select * from fund_fund where fund_ID='"+fund_ID+"'"; 
	ResultSet rs18=fund_db.executeQuery(sql18);
	if(rs18.next()){
		double subtotal7=rs18.getDouble("executed_cost_price_sum")+cost_price_sum;
		String sql19="update fund_fund set executed_cost_price_sum='"+subtotal7+"',checker='"+register+"',check_time='"+register_time+"' where fund_ID='"+fund_ID+"'";
		fund_db.executeUpdate(sql19);
	}
	if(funder.indexOf("工资")!=-1){
		StringTokenizer tokenTO2 = new StringTokenizer(apply_ID_group,", ");        
		while(tokenTO2.hasMoreTokens()) {
			hr_db.executeUpdate("update hr_salary set pay_tag='2' where salary_ID='"+tokenTO2.nextToken()+"'");
		}
	}
	String sql16="select * from fund_details where fund_ID='"+fund_ID+"' and execute_details_tag!='2'";
	ResultSet rs16=fund_db.executeQuery(sql16);
	if(!rs16.next()){
		String sql17="update fund_fund set finish_time='"+register_time+"',execute_tag='2',fund_tag='1' where fund_ID='"+fund_ID+"'";
		fund_db.executeUpdate(sql17);
		if(funder.indexOf("工资")!=-1){
		StringTokenizer tokenTO1 = new StringTokenizer(apply_ID_group,", ");        
		while(tokenTO1.hasMoreTokens()) {
			hr_db.executeUpdate("update hr_salary set pay_tag='3' where salary_ID='"+tokenTO1.nextToken()+"'");
		}
	}else if(file_chain_name.indexOf("费用")!=-1){
		StringTokenizer tokenTO1 = new StringTokenizer(apply_ID_group,", ");        
		while(tokenTO1.hasMoreTokens()) {
			String apply_pay_ID=tokenTO1.nextToken();
			ResultSet rs21=hr_db.executeQuery("select * from fund_fund where reasonexact='"+apply_pay_ID+"' and fund_pre_tag='0'");
			ResultSet rs20=fund_db.executeQuery("select * from fund_fund where apply_ID_group like '%"+apply_pay_ID+"%' and fund_execute_tag='1' and fund_tag!='1'");
			if(!rs20.next()&&!rs21.next()){
			fund_db.executeUpdate("update fund_apply_pay set apply_tag='1',pay_tag='2' where apply_pay_ID='"+apply_pay_ID+"'");
			}
		}
	}
	}
	
}else{
	Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		String[] elem=(String[])ite.next();
		sql = "insert into fund_workflow(config_id,object_ID,describe1,describe2,pay_time) values ('"+elem[0]+"','"+fund_ID+"','"+elem[1]+"','"+elem[2]+"','"+pay_time+"')" ;
		fund_db.executeUpdate(sql) ;
		}
}
		
}catch (Exception ex){
	ex.printStackTrace();
}
	response.sendRedirect("fund/pay/register_ok.jsp?finished_tag=0");
}else{
	response.sendRedirect("fund/pay/register_ok.jsp?finished_tag=1");
}}else{
	response.sendRedirect("fund/pay/register_ok.jsp?finished_tag=2");
}
fund_db.commit();
hr_db.commit();
hr_db.close();
fund_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
	ex.printStackTrace();
}
}
}
