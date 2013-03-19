/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package crm.order;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import include.nseer_db.*;
import java.io.*;
import java.util.*;
import java.text.SimpleDateFormat;
import validata.ValidataNumber;
import validata.ValidataRecord;
import validata.ValidataTag;
import include.get_name_from_ID.getNameFromID;
import include.get_rate_from_ID.getRateFromID;
import include.nseer_cookie.*;

public class check_ok extends HttpServlet{
ServletContext application;
HttpSession session;
nseer_db_backup erp_db = null;


	
public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

 
try{
PrintWriter out=response.getWriter();
session=request.getSession();
counter count=new counter(dbApplication);
ValidataNumber validata = new ValidataNumber();
ValidataRecord vr = new ValidataRecord();
ValidataTag vt = new ValidataTag();
FileKind  FileKind= new  FileKind();
getNameFromID getNameFromID = new getNameFromID();
getRateFromID getRateFromID = new getRateFromID();



nseer_db_backup crm_db = new nseer_db_backup(dbApplication);
nseer_db_backup stock_db = new nseer_db_backup(dbApplication);
nseer_db_backup fund_db = new nseer_db_backup(dbApplication);
nseer_db_backup design_db = new nseer_db_backup(dbApplication);
nseer_db_backup hr_db = new nseer_db_backup(dbApplication);
nseer_db_backup finance_db = new nseer_db_backup(dbApplication);

if(crm_db.conn((String)dbSession.getAttribute("unit_db_name"))&&stock_db.conn((String)dbSession.getAttribute("unit_db_name"))&&design_db.conn((String)dbSession.getAttribute("unit_db_name"))&&fund_db.conn((String)dbSession.getAttribute("unit_db_name"))&&hr_db.conn((String)dbSession.getAttribute("unit_db_name"))&&finance_db.conn((String)dbSession.getAttribute("unit_db_name"))){


String register_ID=(String)session.getAttribute("human_IDD");
String config_id=request.getParameter("config_id");
String order_ID=request.getParameter("order_ID") ;
String customer_ID=request.getParameter("customer_ID") ;
String customer_name=request.getParameter("customer_name") ;
String demand_customer_address=request.getParameter("demand_customer_address") ;
String demand_customer_mailing_address=request.getParameter("demand_customer_mailing_address") ;
String demand_contact_person=request.getParameter("demand_contact_person") ;
String demand_contact_person_tel=request.getParameter("demand_contact_person_tel") ;
String demand_contact_person_fax=request.getParameter("demand_contact_person_fax") ;
String demand_pay_time=request.getParameter("demand_pay_time") ;
String demand_pay_type=request.getParameter("demand_pay_type") ;
String demand_pay_fee_type=request.getParameter("demand_pay_fee_type") ;

String demand_gather_time=request.getParameter("demand_gather_time") ;
String demand_gather_type=request.getParameter("demand_gather_type") ;
String demand_gather_method=request.getParameter("demand_gather_method") ;
String demand_invoice_type=request.getParameter("demand_invoice_type") ;
String check_time=request.getParameter("check_time") ;
String sales_ID=request.getParameter("sales_ID") ;
String sales_name=getNameFromID.getNameFromID((String)dbSession.getAttribute("unit_db_name"),"hr_file","human_ID",sales_ID,"human_name");
String[] aaa=new String[2];
if(!sales_ID.equals("")){
aaa=FileKind.getKind((String)dbSession.getAttribute("unit_db_name"),"hr_file","human_ID",sales_ID);
}
String checker=request.getParameter("checker") ;
String checker_ID=request.getParameter("checker_ID") ;
String bodyc = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyc);
String modify_tag=request.getParameter("modify_tag") ;
String product_amount=request.getParameter("product_amount") ;
int num=Integer.parseInt(product_amount);
String demand_pay_fee_sum2=request.getParameter("demand_pay_fee_sum") ;
StringTokenizer tokenTO1 = new StringTokenizer(demand_pay_fee_sum2,",");        
String demand_pay_fee_sum="";
            while(tokenTO1.hasMoreTokens()) {
                String demand_pay_fee_sum1 = tokenTO1.nextToken();
		demand_pay_fee_sum +=demand_pay_fee_sum1;
		}
double order_discount=getRateFromID.getRateFromID((String)dbSession.getAttribute("unit_db_name"),"security_users","human_ID",sales_ID,"order_discount");
double order_discount1=getRateFromID.getRateFromID((String)dbSession.getAttribute("unit_db_name"),"security_users","human_ID",register_ID,"order_discount");
int n=0;
for(int i=1;i<=num;i++){
	String tem_amount="amount"+i;
	String tem_off_discount="off_discount"+i;
	String tem_list_price="list_price"+i;
String amount=request.getParameter(tem_amount) ;
String off_discount=request.getParameter(tem_off_discount) ;
String list_price2=request.getParameter(tem_list_price) ;
StringTokenizer tokenTO2 = new StringTokenizer(list_price2,",");     

String list_price="";
            while(tokenTO2.hasMoreTokens()) {
                String list_price1 = tokenTO2.nextToken();
		list_price +=list_price1;
		}
		if(!validata.validata(amount)||!validata.validata(off_discount)||!validata.validata(list_price)){
			n++;
		}else if(Double.parseDouble(off_discount)>order_discount&&Double.parseDouble(off_discount)>order_discount1){
			n++;
		}
}
String sql6="select id from crm_workflow where object_ID='"+order_ID+"' and which_time='0' and ((check_tag='0' and config_id<'"+config_id+"') or (check_tag='1' and config_id='"+config_id+"'))";
ResultSet rs6=crm_db.executeQuery(sql6);
if(!rs6.next()){
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"crm_order","order_ID",order_ID,"check_tag").equals("0")){
if(n==0){
String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
time=formatter.format(now);

String sql = "update crm_order set order_ID='"+order_ID+"',customer_ID='"+customer_ID+"',customer_name='"+customer_name+"',demand_customer_address='"+demand_customer_address+"',demand_customer_mailing_address='"+demand_customer_mailing_address+"',demand_contact_person='"+demand_contact_person+"',demand_contact_person_tel='"+demand_contact_person_tel+"',demand_contact_person_fax='"+demand_contact_person_fax+"',demand_pay_time='"+demand_pay_time+"',demand_pay_type='"+demand_pay_type+"',demand_pay_fee_type='"+demand_pay_fee_type+"',demand_gather_type='"+demand_gather_type+"',demand_gather_method='"+demand_gather_method+"',demand_invoice_type='"+demand_invoice_type+"',check_time='"+check_time+"',sales_name='"+sales_name+"',sales_ID='"+sales_ID+"',hr_chain_ID='"+aaa[0]+"',hr_chain_name='"+aaa[1]+"',checker='"+checker+"',checker_ID='"+checker_ID+"',remark='"+remark+"',order_type='订单' where order_ID='"+order_ID+"'" ;
	crm_db.executeUpdate(sql) ;
sql = "update crm_workflow set checker='"+checker+"',checker_ID='"+checker_ID+"',check_time='"+check_time+"',check_tag='1' where object_ID='"+order_ID+"' and config_id='"+config_id+"' and which_time='0'" ;
	crm_db.executeUpdate(sql);
boolean flag=false;
sql="select id from crm_workflow where object_ID='"+order_ID+"' and which_time='0' and check_tag='0'";
	ResultSet rset=crm_db.executeQuery(sql);
	if(!rset.next()){
		flag=true;
	}

String pay_ID="";
if(flag){
	pay_ID=NseerId.getId("stock/pay",(String)dbSession.getAttribute("unit_db_name"));
}
try{
int service_count=0;
int pay_amount_sum=0;
double sale_price_sum=0.0d;
double cost_price_sum=0.0d;
double real_cost_price_sum=0.0d;
int stock_number=1;
double stock_product_number=0;
double stock_price=0.0d;
double order_sale_bonus_sum=0.00d;
double order_profit_bonus_sum=0.00d;
String sale_bonus_type="";
		String bonus_cost_for_profit_type="";
String sql_hr2="select * from hr_config_public_char where kind='订单销售绩效计算方式'"; 
   ResultSet rs_hr2=hr_db.executeQuery(sql_hr2);
if(rs_hr2.next()){ 
	sale_bonus_type=rs_hr2.getString("type_name");
	bonus_cost_for_profit_type=rs_hr2.getString("bonus_cost_for_profit_type");
}
for(int i=1;i<=num;i++){
	String tem_product_name="product_name"+i;
	String tem_product_ID="product_ID"+i;
	String tem_product_describe="product_describe"+i;
	String tem_amount="amount"+i;
	String tem_off_discount="off_discount"+i;
	String tem_list_price="list_price"+i;
	String tem_cost_price="cost_price"+i;
	String tem_real_cost_price="real_cost_price"+i;
	String tem_amount_unit="amount_unit"+i ;
String product_name=request.getParameter(tem_product_name) ;
String product_ID=request.getParameter(tem_product_ID) ;
String product_describe=request.getParameter(tem_product_describe) ;
String amount1=request.getParameter(tem_amount) ;
String off_discount=request.getParameter(tem_off_discount) ;
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
String real_cost_price2=request.getParameter(tem_real_cost_price) ;
StringTokenizer tokenTO4 = new StringTokenizer(real_cost_price2,",");        
String real_cost_price="";
            while(tokenTO4.hasMoreTokens()) {
                String real_cost_price1 = tokenTO4.nextToken();
		real_cost_price +=real_cost_price1;
		}
String amount_unit=request.getParameter(tem_amount_unit) ;
double amount=0.0d;
	double subtotal=Double.parseDouble(list_price)*(1-Double.parseDouble(off_discount)/100)*Double.parseDouble(amount1);
	double cost_price_after_discount_sum=Double.parseDouble(cost_price)*Double.parseDouble(amount1);
	double real_cost_price_after_discount_sum=Double.parseDouble(real_cost_price)*Double.parseDouble(amount1);
	sale_price_sum+=subtotal;
	cost_price_sum+=cost_price_after_discount_sum;
	real_cost_price_sum+=real_cost_price_after_discount_sum;
	pay_amount_sum+=Double.parseDouble(amount1);
		
double order_sale_bonus_subtotal=getRateFromID.getRateFromID((String)dbSession.getAttribute("unit_db_name"),"design_file","product_ID",product_ID,"order_sale_bonus_rate")*subtotal/100;
double order_profit_bonus_subtotal=0.0d;
if(bonus_cost_for_profit_type.equals("按计划成本单价")){
order_profit_bonus_subtotal=getRateFromID.getRateFromID((String)dbSession.getAttribute("unit_db_name"),"design_file","product_ID",product_ID,"order_profit_bonus_rate")*(subtotal-cost_price_after_discount_sum)/100;
}else{
order_profit_bonus_subtotal=getRateFromID.getRateFromID((String)dbSession.getAttribute("unit_db_name"),"design_file","product_ID",product_ID,"order_profit_bonus_rate")*(subtotal-real_cost_price_after_discount_sum)/100;
}
order_sale_bonus_sum+=order_sale_bonus_subtotal;
order_profit_bonus_sum+=order_profit_bonus_subtotal;

	String sql1 = "update crm_order_details set product_ID='"+product_ID+"',product_name='"+product_name+"',product_describe='"+product_describe+"',list_price='"+list_price+"',amount='"+amount1+"',cost_price='"+cost_price+"',off_discount='"+off_discount+"',subtotal='"+subtotal+"',order_sale_bonus_subtotal='"+order_sale_bonus_subtotal+"' ,order_profit_bonus_subtotal='"+order_profit_bonus_subtotal+"' where order_ID='"+order_ID+"' and details_number='"+i+"'" ;
	crm_db.executeUpdate(sql1) ;
if(flag){
String product_type="";
String sql16="select * from design_file where product_ID='"+product_ID+"'";
ResultSet rs16=design_db.executeQuery(sql16);
if(rs16.next()){
	product_type=rs16.getString("type");
}
if(product_type.equals("物料")||product_type.equals("外购商品")){
	stock_product_number+=Double.parseDouble(amount1);
	stock_price+=cost_price_after_discount_sum;
	sql6="insert into stock_pay_details(pay_ID,details_number,product_ID,product_name,product_describe,type,cost_price,subtotal,amount,unpay_amount,apply_manufacture_amount,apply_purchase_amount) values('"+pay_ID+"','"+stock_number+"','"+product_ID+"','"+product_name+"','"+product_describe+"','"+product_type+"','"+cost_price+"','"+cost_price_after_discount_sum+"','"+amount1+"','"+amount1+"','0','"+amount1+"')";
	stock_db.executeUpdate(sql6);
	stock_number+=1;
}else if(product_type.equals("商品")||product_type.equals("部件")||product_type.equals("委外部件")){
	stock_product_number+=Double.parseDouble(amount1);
	stock_price+=cost_price_after_discount_sum;
	sql6="insert into stock_pay_details(pay_ID,details_number,product_ID,product_name,product_describe,type,cost_price,subtotal,amount,unpay_amount,apply_manufacture_amount,apply_purchase_amount) values('"+pay_ID+"','"+stock_number+"','"+product_ID+"','"+product_name+"','"+product_describe+"','"+product_type+"','"+cost_price+"','"+cost_price_after_discount_sum+"','"+amount1+"','"+amount1+"','"+amount1+"','0')";
	stock_db.executeUpdate(sql6);
	stock_number+=1;
}else if(product_type.equals("服务型产品")){
service_count++;
}
	}
}
design_db.close();

if(flag){
String sql2="";
if(service_count==num){
sql2="update crm_order set sale_price_sum='"+sale_price_sum+"',uninvoice_sum='"+sale_price_sum+"',ungather_sum='"+sale_price_sum+"',cost_price_sum='"+cost_price_sum+"',pay_amount_sum='"+pay_amount_sum+"',unpay_amount_sum='"+pay_amount_sum+"',check_tag='1',modify_tag='0',manufacture_tag='1',pay_tag='3',logistics_tag='3',receive_tag='3',gather_tag='1',invoice_tag='1',order_tag='1',order_status='执行',order_sale_bonus_sum='"+order_sale_bonus_sum+"' ,order_profit_bonus_sum='"+order_profit_bonus_sum+"',bonus_calculate_type='"+sale_bonus_type+"' where order_ID='"+order_ID+"'";
}else{
sql2="update crm_order set sale_price_sum='"+sale_price_sum+"',uninvoice_sum='"+sale_price_sum+"',ungather_sum='"+sale_price_sum+"',cost_price_sum='"+cost_price_sum+"',pay_amount_sum='"+pay_amount_sum+"',unpay_amount_sum='"+pay_amount_sum+"',check_tag='1',modify_tag='0',manufacture_tag='1',pay_tag='1',gather_tag='1',invoice_tag='1',order_tag='1',logistics_tag='1',receive_tag='1',order_status='执行',order_sale_bonus_sum='"+order_sale_bonus_sum+"' ,order_profit_bonus_sum='"+order_profit_bonus_sum+"',bonus_calculate_type='"+sale_bonus_type+"' where order_ID='"+order_ID+"'";
}
crm_db.executeUpdate(sql2) ;
int trade_amount=0;
double achievement_sum=0.0d;
int return_amount=0;
double return_sum=0.0d;
String sql3="select * from crm_file where customer_ID='"+customer_ID+"'";
ResultSet rs3=crm_db.executeQuery(sql3);
if(rs3.next()){
	trade_amount=rs3.getInt("trade_amount");
	achievement_sum=rs3.getDouble("achievement_sum");
	return_amount=rs3.getInt("return_amount");
	return_sum=rs3.getDouble("return_sum");
}
if(sale_price_sum>0){
	trade_amount+=1;
	achievement_sum+=sale_price_sum;
}else{
	trade_amount+=1;
	return_amount+=1;
	achievement_sum+=sale_price_sum;
	return_sum+=sale_price_sum;
}
String sql4="update crm_file set trade_amount='"+trade_amount+"',return_amount='"+return_amount+"',achievement_sum='"+achievement_sum+"',return_sum='"+return_sum+"',lately_trade_time='"+check_time+"' where customer_ID='"+customer_ID+"'";
crm_db.executeUpdate(sql4);

	double cost_price1=stock_price/stock_product_number;
if(service_count!=num){
	if(!vr.validata((String)dbSession.getAttribute("unit_db_name"),"stock_pay","reasonexact",order_ID)){
String sql5="insert into stock_pay(pay_ID,reason,reasonexact,demand_amount,cost_price,cost_price_sum,register,register_ID,register_time) values('"+pay_ID+"','销售出库','"+order_ID+"','"+stock_product_number+"','"+cost_price1+"','"+stock_price+"','"+checker+"','"+checker_ID+"','"+check_time+"')";
stock_db.executeUpdate(sql5);
	}
}
if(!vr.validata((String)dbSession.getAttribute("unit_db_name"),"fund_fund","reasonexact",order_ID)){
	String fund_ID=NseerId.getId("fund/gather",(String)dbSession.getAttribute("unit_db_name"));
String[] kind_chain=FileKind.getKind((String)dbSession.getAttribute("unit_db_name"),"crm_file","customer_ID",customer_ID);
	String sql14="insert into fund_fund(fund_ID,reason,reasonexact,chain_ID,chain_name,funder,funder_ID,file_chain_ID,file_chain_name,demand_cost_price_sum,currency_name,personal_unit,register,register_time,sales_purchaser_ID,sales_purchaser_name) values('"+fund_ID+"','收款','"+order_ID+"','"+kind_chain[0]+"','"+kind_chain[1]+"','"+customer_name+"','"+customer_ID+"','1131','应收账款','"+sale_price_sum+"','人民币','元','"+checker+"','"+check_time+"','"+sales_ID+"','"+sales_name+"')";
	fund_db.executeUpdate(sql14) ;
}
	}else{
String sql2="update crm_order set sale_price_sum='"+sale_price_sum+"',uninvoice_sum='"+sale_price_sum+"',ungather_sum='"+sale_price_sum+"',cost_price_sum='"+cost_price_sum+"',pay_amount_sum='"+pay_amount_sum+"',unpay_amount_sum='"+pay_amount_sum+"',order_sale_bonus_sum='"+order_sale_bonus_sum+"' ,order_profit_bonus_sum='"+order_profit_bonus_sum+"',bonus_calculate_type='"+sale_bonus_type+"' where order_ID='"+order_ID+"'";
crm_db.executeUpdate(sql2) ;
	}
}
catch (Exception ex){
ex.printStackTrace();
}
response.sendRedirect("crm/order/check_choose_attachment.jsp?order_ID="+order_ID+"");
	}else{
    response.sendRedirect("crm/order/check_ok.jsp?finished_tag=0");
	}
}else{
	response.sendRedirect("crm/order/check_ok.jsp?finished_tag=1");
}
}else{
response.sendRedirect("crm/order/check_ok.jsp?finished_tag=2");
}
design_db.close();
fund_db.close();
crm_db.close();
stock_db.close();
hr_db.close();
finance_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}

