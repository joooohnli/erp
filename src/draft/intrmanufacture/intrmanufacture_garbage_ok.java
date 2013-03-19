/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package draft.intrmanufacture;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.util.*;
import java.io.*;
import include.nseer_db.*;
import java.text.*;

import include.nseer_cookie.counter;
import validata.ValidataNumber;
import validata.ValidataRecordNumber;


public class intrmanufacture_garbage_ok extends HttpServlet{

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

counter count=new  counter(dbApplication);

ValidataNumber  validata=new  ValidataNumber();

nseer_db_backup1 intrmanufacture_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 intrmanufacture_db1 = new nseer_db_backup1(dbApplication);
nseer_db_backup1 intrmanufacturedb = new nseer_db_backup1(dbApplication);
nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 design_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 fund_db = new nseer_db_backup1(dbApplication);

if(intrmanufacturedb.conn((String)dbSession.getAttribute("unit_db_name"))&&intrmanufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))&&intrmanufacture_db1.conn((String)dbSession.getAttribute("unit_db_name"))&&stock_db.conn((String)dbSession.getAttribute("unit_db_name"))&&design_db.conn((String)dbSession.getAttribute("unit_db_name"))&&fund_db.conn((String)dbSession.getAttribute("unit_db_name"))){
	String time="";
	java.util.Date now = new java.util.Date();
	SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
	time=formatter.format(now);
	String mod=request.getRequestURI();
ValidataRecordNumber  vrn= new  ValidataRecordNumber();
String intrmanufacture_ID=request.getParameter("intrmanufacture_ID");
String product_ID=request.getParameter("product_ID");
String product_name=request.getParameter("product_name");
String balance_amount=request.getParameter("balance_amount");
String[] provider_name=request.getParameterValues("provider_name") ;
String[] provider_ID=request.getParameterValues("provider_ID") ;
String[] contact_person=request.getParameterValues("contact_person1") ;
String[] provider_tel=request.getParameterValues("provider_tel1") ;
String[] demand_gather_time=request.getParameterValues("demand_gather_time1") ;
String[] demand_amount=request.getParameterValues("demand_amount") ;
String[] demand_price=request.getParameterValues("demand_price") ;
int p=0;
double demand_amount_sum=0.0d;
for(int i=0;i<provider_ID.length;i++){
	if(!demand_amount[i].equals("")){
		if(!validata.validata(demand_amount[i])){
			p++;
		}else{
			demand_amount_sum+=Double.parseDouble(demand_amount[i]);
		}
	}
	if(!demand_price[i].equals("")){
		StringTokenizer tokenTO1 = new StringTokenizer(demand_price[i],",");        
		String demand_price2="";
            while(tokenTO1.hasMoreTokens()) {
                String demand_price1 = tokenTO1.nextToken();
		demand_price2+=demand_price1;
		}
		if(!validata.validata(demand_price2)||Double.parseDouble(demand_price2)<0){
			p++;
		}	
	}
}
if(p==0){
String register=request.getParameter("register");
String register_time=request.getParameter("register_time");
demand_amount_sum=0.0d;
double demand_cost_price_sum=0.0d;
int m=0;
int n=0;
for(int i=0;i<provider_ID.length;i++){
	if(!demand_amount[i].equals("")&&!demand_price[i].equals("")){
		if(Double.parseDouble(demand_amount[i])!=0){
		n++;
		}
	}
	if(!demand_amount[i].equals("")&&demand_price[i].equals("")){
		m++;
	}
}
if(n!=0&&m==0){
int num=count.readTime((String)dbSession.getAttribute("unit_db_name"),mod);
count.writeTime((String)dbSession.getAttribute("unit_db_name"),mod);
m=1;
for(int i=0;i<provider_ID.length;i++){
	if(!demand_amount[i].equals("")&&Double.parseDouble(demand_amount[i])!=0){
		StringTokenizer tokenTO = new StringTokenizer(demand_price[i],",");        
		String demand_price2="";
            while(tokenTO.hasMoreTokens()) {
                String demand_price1 = tokenTO.nextToken();
		demand_price2+=demand_price1;
		}
		double amount=Double.parseDouble(demand_amount[i]);
		demand_amount_sum+=amount;
		double subtotal=amount*Double.parseDouble(demand_price2);
		demand_cost_price_sum+=subtotal;
		String sql="update intrmanufacture_details set details_number='"+m+"',provider_name='"+provider_name[i]+"',demand_contact_person='"+contact_person[i]+"',demand_contact_person_tel='"+provider_tel[i]+"',demand_amount='"+amount+"',demand_price='"+demand_price2+"',demand_cost_price_sum='"+subtotal+"',demand_gather_time='"+demand_gather_time[i]+"' where intrmanufacture_ID='"+intrmanufacture_ID+"' and provider_ID='"+provider_ID[i]+"'";
		intrmanufacture_db.executeUpdate(sql);
		m++;
	}
}
double price=demand_cost_price_sum/demand_amount_sum;
String sql1="update intrmanufacture_intrmanufacture set product_ID='"+product_ID+"',product_name='"+product_name+"',register='"+register+"',register_time='"+register_time+"',demand_amount='"+demand_amount_sum+"',demand_price='"+price+"',demand_cost_price_sum='"+demand_cost_price_sum+"',check_tag='2',pay_ID_group='新发生' where intrmanufacture_ID='"+intrmanufacture_ID+"'";
intrmanufacture_db.executeUpdate(sql1);

response.sendRedirect("draft/intrmanufacture/intrmanufacture_ok.jsp?finished_tag=2");

}else{
session.setAttribute("product_name",product_name);
session.setAttribute("product_ID",product_ID);
response.sendRedirect("draft/intrmanufacture/intrmanufacture_ok_a.jsp");
}
  }else{
session.setAttribute("product_name",product_name);
session.setAttribute("product_ID",product_ID);
response.sendRedirect("draft/intrmanufacture/intrmanufacture_ok_b.jsp");
}
intrmanufacture_db.commit();
	intrmanufacture_db1.commit();
	stock_db.commit();
fund_db.commit();
intrmanufacturedb.commit();
intrmanufacture_db.close();
	intrmanufacture_db1.close();
	stock_db.close();
fund_db.close();
intrmanufacturedb.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
	ex.printStackTrace();
}
}
}

