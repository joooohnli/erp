/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package crm.credit;


import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.util.*;
import java.io.* ;
import include.nseer_cookie.* ;
import include.nseer_db.*;
import java.text.*;
import validata.ValidataNumber;
import validata.ValidataRecord;
import validata.ValidataTag;
import include.get_three_kinds.getThreeKinds;
import include.get_three_kinds.getThreeKinds1;
import include.get_name_from_ID.getNameFromID;
import include.get_rate_from_ID.getRateFromID;


public class dealwith_gather_ok extends HttpServlet{
ServletContext application;
HttpSession session;
nseer_db_backup1 erp_db = null;

public synchronized void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
time=formatter.format(now);
try{
HttpSession session=request.getSession();
PrintWriter out=response.getWriter();

nseer_db_backup1 crm_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);
if(crm_db.conn((String)dbSession.getAttribute("unit_db_name"))&&stock_db.conn((String)dbSession.getAttribute("unit_db_name"))){

counter count=new counter(dbApplication);
ValidataNumber  validata= new  ValidataNumber();
ValidataRecord  vr= new ValidataRecord();
ValidataTag  vt= new  ValidataTag();
getThreeKinds  getThreeKinds= new getThreeKinds();
getThreeKinds1 getThreeKinds1= new  getThreeKinds1();
getNameFromID  getNameFromID= new getNameFromID();
getRateFromID  getRateFromID= new getRateFromID();

String pay_ID=request.getParameter("pay_ID") ;
String type=request.getParameter("type") ;
String customer_ID=request.getParameter("customer_ID") ;
String customer_name=request.getParameter("customer_name") ;
String salecredit_list_price_sum1=request.getParameter("salecredit_list_price_sum") ;
String original_list_price_sum=request.getParameter("original_list_price_sum") ;
String register_time=request.getParameter("register_time") ;
String sales_ID=request.getParameter("sales_ID") ;
String sales_name=request.getParameter("sales_name") ;
String[] aaa={"",""};
if(!sales_ID.equals("")){
aaa=getThreeKinds.getThreeKinds((String)dbSession.getAttribute("unit_db_name"),"hr_file","human_ID",sales_ID);
}
String[] aaa1=getThreeKinds1.getThreeKinds((String)dbSession.getAttribute("unit_db_name"),"crm_file","customer_ID",customer_ID);
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
	String tem_list_price="list_price"+i;
	String tem_amount="amount"+i;
String dealwith_amount=request.getParameter(tem_dealwith_amount) ;
String amount1=request.getParameter(tem_amount) ;
String off_discount=request.getParameter(tem_off_discount) ;
if(off_discount.equals("")) off_discount="0";
String list_price2=request.getParameter(tem_list_price) ;
StringTokenizer tokenTO2 = new StringTokenizer(list_price2,",");        
String list_price="";
            while(tokenTO2.hasMoreTokens()) {
                String list_price1 = tokenTO2.nextToken();
		list_price +=list_price1;
		}
		if(!validata.validata(dealwith_amount)||!validata.validata(off_discount)||!validata.validata(list_price)||Double.parseDouble(dealwith_amount)>Double.parseDouble(amount1)){
			n++;
		}
}
if(n==0){
String stock_gather_ID=NseerId.getId("stock/gather",(String)dbSession.getAttribute("unit_db_name"));
int service_count=0;
int pay_amount_sum=0;
int balance_amount_sum=0;
double sale_price_sum=0.0d;
double cost_price_sum=0.0d;
double balance_sale_price_sum=0.0d;
double balance_cost_price_sum=0.0d;
double dealwith_sale_price_sum=0.0d;
double dealwith_cost_price_sum=0.0d;
int stock_number=1;
double stock_product_number=0;
double stock_price=0.0d;
double order_sale_bonus_sum=0.00d;
double order_profit_bonus_sum=0.00d;
for(int i=1;i<=num;i++){
	String tem_product_name="product_name"+i;
	String tem_product_ID="product_ID"+i;
	String tem_product_describe="product_describe"+i;
	String tem_amount="amount"+i;
	String tem_dealwith_amount="dealwith_amount"+i;
	String tem_off_discount="off_discount"+i;
	String tem_list_price="list_price"+i;
	String tem_cost_price="cost_price"+i;
	String tem_amount_unit="amount_unit"+i ;
String product_name=request.getParameter(tem_product_name) ;
String product_ID=request.getParameter(tem_product_ID) ;
String product_describe=request.getParameter(tem_product_describe) ;
String amount1=request.getParameter(tem_amount) ;
String dealwith_amount=request.getParameter(tem_dealwith_amount) ;
String off_discount=request.getParameter(tem_off_discount) ;
if(off_discount.equals("")) off_discount="0";
String list_price2=request.getParameter(tem_list_price) ;
StringTokenizer tokenTO2 = new StringTokenizer(list_price2,",");        
String list_price="";
            while(tokenTO2.hasMoreTokens()) {
                String list_price1 = tokenTO2.nextToken();
		list_price +=list_price1;
		}
String cost_price2=request.getParameter(tem_cost_price) ;
StringTokenizer tokenTO3 = new StringTokenizer(cost_price2,",");        
String cost_price="";
            while(tokenTO3.hasMoreTokens()) {
                String cost_price1 = tokenTO3.nextToken();
		cost_price +=cost_price1;
		}
String amount_unit=request.getParameter(tem_amount_unit) ;
double amount=0.0d;
	double balance_amount=Double.parseDouble(amount1)-Double.parseDouble(dealwith_amount);
	double balance_subtotal=Double.parseDouble(list_price)*balance_amount;
	double balance_cost_price_after_discount_sum=Double.parseDouble(cost_price)*balance_amount;
	double subtotal=Double.parseDouble(list_price)*Double.parseDouble(amount1);
	double cost_price_after_discount_sum=Double.parseDouble(cost_price)*Double.parseDouble(amount1);
	sale_price_sum+=subtotal;
	cost_price_sum+=cost_price_after_discount_sum;
	balance_sale_price_sum+=balance_subtotal;
	balance_cost_price_sum+=balance_cost_price_after_discount_sum;
	double dealwith_subtotal=Double.parseDouble(list_price)*(1-Double.parseDouble(off_discount)/100)*Double.parseDouble(dealwith_amount);
	double dealwith_cost_price_after_discount_sum=Double.parseDouble(cost_price)*Double.parseDouble(dealwith_amount);
	dealwith_sale_price_sum+=dealwith_subtotal;
	dealwith_cost_price_sum+=dealwith_cost_price_after_discount_sum;
	pay_amount_sum+=Double.parseDouble(dealwith_amount);
	balance_amount_sum+=balance_amount;
double order_sale_bonus_subtotal=getRateFromID.getRateFromID((String)dbSession.getAttribute("unit_db_name"),"design_file","product_ID",product_ID,"order_sale_bonus_rate")*dealwith_subtotal/100;
double order_profit_bonus_subtotal=getRateFromID.getRateFromID((String)dbSession.getAttribute("unit_db_name"),"design_file","product_ID",product_ID,"order_profit_bonus_rate")*(dealwith_subtotal-dealwith_cost_price_after_discount_sum)/100;
order_sale_bonus_sum+=order_sale_bonus_subtotal;
order_profit_bonus_sum+=order_profit_bonus_subtotal;

	String sql1="insert into stock_gather_details(gather_ID,details_number,product_ID,product_name,cost_price,subtotal,list_price,amount,ungather_amount) values('"+stock_gather_ID+"','"+i+"','"+product_ID+"','"+product_name+"','"+cost_price+"','"+dealwith_cost_price_after_discount_sum+"','"+list_price+"','"+dealwith_amount+"','"+dealwith_amount+"')";
	stock_db.executeUpdate(sql1) ;
String sql6="update stock_apply_pay_details set amount='"+balance_amount+"',subtotal='"+balance_cost_price_after_discount_sum+"',list_price_subtotal='"+balance_subtotal+"' where pay_ID='"+pay_ID+"' and product_ID='"+product_ID+"'";
stock_db.executeUpdate(sql6);
String sql97="select * from crm_salecredit_balance_details where crediter_ID='"+customer_ID+"' and product_ID='"+product_ID+"'";
	ResultSet rs97=crm_db.executeQuery(sql97);
	if(rs97.next()){
		double salecredit_balance_amount=rs97.getDouble("amount")-Double.parseDouble(dealwith_amount);
				double salecredit_balance_cost_price_subtotal=rs97.getDouble("subtotal")-dealwith_cost_price_after_discount_sum;
		double salecredit_balance_list_price_subtotal=rs97.getDouble("list_price_subtotal")-dealwith_subtotal;

String sql96 = "update crm_salecredit_balance_details set amount='"+salecredit_balance_amount+"',subtotal='"+salecredit_balance_cost_price_subtotal+"',list_price_subtotal='"+salecredit_balance_list_price_subtotal+"' where crediter_ID='"+customer_ID+"' and product_ID='"+product_ID+"'" ;
crm_db.executeUpdate(sql96);
	}
}
if(!vr.validata((String)dbSession.getAttribute("unit_db_name"),"stock_gather","reasonexact",pay_ID)){
	String sql="insert into stock_gather(gather_ID,reason,reasonexact,reasonexact_details,demand_amount,list_price_sum,cost_price_sum,register,register_time) values('"+stock_gather_ID+"','销售赊货','"+pay_ID+"','"+customer_name+"','"+pay_amount_sum+"','"+dealwith_sale_price_sum+"','"+dealwith_cost_price_sum+"','"+register+"','"+register_time+"')";
	stock_db.executeUpdate(sql) ;
}
String sql10="update stock_apply_pay set demand_amount='"+balance_amount_sum+"',cost_price_sum='"+balance_cost_price_sum+"',list_price_sum='"+balance_sale_price_sum+"' where pay_ID='"+pay_ID+"'";
stock_db.executeUpdate(sql10);
double changed_list_price_sum=sale_price_sum-balance_sale_price_sum;
double changed_cost_price_sum=cost_price_sum-balance_cost_price_sum;
int trade_amount=0;
double achievement_sum=0.0d;
double salecredit_list_price_sum=0.0d;
double salecredit_cost_price_sum=0.0d;
int return_amount=0;
double return_sum=0.0d;
String sql7="select * from crm_file where customer_ID='"+customer_ID+"'";
ResultSet rs7=crm_db.executeQuery(sql7);
if(rs7.next()){
	salecredit_list_price_sum=rs7.getDouble("salecredit_list_price_sum")-changed_list_price_sum;
	salecredit_cost_price_sum=rs7.getDouble("salecredit_cost_price_sum")-changed_cost_price_sum;
}
String sql8="update crm_file set salecredit_list_price_sum='"+salecredit_list_price_sum+"',salecredit_cost_price_sum='"+salecredit_cost_price_sum+"' where customer_ID='"+customer_ID+"'";
crm_db.executeUpdate(sql8);

	

	response.sendRedirect("crm/credit/dealwith_gather_ok_a.jsp");

	}else{
	

	session.setAttribute("pay_ID",pay_ID);
	session.setAttribute("sales_ID",sales_ID);
	session.setAttribute("sales_name",sales_name);
    session.setAttribute("salecredit_list_price_sum1",salecredit_list_price_sum1);

response.sendRedirect("crm/credit/dealwith_gather_ok_b.jsp");
	}
stock_db.commit();
crm_db.commit();
crm_db.close();
	stock_db.close();

	}else{
	response.sendRedirect("error_conn.htm");
}
	}catch(Exception ex){}
}
}

