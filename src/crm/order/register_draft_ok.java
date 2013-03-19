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

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import java.util.* ;
import java.io.* ;
import include.nseer_cookie.* ;
import include.nseer_db.*;
import java.text.*;
import validata.ValidataNumber;
import include.get_rate_from_ID.getRateFromID;
import validata.ValidataRecord;

public class register_draft_ok extends HttpServlet{
ServletContext application;
HttpSession session;
nseer_db_backup1 erp_db = null;

public synchronized void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
ValidataRecord vr = new ValidataRecord();
 
try{
PrintWriter out=response.getWriter();
session=request.getSession();
nseer_db_backup crm_db = new nseer_db_backup(dbApplication);
nseer_db_backup stock_db = new nseer_db_backup(dbApplication);
nseer_db_backup fund_db = new nseer_db_backup(dbApplication);
nseer_db_backup design_db = new nseer_db_backup(dbApplication);
nseer_db_backup hr_db = new nseer_db_backup(dbApplication);
nseer_db_backup finance_db = new nseer_db_backup(dbApplication);
if(crm_db.conn((String)dbSession.getAttribute("unit_db_name"))&&stock_db.conn((String)dbSession.getAttribute("unit_db_name"))&&design_db.conn((String)dbSession.getAttribute("unit_db_name"))&&fund_db.conn((String)dbSession.getAttribute("unit_db_name"))&&hr_db.conn((String)dbSession.getAttribute("unit_db_name"))&&finance_db.conn((String)dbSession.getAttribute("unit_db_name"))){
counter count= new counter(dbApplication);
ValidataNumber validata= new ValidataNumber();
getRateFromID getRateFromID= new getRateFromID();

String register_ID=(String)session.getAttribute("human_IDD");
String product_amount=request.getParameter("product_amount") ;
int num=Integer.parseInt(product_amount);
String demand_pay_fee_sum2=request.getParameter("demand_pay_fee_sum") ;
String sales_name=request.getParameter("sales_name") ;
String sales_ID=request.getParameter("sales_ID") ;
StringTokenizer tokenTO1 = new StringTokenizer(demand_pay_fee_sum2,",");        
String demand_pay_fee_sum="";
            while(tokenTO1.hasMoreTokens()) {
                String demand_pay_fee_sum1 = tokenTO1.nextToken();
		demand_pay_fee_sum +=demand_pay_fee_sum1;
		}
double order_discount=getRateFromID.getRateFromID((String)dbSession.getAttribute("unit_db_name"),"security_users","human_ID",sales_ID,"order_discount");
double order_discount1=getRateFromID.getRateFromID((String)dbSession.getAttribute("unit_db_name"),"security_users","human_ID",register_ID,"order_discount");
int n=0;
for(int i=1;i<num;i++){
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
if(n==0){

String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
time=formatter.format(now);
String customer_ID=request.getParameter("customer_ID") ;
String order_ID=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));
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
String register_time=request.getParameter("register_time") ;
String register=request.getParameter("register") ;
String type=request.getParameter("type") ;
String bodyc = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyc);
String chain_id="";
String chain_name="";
try{
	String sql3="select * from crm_file where customer_ID='"+customer_ID+"'";
	ResultSet rs=crm_db.executeQuery(sql3);
	if(rs.next()){
		chain_id=rs.getString("chain_ID");
		chain_name=rs.getString("chain_name");
	String sql = "insert into crm_order(order_ID,chain_ID,chain_name,customer_ID,customer_name,demand_customer_address,demand_customer_mailing_address,demand_contact_person,demand_contact_person_tel,demand_contact_person_fax,demand_pay_time,demand_pay_type,demand_pay_fee_type,demand_gather_type,demand_gather_method,demand_invoice_type,register_time,sales_name,sales_ID,register,type,remark,check_tag,excel_tag) values ('"+order_ID+"','"+rs.getString("chain_ID")+"','"+rs.getString("chain_name")+"','"+customer_ID+"','"+customer_name+"','"+demand_customer_address+"','"+demand_customer_mailing_address+"','"+demand_contact_person+"','"+demand_contact_person_tel+"','"+demand_contact_person_fax+"','"+demand_pay_time+"','"+demand_pay_type+"','"+demand_pay_fee_type+"','"+demand_gather_type+"','"+demand_gather_method+"','"+demand_invoice_type+"','"+register_time+"','"+sales_name+"','"+sales_ID+"','"+register+"','"+type+"','"+remark+"','5','2')" ;
	crm_db.executeUpdate(sql) ;
	}
String id="";
String sqlb="select id from crm_order where order_ID='"+order_ID+"'";
rs=crm_db.executeQuery(sqlb);
	if(rs.next()){
		id=rs.getString("id");
	}
String pay_ID=NseerId.getId("stock/pay",(String)dbSession.getAttribute("unit_db_name"));
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
for(int i=1;i<num;i++){
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
String amount=request.getParameter(tem_amount) ;
String amount_unit=request.getParameter(tem_amount_unit) ;
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
	double subtotal=Double.parseDouble(list_price)*(1-Double.parseDouble(off_discount)/100)*Double.parseDouble(amount);
	double cost_price_after_discount_sum=Double.parseDouble(cost_price)*Double.parseDouble(amount);
	double real_cost_price_after_discount_sum=Double.parseDouble(real_cost_price)*Double.parseDouble(amount);
	sale_price_sum+=subtotal;
	cost_price_sum+=cost_price_after_discount_sum;
	real_cost_price_sum+=real_cost_price_after_discount_sum;
	pay_amount_sum+=Double.parseDouble(amount);
		
double order_sale_bonus_subtotal=getRateFromID.getRateFromID((String)dbSession.getAttribute("unit_db_name"),"design_file","product_ID",product_ID,"order_sale_bonus_rate")*subtotal/100;
double order_profit_bonus_subtotal=0.0d;
if(bonus_cost_for_profit_type.equals("按计划成本单价")){
order_profit_bonus_subtotal=getRateFromID.getRateFromID((String)dbSession.getAttribute("unit_db_name"),"design_file","product_ID",product_ID,"order_profit_bonus_rate")*(subtotal-cost_price_after_discount_sum)/100;
}else{
order_profit_bonus_subtotal=getRateFromID.getRateFromID((String)dbSession.getAttribute("unit_db_name"),"design_file","product_ID",product_ID,"order_profit_bonus_rate")*(subtotal-real_cost_price_after_discount_sum)/100;
}
order_sale_bonus_sum+=order_sale_bonus_subtotal;
order_profit_bonus_sum+=order_profit_bonus_subtotal;
	String sql1 = "insert into crm_order_details(order_ID,details_number,product_ID,product_name,product_describe,list_price,amount,cost_price,real_cost_price,off_discount,subtotal,amount_unit) values ('"+order_ID+"','"+i+"','"+product_ID+"','"+product_name+"','"+product_describe+"','"+list_price+"','"+amount+"','"+cost_price+"','"+real_cost_price+"','"+off_discount+"','"+subtotal+"','"+amount_unit+"')" ;
	crm_db.executeUpdate(sql1) ;
//**************************

}

		String sql="update crm_order set sale_price_sum='"+sale_price_sum+"',uninvoice_sum='"+sale_price_sum+"',ungather_sum='"+sale_price_sum+"',cost_price_sum='"+cost_price_sum+"',real_cost_price_sum='"+real_cost_price_sum+"',pay_amount_sum='"+pay_amount_sum+"',unpay_amount_sum='"+pay_amount_sum+"' where order_ID='"+order_ID+"'";
		crm_db.executeUpdate(sql) ;

response.sendRedirect("crm/order/register_choose_attachment.jsp?order_ID="+order_ID+"");
	
}
catch (Exception ex){
out.println("error"+ex);
}
}else{
	response.sendRedirect("crm/order/register_draft_ok.jsp?finished_tag=0");
	}
	fund_db.close();
	crm_db.close();
	stock_db.close();
		hr_db.close();
	design_db.close();
		finance_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}