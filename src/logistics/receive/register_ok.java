/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package logistics.receive;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.counter;
import validata.ValidataNumber;

public class register_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
try{

ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 logistics_db = new nseer_db_backup1(dbApplication);
if(logistics_db.conn((String)dbSession.getAttribute("unit_db_name"))){


counter count=new counter(dbApplication);
ValidataNumber validata=new ValidataNumber();
String logistics_ID=request.getParameter("logistics_ID");
String order_ID=request.getParameter("order_ID");
String customer_ID=request.getParameter("customer_ID");
String customer_name=request.getParameter("customer_name");
String register=request.getParameter("register");
String register_time=request.getParameter("register_time");
String demand_amount_sum=request.getParameter("demand_amount_sum");
String receive_amount_sum=request.getParameter("receive_amount_sum");
String product_ID=request.getParameter("product_ID");
String product_name=request.getParameter("product_name");
String[] provider_name=request.getParameterValues("provider_name") ;
String[] provider_ID=request.getParameterValues("provider_ID") ;
String[] receive_person=request.getParameterValues("receive_person") ;
String[] receive_person_tel=request.getParameterValues("receive_person_tel") ;
String[] receive_time=request.getParameterValues("receive_time") ;
String[] demand_amount=request.getParameterValues("demand_amount") ;
String[] receive_amount=request.getParameterValues("receive_amount") ;
String[] receive_amounting=request.getParameterValues("receive_amounting") ;
int n=0;
int p=0;
double receive_amounting_sum=0.0d;
for(int i=0;i<provider_ID.length;i++){
	if(!receive_amounting[i].equals("")){
		if(!validata.validata(receive_amounting[i])){
			p++;
		}else{
			receive_amounting_sum+=Double.parseDouble(receive_amounting[i]);
			if((Double.parseDouble(receive_amount[i])+Double.parseDouble(receive_amounting[i]))>Double.parseDouble(demand_amount[i])){
				p++;
			}
		}
	}
}
if((receive_amounting_sum+Double.parseDouble(receive_amount_sum))>Double.parseDouble(demand_amount_sum)){
	p++;
}
if(p==0){
int m=1;
receive_amounting_sum=0.0d;
for(int i=0;i<provider_ID.length;i++){
	if(!receive_amounting[i].equals("")&&Double.parseDouble(receive_amounting[i])!=0){
		receive_amounting_sum+=Double.parseDouble(receive_amounting[i]);
		String sql="insert into logistics_details_details(logistics_ID,details_number,provider_ID,provider_name,receive_person,receive_person_tel,receive_amount,receive_time) values('"+logistics_ID+"','"+m+"','"+provider_ID[i]+"','"+provider_name[i]+"','"+receive_person[i]+"','"+receive_person_tel[i]+"','"+receive_amounting[i]+"','"+receive_time[i]+"')";
		logistics_db.executeUpdate(sql);
		m++;
		double receive_amount1=Double.parseDouble(receive_amount[i])+Double.parseDouble(receive_amounting[i]);
		if(receive_amount1==Double.parseDouble(demand_amount[i])){
		String sql3="update logistics_details set receive_amount='"+receive_amount1+"',receive_tag='1' where logistics_ID='"+logistics_ID+"' and provider_ID='"+provider_ID[i]+"'";
		logistics_db.executeUpdate(sql3);
		}else{
			String sql3="update logistics_details set receive_amount='"+receive_amount1+"' where logistics_ID='"+logistics_ID+"' and provider_ID='"+provider_ID[i]+"'";
		logistics_db.executeUpdate(sql3);
		}
	}
}

double receive_amount_sum1=receive_amounting_sum+Double.parseDouble(receive_amount_sum);
if(receive_amount_sum1==Double.parseDouble(demand_amount_sum)){
	String sql4="update logistics_logistics set receive_amount_sum='"+receive_amount_sum1+"',receive_tag='1' where logistics_ID='"+logistics_ID+"'";
		logistics_db.executeUpdate(sql4);
}else{
	String sql4="update logistics_logistics set receive_amount_sum='"+receive_amount_sum1+"' where logistics_ID='"+logistics_ID+"'";
		logistics_db.executeUpdate(sql4);
}
String sql2="select * from crm_order_details where order_ID='"+order_ID+"' and product_ID='"+product_ID+"'";
ResultSet rs2=logistics_db.executeQuery(sql2);
if(rs2.next()){
	double receive_amount2=rs2.getDouble("receive_amount")+receive_amounting_sum;
	if(receive_amount2==rs2.getDouble("amount")){
		sql2="update crm_order_details set receive_amount='"+receive_amount2+"',receive_tag='1' where order_ID='"+order_ID+"' and product_ID='"+product_ID+"'";
	}else{
		sql2="update crm_order_details set receive_amount='"+receive_amount2+"' where order_ID='"+order_ID+"' and product_ID='"+product_ID+"'";
	}
	logistics_db.executeUpdate(sql2);
}
sql2="select * from crm_order_details where order_ID='"+order_ID+"' and receive_tag='0'";
rs2=logistics_db.executeQuery(sql2);
if(!rs2.next()){
sql2="select * from crm_order where order_ID='"+order_ID+"'";
rs2=logistics_db.executeQuery(sql2);
if(rs2.next()){
	double receive_amount_sum2=receive_amounting_sum+rs2.getDouble("receive_amount_sum");
		sql2="update crm_order set receive_amount_sum='"+receive_amount_sum2+"',receive_tag='3' where order_ID='"+order_ID+"'";
		logistics_db.executeUpdate(sql2);
}
String sql21="select * from crm_order where gather_tag='3' and logistics_tag='3' and receive_tag='3' and invoice_tag='3' and pay_tag='3' and check_tag='1' and order_ID='"+order_ID+"'";
		ResultSet rs21=logistics_db.executeQuery(sql21);
		if(rs21.next()){
		String sql22="update crm_order set order_tag='2',order_status='完成',accomplish_time='"+register_time+"' where order_ID='"+order_ID+"'";
		logistics_db.executeUpdate(sql22);
		}
	response.sendRedirect("logistics/receive/register_ok_a.jsp");
}else{
sql2="select * from crm_order where order_ID='"+order_ID+"'";
rs2=logistics_db.executeQuery(sql2);
if(rs2.next()){
	double receive_amount_sum2=receive_amounting_sum+rs2.getDouble("receive_amount_sum");
		sql2="update crm_order set receive_amount_sum='"+receive_amount_sum2+"',receive_tag='2' where order_ID='"+order_ID+"'";
		logistics_db.executeUpdate(sql2);
}
	response.sendRedirect("logistics/receive/register_ok_b.jsp");
}
  }else{
		response.sendRedirect("logistics/receive/register_ok_d.jsp?logistics_ID="+logistics_ID+"");
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