/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package purchase.purchase;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import java.text.*;

import include.nseer_cookie.NseerId;
import include.nseer_cookie.counter;
import validata.ValidataNumber;
import include.nseer_cookie.*;
import validata.ValidataRecordNumber;

public class register_draft_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
try{

ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 purchase_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 purchasedb = new nseer_db_backup1(dbApplication);
nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 purchase_db1 = new nseer_db_backup1(dbApplication);
nseer_db_backup1 fund_db = new nseer_db_backup1(dbApplication);
if(purchase_db.conn((String)dbSession.getAttribute("unit_db_name"))&&purchasedb.conn((String)dbSession.getAttribute("unit_db_name"))&&stock_db.conn((String)dbSession.getAttribute("unit_db_name"))&&purchase_db1.conn((String)dbSession.getAttribute("unit_db_name"))&&fund_db.conn((String)dbSession.getAttribute("unit_db_name"))){


ValidataRecordNumber vrn=new ValidataRecordNumber();
counter count=new counter(dbApplication);
ValidataNumber validata=new ValidataNumber();

String list_price=request.getParameter("list_price");
String amount=request.getParameter("amount");
String pay_ID_group=request.getParameter("pay_ID_group");
String choice_group=request.getParameter("choice_group");
String register=request.getParameter("register");
String register_time=request.getParameter("register_time");
String product_ID=request.getParameter("product_ID");
String demand_amount1=request.getParameter("amount");
String product_name=request.getParameter("product_name");
String[] provider_name=request.getParameterValues("provider_name") ;
String[] provider_ID=request.getParameterValues("provider_ID") ;
String[] contact_person=request.getParameterValues("contact_person1") ;
String[] provider_tel=request.getParameterValues("provider_tel1") ;
String[] demand_gather_time=request.getParameterValues("demand_gather_time1") ;
String[] demand_amount=request.getParameterValues("demand_amount") ;
String[] demand_price=request.getParameterValues("demand_price") ;
double demand_amount8=0.0d;
double demand_cost_price_sum8=0.0d;
int n=0;
	StringTokenizer tokenTO2 = new StringTokenizer(choice_group,", ");        
	while(tokenTO2.hasMoreTokens()) {
        String sql5="select * from purchase_apply where purchase_tag='1' and id='"+tokenTO2.nextToken()+"'";
		ResultSet rs5=purchase_db.executeQuery(sql5) ;
		if(rs5.next()){
			n++;
		}
		}
if(n==0){

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
String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
time=formatter.format(now);


demand_amount_sum=0.0d;
double demand_cost_price_sum=0.0d;
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
for(int i=0;i<provider_ID.length;i++){
	if(!demand_amount[i].equals("")){
		if(Double.parseDouble(demand_amount[i])!=0){
		demand_amount_sum+=Double.parseDouble(demand_amount[i]);
		}
	}
}
if(demand_amount_sum==Double.parseDouble(amount)){
	StringTokenizer tokenTO = new StringTokenizer(choice_group,", ");        
	while(tokenTO.hasMoreTokens()) {
        String sql4="update purchase_apply set purchase_tag='1' where id='"+tokenTO.nextToken()+"'";
		purchase_db.executeUpdate(sql4) ;
		}
String purchase_ID=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));	  
     
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
		demand_cost_price_sum+=subtotal;
		String sql="insert into purchase_details(purchase_ID,details_number,provider_ID,provider_name,demand_contact_person,demand_contact_person_tel,demand_amount,demand_price,demand_cost_price_sum,demand_gather_time) values('"+purchase_ID+"','"+m+"','"+provider_ID[i]+"','"+provider_name[i]+"','"+contact_person[i]+"','"+provider_tel[i]+"','"+amount8+"','"+demand_price2+"','"+subtotal+"','"+demand_gather_time[i]+"')";
		purchase_db.executeUpdate(sql);
		m++;
	}
}
double price=demand_cost_price_sum/demand_amount_sum;
String sql1="insert into purchase_purchase(purchase_ID,product_ID,product_name,register,register_time,demand_amount,demand_price,demand_cost_price_sum,pay_ID_group,apply_ID_group,check_tag) values('"+purchase_ID+"','"+product_ID+"','"+product_name+"','"+register+"','"+register_time+"','"+demand_amount_sum+"','"+price+"','"+demand_cost_price_sum+"','"+pay_ID_group+"','"+choice_group+"','5')";
purchase_db.executeUpdate(sql1);

   	String sqll = "update purchase_purchase set purchase_tag='1',invoice_tag='1',gather_tag='1',stock_gather_tag='1',pay_tag='1' where purchase_ID='"+purchase_ID+"'" ;
	purchase_db.executeUpdate(sqll) ;
	

response.sendRedirect("purchase/purchase/register_choose.jsp?purchase_ID="+purchase_ID+"");
	}else{
	response.sendRedirect("purchase/purchase/register_draft_ok.jsp?finished_tag=0");
	}
	}else{
		response.sendRedirect("purchase/purchase/register_draft_ok.jsp?finished_tag=0");
		}
  }else{
		response.sendRedirect("purchase/purchase/register_draft_ok.jsp?finished_tag=1");
	  }
}else{
	response.sendRedirect("purchase/purchase/register_draft_ok.jsp?finished_tag=2");
}
	purchase_db.commit();
	purchase_db.close();

}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
} 