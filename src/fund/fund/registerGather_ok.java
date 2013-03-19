/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package fund.fund;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.* ;
import java.util.*;
import java.io.*;

import include.nseer_cookie.NseerId;
import include.nseer_cookie.exchange;
import include.nseer_db.*;
import java.text.*;

import include.nseer_cookie.counter;
import validata.ValidataNumber;
import validata.ValidataRecord;

public class registerGather_ok extends HttpServlet{
//创建方法

ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


try{
	
	String time="";
	 java.util.Date now = new java.util.Date();
	 SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
	 time=formatter.format(now);

HttpSession session=request.getSession();
PrintWriter out=response.getWriter();

nseer_db_backup1 fund_db = new nseer_db_backup1(dbApplication);
if(fund_db.conn((String)dbSession.getAttribute("unit_db_name"))){
counter count= new counter(dbApplication);
ValidataNumber validata= new  ValidataNumber();
ValidataRecord vr= new ValidataRecord();


int x=0;
String[] fund_kind=request.getParameterValues("fund_kind");
String[] cost_price_subtotal=request.getParameterValues("cost_price_subtotal");
for(int i=0;i<fund_kind.length;i++){
	if(!cost_price_subtotal[i].equals("")){
		String cost_price_subtotal1="";
		StringTokenizer tokenTO3 = new StringTokenizer(cost_price_subtotal[i],",");        
		while(tokenTO3.hasMoreTokens()) {
			cost_price_subtotal1+=tokenTO3.nextToken();
		}
		if(!validata.validata(cost_price_subtotal1)){
	x++;
	}
	}
}
if(x==0){
int p=0;
String choice_group=request.getParameter("choice_group");
StringTokenizer tokenTO4 = new StringTokenizer(choice_group,", ");        
while(tokenTO4.hasMoreTokens()) {
	String sql5="select * from fund_fund where fund_pre_tag='1' and id='"+tokenTO4.nextToken()+"'";
	ResultSet rs5=fund_db.executeQuery(sql5) ;
		if(rs5.next()){
			p++;
		}
	}
if(p==0){
try{

String funder_ID=request.getParameter("funder_ID");
String chain_ID=request.getParameter("chain_ID");
String chain_name=request.getParameter("chain_name");
String file_chain_ID=request.getParameter("file_chain_ID");
String file_chain_name=request.getParameter("file_chain_name");
String funder=request.getParameter("funder");
String demand_cost_price_sum=request.getParameter("demand_cost_price_sum");
String apply_ID_group=request.getParameter("apply_ID_group");
String designer=request.getParameter("designer") ;
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String bodyb = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyb);
String currency_name=request.getParameter("currency_name") ;
String personal_unit=request.getParameter("personal_unit") ;
String[] account_bank=request.getParameterValues("account_bank");
String[] account_ID=request.getParameterValues("account_ID");
String[] currency=request.getParameterValues("currency");
String[] cost_price_sum=request.getParameterValues("cost_price_sum");
double demand_cost_price_sum1=0.0d;
int n=1;
for(int i=0;i<fund_kind.length;i++){
	if(!cost_price_subtotal[i].equals("")){
		String cost_price_subtotal1="";
		StringTokenizer tokenTO3 = new StringTokenizer(cost_price_subtotal[i],",");        
		while(tokenTO3.hasMoreTokens()) {
			cost_price_subtotal1+=tokenTO3.nextToken();
		}
		demand_cost_price_sum1+=Double.parseDouble(cost_price_subtotal1);
	}
}
if(demand_cost_price_sum1==Double.parseDouble(demand_cost_price_sum)){
StringTokenizer tokenTO = new StringTokenizer(choice_group,", ");        
while(tokenTO.hasMoreTokens()) {
	String sql4="update fund_fund set fund_pre_tag='1' where id='"+tokenTO.nextToken()+"'";
	fund_db.executeUpdate(sql4) ;
	}
String fund_ID=request.getParameter("fund_ID");
if(fund_ID.equals("")){
	fund_ID=NseerId.getId("fund/gather",(String)dbSession.getAttribute("unit_db_name"));
		
}
	String sql2="delete from fund_fund where fund_ID='"+fund_ID+"'";
	fund_db.executeUpdate(sql2);
	String sql5="delete from fund_details where fund_ID='"+fund_ID+"'";
	fund_db.executeUpdate(sql5);
for(int i=0;i<fund_kind.length;i++){
	if(!cost_price_subtotal[i].equals("")){
		String fund_chain_ID="";
		String fund_chain_name="";
		StringTokenizer tokenTO1 = new StringTokenizer(fund_kind[i],"/");        
		while(tokenTO1.hasMoreTokens()) {
			fund_chain_ID = tokenTO1.nextToken();
			fund_chain_name = tokenTO1.nextToken();
		}
		String cost_price_subtotal1="";
		StringTokenizer tokenTO3 = new StringTokenizer(cost_price_subtotal[i],",");        
		while(tokenTO3.hasMoreTokens()) {
			cost_price_subtotal1+=tokenTO3.nextToken();
		}
		String sql="insert into fund_details(fund_ID,details_number,fund_chain_ID,fund_chain_name,account_bank,account_ID,currency_name,personal_unit,cost_price_subtotal) values('"+fund_ID+"','"+n+"','"+fund_chain_ID+"','"+fund_chain_name+"','"+account_bank[i]+"','"+account_ID[i]+"','"+currency_name+"','"+personal_unit+"','"+cost_price_subtotal1+"')";
		fund_db.executeUpdate(sql);
		n++;
		
		 sql="update fund_config_fund_kind set delete_tag='1' where file_ID='"+fund_chain_ID+"'";
		fund_db.executeUpdate(sql);//delete_tag为1说明分类被使用
	}

}
if(!vr.validata((String)dbSession.getAttribute("unit_db_name"),"fund_fund","fund_ID",fund_ID)){
String sql3="insert into fund_fund(fund_ID,chain_ID,chain_name,file_chain_ID,file_chain_name,funder,funder_ID,reason,demand_cost_price_sum,apply_ID_group,choice_ID_group,currency_name,personal_unit,register_time,designer,register,remark,check_tag,excel_tag,fund_execute_tag) values('"+fund_ID+"','"+chain_ID+"','"+chain_name+"','"+file_chain_ID+"','"+file_chain_name+"','"+funder+"','"+funder_ID+"','收款','"+demand_cost_price_sum+"','"+apply_ID_group+"','"+choice_group+"','"+currency_name+"','"+personal_unit+"','"+register_time+"','"+designer+"','"+register+"','"+remark+"','1','2','1')";
fund_db.executeUpdate(sql3);
}



StringTokenizer tokenTO6 = new StringTokenizer(apply_ID_group,", ");        
while(tokenTO6.hasMoreTokens()) {
	String sql6="update crm_order set gather_tag='2' where order_id='"+tokenTO6.nextToken()+"'";
	fund_db.executeUpdate(sql6) ;
}

response.sendRedirect("fund/fund/registerGather_ok_a.jsp");


}else{

 response.sendRedirect("fund/fund/registerGather_ok_b.jsp");
	
	}
}
catch (Exception ex){
ex.printStackTrace();
}

}else{

 response.sendRedirect("fund/fund/registerGather_ok_c.jsp");

 }}else{
	

response.sendRedirect("fund/fund/registerGather_ok_d.jsp");

}
fund_db.commit();
fund_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){ex.printStackTrace();}
}
}