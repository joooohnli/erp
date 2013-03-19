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
import include.nseer_cookie.FileKind;
import validata.ValidataNumber;
import validata.ValidataRecordNumber;
import purchase.Fieldvalue;

public class dealwith_purchase_ok extends HttpServlet{

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
nseer_db_backup1 purchase_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 fund_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 finance_db = new nseer_db_backup1(dbApplication);

if(purchase_db.conn((String)dbSession.getAttribute("unit_db_name"))&&stock_db.conn((String)dbSession.getAttribute("unit_db_name"))&&fund_db.conn((String)dbSession.getAttribute("unit_db_name"))&&finance_db.conn((String)dbSession.getAttribute("unit_db_name"))){

counter count=new counter(dbApplication);
ValidataNumber validata=new ValidataNumber();
FileKind FileKind=new FileKind();
ValidataRecordNumber vrn=new ValidataRecordNumber();
Fieldvalue fieldvalue=new Fieldvalue();
String gather_ID=request.getParameter("gather_ID") ;
String type=request.getParameter("type") ;
String provider_ID=request.getParameter("provider_ID") ;
String provider_name=request.getParameter("provider_name") ;
String purchasecredit_cost_price_sum1=request.getParameter("purchasecredit_cost_price_sum") ;
String original_cost_price_sum=request.getParameter("original_cost_price_sum") ;
String register_time=request.getParameter("register_time") ;
String purchaser_ID=request.getParameter("purchaser_ID") ;
String purchaser=request.getParameter("purchaser") ;
String[] aaa1=FileKind.getKind((String)dbSession.getAttribute("unit_db_name"),"purchase_file","provider_ID",provider_ID);
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
if(n==0){
double gather_amount_sum=0;
double balance_amount_sum=0;
double cost_price_sum=0.0d;
double balance_cost_price_sum=0.0d;
double dealwith_cost_price_sum=0.0d;
double stock_product_number=0;
double stock_price=0.0d;
for(int i=1;i<=num;i++){	
	String purchase_ID=NseerId.getId("purchase/purchase",(String)dbSession.getAttribute("unit_db_name"));		
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
String list_price=fieldvalue.getValue((String)dbSession.getAttribute("unit_db_name"),"design_file","product_ID",product_ID,"list_price");
String amount_unit=request.getParameter(tem_amount_unit) ;
	double amount=0.0d;
	double balance_amount=Double.parseDouble(amount1)-Double.parseDouble(dealwith_amount);
	double balance_subtotal=Double.parseDouble(cost_price)*balance_amount;
	double subtotal=Double.parseDouble(cost_price)*Double.parseDouble(amount1);
	double cost_price_after_discount_sum=Double.parseDouble(cost_price)*Double.parseDouble(amount1);
	cost_price_sum+=subtotal;
	balance_cost_price_sum+=balance_subtotal;
	double dealwith_subtotal=Double.parseDouble(cost_price)*(1-Double.parseDouble(off_discount)/100)*Double.parseDouble(dealwith_amount);
	double list_price_sum=Double.parseDouble(list_price)*Double.parseDouble(dealwith_amount);
	dealwith_cost_price_sum+=dealwith_subtotal;
	gather_amount_sum+=Double.parseDouble(dealwith_amount);
	balance_amount_sum+=balance_amount;
double cost_price_after_discount=Double.parseDouble(cost_price)*(1-Double.parseDouble(off_discount)/100);
	String sql1="insert into purchase_details(purchase_ID,details_number,provider_ID,provider_name,demand_amount,demand_price,demand_cost_price_sum,demand_gather_time) values('"+purchase_ID+"','1','"+provider_ID+"','"+provider_name+"','"+dealwith_amount+"','"+cost_price_after_discount+"','"+dealwith_subtotal+"','"+register_time+"')";
		purchase_db.executeUpdate(sql1);
	String sql1a="insert into purchase_purchase(purchase_ID,product_ID,product_name,register,register_time,demand_amount,demand_price,demand_cost_price_sum,check_tag,pay_ID_group,check_time,list_price_sum,real_cost_price_sum) values('"+purchase_ID+"','"+product_ID+"','"+product_name+"','"+register+"','"+register_time+"','"+dealwith_amount+"','"+cost_price_after_discount+"','"+dealwith_subtotal+"','1','放货转采购','"+register_time+"','"+list_price_sum+"','"+dealwith_subtotal+"')";
	purchase_db.executeUpdate(sql1a) ;

	String sqllaa = "update purchase_purchase set check_tag='2',purchase_tag='1',invoice_tag='1',gather_tag='1',stock_gather_tag='3',pay_tag='1' where purchase_ID='"+purchase_ID+"'" ;
	purchase_db.executeUpdate(sqllaa) ;
String sql2="select * from stock_balance_details where product_ID='"+product_ID+"' and stock_name='采购放货'";
ResultSet rs2=stock_db.executeQuery(sql2);
if(rs2.next()){
	double stock_balance_details_amount=rs2.getDouble("amount")+Double.parseDouble(dealwith_amount);
	double stock_subtotal=rs2.getDouble("subtotal")+rs2.getDouble("cost_price")*Double.parseDouble(dealwith_amount);
	String sql3="update stock_balance_details set amount='"+stock_balance_details_amount+"',subtotal='"+stock_subtotal+"' where product_ID='"+product_ID+"' and stock_name='采购放货'";
	stock_db.executeUpdate(sql3);
}
String sql4="select * from stock_balance where product_ID='"+product_ID+"'";
ResultSet rs4=stock_db.executeQuery(sql4);
if(rs4.next()){
	double stock_balance_amount=rs4.getDouble("amount")+Double.parseDouble(dealwith_amount);
	double stock_cost_price_sum=rs4.getDouble("cost_price_sum")+rs4.getDouble("cost_price")*Double.parseDouble(dealwith_amount);
	String sql5="update stock_balance set amount='"+stock_balance_amount+"',cost_price_sum='"+stock_cost_price_sum+"' where product_ID='"+product_ID+"'";
	stock_db.executeUpdate(sql5);
}
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
if(vrn.validata((String)dbSession.getAttribute("unit_db_name"),"fund_fund","reasonexact",purchase_ID)<=num){
	String fund_ID=NseerId.getId("fund/pay",(String)dbSession.getAttribute("unit_db_name"));
	String sql9="insert into fund_fund(fund_ID,reason,reasonexact,chain_id,chain_name,funder,funder_ID,file_chain_id,file_chain_name,demand_cost_price_sum,currency_name,personal_unit,register,register_time,sales_purchaser_ID,sales_purchaser_name) values('"+fund_ID+"','付款','"+purchase_ID+"','"+aaa1[0]+"','"+aaa1[1]+"','"+provider_name+"','"+provider_ID+"','2121','应付账款','"+dealwith_subtotal+"','人民币','元','"+register+"','"+register_time+"','"+purchaser_ID+"','"+purchaser+"')";
	fund_db.executeUpdate(sql9) ;
}
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
	trade_amount=rs7.getInt("trade_amount");
	achievement_sum=rs7.getDouble("achievement_sum");
	return_amount=rs7.getInt("return_amount");
	return_sum=rs7.getDouble("return_sum");
	purchasecredit_cost_price_sum=rs7.getDouble("purchasecredit_cost_price_sum")-changed_cost_price_sum;
	}
if(dealwith_cost_price_sum>0){
	trade_amount+=1;
	achievement_sum+=dealwith_cost_price_sum;
}else{
	trade_amount+=1;
	return_amount+=1;
	achievement_sum+=dealwith_cost_price_sum;
	return_sum+=dealwith_cost_price_sum;
}
String sql8="update purchase_file set trade_amount='"+trade_amount+"',return_amount='"+return_amount+"',achievement_sum='"+achievement_sum+"',return_sum='"+return_sum+"',lately_trade_time='"+register_time+"',purchasecredit_cost_price_sum='"+purchasecredit_cost_price_sum+"' where provider_ID='"+provider_ID+"'";
purchase_db.executeUpdate(sql8);	
	response.sendRedirect("purchase/credit/dealwith_purchase_ok_a.jsp");
	}else{	
	session.setAttribute("gather_ID",gather_ID);
	session.setAttribute("purchaser_ID",purchaser_ID);
	session.setAttribute("purchaser",purchaser);
	session.setAttribute("purchasecredit_cost_price_sum1",purchasecredit_cost_price_sum1);
	response.sendRedirect("purchase/credit/dealwith_purchase_ok_b.jsp");
}
}else{
	response.sendRedirect("error_conn.htm");
}
finance_db.commit();
	fund_db.commit();
	purchase_db.commit();
	stock_db.commit();
	finance_db.close();
	fund_db.close();
	purchase_db.close();
	stock_db.close();
}
catch (Exception ex){
ex.printStackTrace();
}
}
} 