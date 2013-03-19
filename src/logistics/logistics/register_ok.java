/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package logistics.logistics;
 
import include.nseer_cookie.FileKind;
import include.nseer_cookie.NseerId;
import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.StringTokenizer;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

import validata.ValidataNumber;

public class register_ok extends HttpServlet{

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
ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 logistics_db = new nseer_db_backup1(dbApplication);
FileKind  FileKind= new  FileKind();
if(logistics_db.conn((String)dbSession.getAttribute("unit_db_name"))){
ValidataNumber validata=new ValidataNumber();
String order_ID=request.getParameter("order_ID");
String customer_ID=request.getParameter("customer_ID");
String customer_name=request.getParameter("customer_name");
String register=request.getParameter("register");
String register_time=request.getParameter("register_time");
String paid_amount=request.getParameter("paid_amount");
String logistics_amount=request.getParameter("logistics_amount");
String product_ID=request.getParameter("product_ID");
String product_name=request.getParameter("product_name");
String[] provider_name=request.getParameterValues("provider_name") ;
String[] provider_ID=request.getParameterValues("provider_ID") ;
String[] contact_person=request.getParameterValues("contact_person1") ;
String[] provider_tel=request.getParameterValues("provider_tel1") ;
String[] demand_gather_time=request.getParameterValues("demand_gather_time1") ;
String[] demand_amount=request.getParameterValues("demand_amount") ;
String[] demand_price=request.getParameterValues("demand_price") ;
int n=0;
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
if((demand_amount_sum+Double.parseDouble(logistics_amount))>Double.parseDouble(paid_amount)){
	p++;
}
if(p==0){
double demand_price_sum=0.0d;
int m=0;
int q=0;
for(int i=0;i<provider_ID.length;i++){
	if(!demand_amount[i].equals("")&&!demand_price[i].equals("")){
		if(Double.parseDouble(demand_amount[i])!=0){
		q++;
		}
	}
	if(!demand_amount[i].equals("")&&demand_price[i].equals("")){
		m++;
	}
}
if(q!=0&&m==0){
	String logistics_ID=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));
	m=1;
demand_amount_sum=0.0d;
for(int i=0;i<provider_ID.length;i++){
	if(!demand_amount[i].equals("")&&Double.parseDouble(demand_amount[i])!=0){
		StringTokenizer tokenTO1 = new StringTokenizer(demand_price[i],",");        
		String demand_price2="";
            while(tokenTO1.hasMoreTokens()) {
                String demand_price1 = tokenTO1.nextToken();
		demand_price2+=demand_price1;
		}
		double amount8=Double.parseDouble(demand_amount[i]);
		demand_amount_sum+=amount8;
		double subtotal=amount8*Double.parseDouble(demand_price2);
		demand_price_sum+=subtotal;
		String sql="insert into logistics_details(logistics_ID,details_number,provider_ID,provider_name,demand_contact_person,demand_contact_person_tel,demand_amount,demand_price,demand_price_sum,demand_gather_time) values('"+logistics_ID+"','"+m+"','"+provider_ID[i]+"','"+provider_name[i]+"','"+contact_person[i]+"','"+provider_tel[i]+"','"+amount8+"','"+demand_price2+"','"+subtotal+"','"+demand_gather_time[i]+"')";
		logistics_db.executeUpdate(sql);
		m++;
		String fund_ID=NseerId.getId("fund/pay",(String)dbSession.getAttribute("unit_db_name"));
		String[] kind_chain=FileKind.getKind((String)dbSession.getAttribute("unit_db_name"),"logistics_file","provider_ID",provider_ID[i]);
		String sql12="insert into fund_fund(fund_ID,reason,reasonexact,chain_id,chain_name,funder,funder_ID,file_chain_id,file_chain_name,demand_cost_price_sum,currency_name,personal_unit,register,register_time,qcs_dealwith_tag) values('"+fund_ID+"','付款','"+logistics_ID+"','"+kind_chain[0]+"','"+kind_chain[1]+"','"+provider_name[i]+"','"+provider_ID[i]+"','2121','应付账款-配送费','"+subtotal+"','人民币','元','"+register+"','"+register_time+"','1')";
			logistics_db.executeUpdate(sql12) ;
	}
}
double price=demand_price_sum/demand_amount_sum;
String sql1="insert into logistics_logistics(logistics_ID,order_ID,customer_ID,customer_name,product_ID,product_name,register,register_time,demand_amount,demand_price,demand_price_sum,check_tag) values('"+logistics_ID+"','"+order_ID+"','"+customer_ID+"','"+customer_name+"','"+product_ID+"','"+product_name+"','"+register+"','"+register_time+"','"+demand_amount_sum+"','"+price+"','"+demand_price_sum+"','1')";
logistics_db.executeUpdate(sql1);
double logistics_amount1=demand_amount_sum+Double.parseDouble(logistics_amount);
String sql2="select * from crm_order_details where order_ID='"+order_ID+"' and product_ID='"+product_ID+"'";
ResultSet rs2=logistics_db.executeQuery(sql2);
if(rs2.next()){
	double logistics_price=demand_price_sum+rs2.getDouble("logistics_price");
	if(logistics_amount1==rs2.getDouble("amount")){
		sql2="update crm_order_details set logistics_amount='"+logistics_amount1+"',logistics_price='"+logistics_price+"',logistics_tag='1' where order_ID='"+order_ID+"' and product_ID='"+product_ID+"'";
	}else{
		sql2="update crm_order_details set logistics_amount='"+logistics_amount1+"',logistics_price='"+logistics_price+"' where order_ID='"+order_ID+"' and product_ID='"+product_ID+"'";
	}
	logistics_db.executeUpdate(sql2);
}
sql2="select * from crm_order_details where order_ID='"+order_ID+"' and logistics_tag='0'";
rs2=logistics_db.executeQuery(sql2);
if(!rs2.next()){
sql2="select * from crm_order where order_ID='"+order_ID+"'";
rs2=logistics_db.executeQuery(sql2);
if(rs2.next()){
	double logistics_price_sum=demand_price_sum+rs2.getDouble("logistics_price_sum");
	double logistics_amount_sum=demand_amount_sum+rs2.getDouble("logistics_amount_sum");
		sql2="update crm_order set logistics_amount_sum='"+logistics_amount_sum+"',logistics_price_sum='"+logistics_price_sum+"',logistics_tag='3' where order_ID='"+order_ID+"'";
		logistics_db.executeUpdate(sql2);
}
String sql21="select * from crm_order where gather_tag='3' and logistics_tag='3' and receive_tag='3' and invoice_tag='3' and pay_tag='3' and check_tag='1' and order_ID='"+order_ID+"'";
		ResultSet rs21=logistics_db.executeQuery(sql21);
		if(rs21.next()){
		String sql22="update crm_order set order_tag='2',order_status='完成',accomplish_time='"+register_time+"' where order_ID='"+order_ID+"'";
		logistics_db.executeUpdate(sql22);
		}

	response.sendRedirect("logistics/logistics/register_ok_a.jsp?order_ID="+order_ID+"");
}else{
sql2="select * from crm_order where order_ID='"+order_ID+"'";
rs2=logistics_db.executeQuery(sql2);
if(rs2.next()){
	double logistics_price_sum=demand_price_sum+rs2.getDouble("logistics_price_sum");
	double logistics_amount_sum=demand_amount_sum+rs2.getDouble("logistics_amount_sum");
		sql2="update crm_order set logistics_amount_sum='"+logistics_amount_sum+"',logistics_price_sum='"+logistics_price_sum+"',logistics_tag='2' where order_ID='"+order_ID+"'";
	logistics_db.executeUpdate(sql2);
}
	response.sendRedirect("logistics/logistics/register_ok_b.jsp?order_ID="+order_ID+"");
}
	
	}else{
		response.sendRedirect("logistics/logistics/register_ok_c.jsp?order_ID="+order_ID+"");
		}
  }else{
		response.sendRedirect("logistics/logistics/register_ok_d.jsp?order_ID="+order_ID+"");
	  }
logistics_db.commit();
logistics_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
} 