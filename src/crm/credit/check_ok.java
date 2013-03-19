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
import include.nseer_cookie.*;
import include.nseer_db.*;
import java.text.*;
import validata.ValidataNumber;
import validata.ValidataRecord;
import validata.ValidataTag;


public class check_ok extends HttpServlet{
ServletContext application;
HttpSession session;
nseer_db_backup1 erp_db = null;

public synchronized void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{
PrintWriter out=response.getWriter();
nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 crm_db = new nseer_db_backup1(dbApplication);
if(stock_db.conn((String)dbSession.getAttribute("unit_db_name"))&&crm_db.conn((String)dbSession.getAttribute("unit_db_name"))){
FileKind  FileKind = new  FileKind();
ValidataNumber validata= new  ValidataNumber();
ValidataRecord vr= new   ValidataRecord();
ValidataTag  vt= new  ValidataTag();
String register_ID=(String)dbSession.getAttribute("human_IDD");
String config_id=request.getParameter("config_id");
String pay_ID=request.getParameter("pay_ID") ;
String product_amount=request.getParameter("product_amount") ;
int num=Integer.parseInt(product_amount);
String payer_name=request.getParameter("payer_name") ;
String payer_ID=request.getParameter("payer_ID") ;
String reason=request.getParameter("reason") ;
String not_return_tag=request.getParameter("not_return_tag") ;
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String demand_return_time=request.getParameter("demand_return_time") ;
String check_time=request.getParameter("check_time") ;
String checker=request.getParameter("checker") ;
String checker_ID=request.getParameter("checker_ID") ;
String bodyc = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyc);
String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
time=formatter.format(now);
int p=0;
for(int i=1;i<=num;i++){
	String tem_amount="amount"+i;
String amount=request.getParameter(tem_amount) ;
if(amount.equals("")) amount="0";
	if(!validata.validata(amount)){
			p++;
		}
}
String sql6="select id from crm_workflow where object_ID='"+pay_ID+"' and ((check_tag='0' and config_id<'"+config_id+"') or (check_tag='1' and config_id='"+config_id+"'))";
ResultSet rs6=crm_db.executeQuery(sql6);
if(!rs6.next()){
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"stock_apply_pay","pay_ID",pay_ID,"check_tag").equals("0")){

if(p==0){
try{

int n=0;

if(n==0){
sql6 = "update crm_workflow set checker='"+checker+"',checker_ID='"+checker_ID+"',check_time='"+check_time+"',check_tag='1' where object_ID='"+pay_ID+"' and config_id='"+config_id+"'" ;
	crm_db.executeUpdate(sql6);
boolean flag=false;
sql6="select id from crm_workflow where object_ID='"+pay_ID+"' and check_tag='0'";
	ResultSet rset=crm_db.executeQuery(sql6);
	if(!rset.next()){
		flag=true;
	}	
String sqll = "" ;
String[] aaa1=FileKind.getKind((String)dbSession.getAttribute("unit_db_name"),"crm_file","customer_ID",payer_ID);
String mod="/erp/stock_pay_register_ok";
String stock_pay_ID="";
if(flag){
stock_pay_ID=NseerId.getId("stock/pay",(String)dbSession.getAttribute("unit_db_name"));
}
double demand_amount=0.0d;
double list_price_sum=0.0d;
double cost_price_sum=0.0d;
for(int i=1;i<=num;i++){
	String tem_product_name="product_name"+i;
	String tem_product_ID="product_ID"+i;
	String tem_available_amount="available_amount"+i;
	String tem_amount="amount"+i;
	String tem_list_price="list_price"+i;
	String tem_cost_price="cost_price"+i;
	String tem_type="type"+i;
	String tem_amount_unit="amount_unit"+i ;
String product_name=request.getParameter(tem_product_name) ;
String product_ID=request.getParameter(tem_product_ID) ;
String available_amount=request.getParameter(tem_available_amount) ;
String amount=request.getParameter(tem_amount) ;
if(amount.equals("")) amount="0";
String list_price2=request.getParameter(tem_list_price) ;
String cost_price=request.getParameter(tem_cost_price) ;
String type=request.getParameter(tem_type) ;
StringTokenizer tokenTO3 = new StringTokenizer(list_price2,",");        
String list_price="";
            while(tokenTO3.hasMoreTokens()) {
                String list_price1 = tokenTO3.nextToken();
		list_price +=list_price1;
		}
String amount_unit=request.getParameter(tem_amount_unit) ;
	double list_price_subtotal=Double.parseDouble(list_price)*Double.parseDouble(amount);
	list_price_sum+=list_price_subtotal;
	double cost_price_subtotal=Double.parseDouble(cost_price)*Double.parseDouble(amount);
	cost_price_sum+=cost_price_subtotal;
	demand_amount+=Double.parseDouble(amount);
	String sql1 = "update stock_apply_pay_details set amount='"+amount+"',list_price='"+list_price+"',list_price_subtotal='"+list_price_subtotal+"',cost_price='"+cost_price+"',subtotal='"+cost_price_subtotal+"' where pay_ID='"+pay_ID+"' and details_number='"+i+"'" ;
	stock_db.executeUpdate(sql1) ;
if(flag){
	if(type.equals("物料")||type.equals("外购商品")){
	String sql2="insert into stock_pay_details(pay_ID,details_number,product_ID,product_name,type,list_price,list_price_subtotal,cost_price,subtotal,amount,unpay_amount,apply_manufacture_amount,apply_purchase_amount) values('"+stock_pay_ID+"','"+i+"','"+product_ID+"','"+product_name+"','"+type+"','"+list_price+"','"+list_price_subtotal+"','"+cost_price+"','"+cost_price_subtotal+"','"+amount+"','"+amount+"','0','"+amount+"')";
	stock_db.executeUpdate(sql2);
}else if(type.equals("商品")||type.equals("部件")||type.equals("委外部件")){
	String sql2="insert into stock_pay_details(pay_ID,details_number,product_ID,product_name,type,list_price,list_price_subtotal,cost_price,subtotal,amount,unpay_amount,apply_manufacture_amount,apply_purchase_amount) values('"+stock_pay_ID+"','"+i+"','"+product_ID+"','"+product_name+"','"+type+"','"+list_price+"','"+list_price_subtotal+"','"+cost_price+"','"+cost_price_subtotal+"','"+amount+"','"+amount+"','"+amount+"','0')";
	stock_db.executeUpdate(sql2);
}
	
	String sql97="select * from crm_salecredit_balance_details where crediter_ID='"+payer_ID+"' and product_ID='"+product_ID+"'";
	ResultSet rs97=crm_db.executeQuery(sql97);
	if(rs97.next()){
		double balance_amount=rs97.getDouble("amount")+Double.parseDouble(amount);
				double balance_cost_price_subtotal=rs97.getDouble("subtotal")+cost_price_subtotal;
		double balance_list_price_subtotal=rs97.getDouble("list_price_subtotal")+list_price_subtotal;

String sql96 = "update crm_salecredit_balance_details set amount='"+balance_amount+"',check_tag='1',subtotal='"+balance_cost_price_subtotal+"',list_price_subtotal='"+balance_list_price_subtotal+"' where crediter_ID='"+payer_ID+"' and product_ID='"+product_ID+"'" ;
	crm_db.executeUpdate(sql96);
	}else{
		String[] aaa=FileKind.getKind((String)dbSession.getAttribute("unit_db_name"),"design_file","product_ID",product_ID);
		String sql95="insert into crm_salecredit_balance_details(chain_ID,chain_name,crediter_chain_ID,crediter_chain_name,product_ID,product_name,list_price,list_price_subtotal,cost_price,subtotal,amount,crediter_ID,crediter_name) values('"+aaa[0]+"','"+aaa[1]+"','"+aaa1[0]+"','"+aaa1[1]+"','"+product_ID+"','"+product_name+"','"+list_price+"','"+list_price_subtotal+"','"+cost_price+"','"+cost_price_subtotal+"','"+amount+"','"+payer_ID+"','"+payer_name+"')";
		crm_db.executeUpdate(sql95);
	}
}
}
	String sql = "update stock_apply_pay set reason='"+reason+"',register='"+register+"',register_time='"+register_time+"',demand_return_time='"+demand_return_time+"',check_time='"+check_time+"',checker='"+checker+"',remark='"+remark+"',demand_amount='"+demand_amount+"',list_price_sum='"+list_price_sum+"',cost_price_sum='"+cost_price_sum+"',not_return_tag='"+not_return_tag+"' where pay_ID='"+pay_ID+"'" ;
	stock_db.executeUpdate(sql) ;
if(flag){
sql = "update stock_apply_pay set check_tag='1' where pay_ID='"+pay_ID+"'" ;
	stock_db.executeUpdate(sql) ;
if(!vr.validata((String)dbSession.getAttribute("unit_db_name"),"stock_pay","reasonexact",pay_ID)){
	String sql4="insert into stock_pay(pay_ID,reason,reasonexact,reasonexact_details,demand_amount,list_price_sum,cost_price_sum,register,register_time) values('"+stock_pay_ID+"','"+reason+"','"+pay_ID+"','"+payer_name+"','"+demand_amount+"','"+list_price_sum+"','"+cost_price_sum+"','"+checker+"','"+check_time+"')";
	stock_db.executeUpdate(sql4) ;
}

String sql98="select * from crm_file where customer_ID='"+payer_ID+"'";
ResultSet rs98=crm_db.executeQuery(sql98);
if(rs98.next()){
	double salecredit_list_price_sum=rs98.getDouble("salecredit_list_price_sum")+list_price_sum;
		double salecredit_cost_price_sum=rs98.getDouble("salecredit_cost_price_sum")+cost_price_sum;

String sql99 = "update crm_file set CREDIT_YES_OR_NOT_TAG='1',SALECREDIT_LIST_PRICE_SUM='"+salecredit_list_price_sum+"',SALECREDIT_COST_PRICE_SUM='"+salecredit_cost_price_sum+"' where customer_ID='"+payer_ID+"' " ;
	crm_db.executeUpdate(sql99) ;}
}

response.sendRedirect("crm/credit/check_ok.jsp?finished_tag=0");
}else{
	
response.sendRedirect("crm/credit/check_ok.jsp?finished_tag=1&pay_ID="+pay_ID+"");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}else{
	
response.sendRedirect("crm/credit/check_ok.jsp?finished_tag=2&pay_ID="+pay_ID+"");
}}else{
	

response.sendRedirect("crm/credit/check_ok.jsp?finished_tag=3");
}
}else{
response.sendRedirect("crm/credit/check_ok.jsp?finished_tag=4");
}
stock_db.commit();
crm_db.commit();
stock_db.close();
crm_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
	ex.printStackTrace();
}
}
}