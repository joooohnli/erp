/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package purchase.credit; 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import java.text.*;

import include.nseer_cookie.NseerId;
import include.nseer_cookie.exchange;
import include.nseer_cookie.counter;
import validata.ValidataNumber;
import validata.ValidataRecord;
import validata.ValidataTag;
import include.get_name_from_ID.getNameFromID;
import include.get_rate_from_ID.getRateFromID;

public class dealwith_pay_ok extends HttpServlet{

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
nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 purchase_db = new nseer_db_backup1(dbApplication);
if(purchase_db.conn((String)dbSession.getAttribute("unit_db_name"))&&stock_db.conn((String)dbSession.getAttribute("unit_db_name"))){

counter count=new counter(dbApplication);
ValidataNumber validata=new ValidataNumber();
ValidataRecord vr=new ValidataRecord();
ValidataTag vt=new ValidataTag();
getNameFromID getNameFromID=new getNameFromID();
getRateFromID getRateFromID=new getRateFromID();
String gather_ID=request.getParameter("gather_ID") ;
String type=request.getParameter("type") ;
String provider_ID=request.getParameter("provider_ID") ;
String provider_name=request.getParameter("provider_name") ;
String purchasecredit_cost_price_sum1=request.getParameter("purchasecredit_cost_price_sum") ;
String register_time=request.getParameter("register_time") ;
String purchaser_ID=request.getParameter("purchaser_ID") ;
String purchaser=request.getParameter("purchaser") ;
String register=request.getParameter("register") ;
String register_ID=request.getParameter("register_ID") ;
String bodyc = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyc);
String product_amount=request.getParameter("product_amount") ;
int num=Integer.parseInt(product_amount);
int n=0;
for(int i=1;i<=num;i++){
	String tem_dealwith_amount="dealwith_amount"+i;
	String tem_off_discount="off_discount"+i;
	String tem_cost_price="cost_price"+i;
	String tem_amount="amount"+i;
String dealwith_amount=request.getParameter(tem_dealwith_amount) ;
String amount1=request.getParameter(tem_amount) ;
String off_discount=request.getParameter(tem_off_discount) ;
if(off_discount.equals("")) off_discount="0";
String cost_price2=request.getParameter(tem_cost_price) ;
StringTokenizer tokenTO2 = new StringTokenizer(cost_price2,",");        
String cost_price="";
            while(tokenTO2.hasMoreTokens()) {
                String cost_price1 = tokenTO2.nextToken();
		cost_price +=cost_price1;
		}
		if(!validata.validata(dealwith_amount)||!validata.validata(off_discount)||!validata.validata(cost_price)||Double.parseDouble(dealwith_amount)>Double.parseDouble(amount1)){
			n++;
		}
}
String stock_pay_ID=NseerId.getId("stock/pay",(String)dbSession.getAttribute("unit_db_name"));	
if(n==0){  
int service_count=0;
int gather_amount_sum=0;
int balance_amount_sum=0;
double cost_price_sum=0.0d;
double balance_cost_price_sum=0.0d;
double dealwith_cost_price_sum=0.0d;
int stock_number=1;
double stock_product_number=0;
double stock_price=0.0d;
double pay_amount_sum=0.0d;
for(int i=1;i<=num;i++){
	String tem_product_name="product_name"+i;
	String tem_product_ID="product_ID"+i;
	String tem_product_describe="product_describe"+i;
	String tem_amount="amount"+i;
	String tem_dealwith_amount="dealwith_amount"+i;
	String tem_off_discount="off_discount"+i;
	String tem_cost_price="cost_price"+i;
	String tem_amount_unit="amount_unit"+i ;
String product_name=request.getParameter(tem_product_name) ;
String product_ID=request.getParameter(tem_product_ID) ;
String product_describe=request.getParameter(tem_product_describe) ;
String amount1=request.getParameter(tem_amount) ;
String dealwith_amount=request.getParameter(tem_dealwith_amount) ;
String off_discount=request.getParameter(tem_off_discount) ;
if(off_discount.equals("")) off_discount="0";
String cost_price2=request.getParameter(tem_cost_price) ;
StringTokenizer tokenTO2 = new StringTokenizer(cost_price2,",");        
String cost_price="";
            while(tokenTO2.hasMoreTokens()) {
                String cost_price1 = tokenTO2.nextToken();
		cost_price +=cost_price1;
		}
String amount_unit=request.getParameter(tem_amount_unit) ;
double amount=0.0d;
	double balance_amount=Double.parseDouble(amount1)-Double.parseDouble(dealwith_amount);
	double balance_subtotal=Double.parseDouble(cost_price)*balance_amount;
	double subtotal=Double.parseDouble(cost_price)*Double.parseDouble(amount1);
	cost_price_sum+=subtotal;
	balance_cost_price_sum+=balance_subtotal;
	double dealwith_subtotal=Double.parseDouble(cost_price)*(1-Double.parseDouble(off_discount)/100)*Double.parseDouble(dealwith_amount);
	dealwith_cost_price_sum+=dealwith_subtotal;
	pay_amount_sum+=Double.parseDouble(dealwith_amount);
	balance_amount_sum+=balance_amount;
	String sql1="insert into stock_pay_details(pay_ID,details_number,product_ID,product_name,cost_price,subtotal,amount,unpay_amount) values('"+stock_pay_ID+"','"+i+"','"+product_ID+"','"+product_name+"','"+cost_price+"','"+dealwith_subtotal+"','"+dealwith_amount+"','"+dealwith_amount+"')";
	stock_db.executeUpdate(sql1) ;
String sql6="update stock_apply_gather_details set amount='"+balance_amount+"',subtotal='"+balance_subtotal+"' where gather_ID='"+gather_ID+"' and product_ID='"+product_ID+"'";
stock_db.executeUpdate(sql6);
String sql97="select * from purchase_purchasecredit_balance_details where crediter_ID='"+provider_ID+"' and product_ID='"+product_ID+"'";
	ResultSet rs97=purchase_db.executeQuery(sql97);
	if(rs97.next()){
		double purchasecredit_balance_amount=rs97.getDouble("amount")-Double.parseDouble(dealwith_amount);
		double purchasecredit_balance_cost_price_subtotal=rs97.getDouble("subtotal")-dealwith_subtotal;
String sql96 = "update purchase_purchasecredit_balance_details set amount='"+purchasecredit_balance_amount+"',subtotal='"+purchasecredit_balance_cost_price_subtotal+"' where crediter_ID='"+provider_ID+"' and product_ID='"+product_ID+"'" ;
purchase_db.executeUpdate(sql96);
	}
}
if(!vr.validata((String)dbSession.getAttribute("unit_db_name"),"stock_pay","reasonexact",stock_pay_ID)){
	String sql="insert into stock_pay(pay_ID,reason,reasonexact,reasonexact_details,demand_amount,cost_price_sum,register,register_time) values('"+stock_pay_ID+"','采购放货','"+gather_ID+"','"+provider_name+"','"+pay_amount_sum+"','"+dealwith_cost_price_sum+"','"+register+"','"+register_time+"')";
	stock_db.executeUpdate(sql) ;
}
String sql10="update stock_apply_gather set demand_amount='"+balance_amount_sum+"',cost_price_sum='"+balance_cost_price_sum+"' where gather_ID='"+gather_ID+"'";
stock_db.executeUpdate(sql10);
double changed_cost_price_sum=cost_price_sum-balance_cost_price_sum;
int trade_amount=0;
double achievement_sum=0.0d;
double purchasecredit_cost_price_sum=0.0d;
int return_amount=0;
double return_sum=0.0d;
String sql7="select * from purchase_file where provider_ID='"+provider_ID+"'";
ResultSet rs7=purchase_db.executeQuery(sql7);
if(rs7.next()){
	purchasecredit_cost_price_sum=rs7.getDouble("purchasecredit_cost_price_sum")-changed_cost_price_sum;
}
String sql8="update purchase_file set purchasecredit_cost_price_sum='"+purchasecredit_cost_price_sum+"' where provider_ID='"+provider_ID+"'";
purchase_db.executeUpdate(sql8);
	response.sendRedirect("purchase/credit/dealwith_pay_ok_a.jsp");
	}else{
	session.setAttribute("gather_ID",gather_ID);
	session.setAttribute("purchaser_ID",purchaser_ID);
	session.setAttribute("purchaser",purchaser);
	session.setAttribute("purchasecredit_cost_price_sum1",purchasecredit_cost_price_sum1);
	response.sendRedirect("purchase/credit/dealwith_pay_ok_b.jsp");
}
	purchase_db.commit();
	stock_db.commit();
	purchase_db.close();
	stock_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}