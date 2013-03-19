/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package crm.retail;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.* ;
import java.util.* ;
import java.io.*;
import include.nseer_db.*;
import java.text.*;
import include.nseer_cookie.*;
import include.get_rate_from_ID.getRateFromID;
import include.get_name_from_ID.getNameFromID;
import validata.ValidataNumber;
import stock.getLength;

public class register_ok extends HttpServlet{
ServletContext application;
HttpSession session;
nseer_db_backup1 erp_db = null;

public synchronized void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{
HttpSession session=request.getSession();
nseer_db_backup1 crm_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 crm_db1 = new nseer_db_backup1(dbApplication);
counter count= new  counter(dbApplication);
getRateFromID   getRateFromID= new getRateFromID();
getNameFromID  getNameFromID= new  getNameFromID();
ValidataNumber  validata= new  ValidataNumber();
getLength  length= new getLength();

if(crm_db.conn((String)dbSession.getAttribute("unit_db_name"))&&stock_db.conn((String)dbSession.getAttribute("unit_db_name"))&&crm_db1.conn((String)dbSession.getAttribute("unit_db_name"))){

String funder=(String)session.getAttribute("realeditorc");
String funder_ID=(String)session.getAttribute("human_IDD");
String order_ID=request.getParameter("order_ID") ;

java.util.Date  now  =  new  java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String[] serial_number=request.getParameterValues("serial_number") ;
String[] amount_number=request.getParameterValues("amount_number") ;
String sql1a="select * from crm_order_retail_temp where order_ID='"+order_ID+"'";//在临时表读记录
ResultSet rs1a=crm_db.executeQuery(sql1a);
String stock_ID="";
if(rs1a.next()){
stock_ID=rs1a.getString("stock_ID");
}
int p=0;
int j=1;
String sql2a="select * from crm_order_retail_details_temp where order_ID='"+order_ID+"'";//在临时表读记录
ResultSet rs2a=crm_db.executeQuery(sql2a);
while(rs2a.next()){
double serial_number_tag1=getRateFromID.getRateFromID((String)dbSession.getAttribute("unit_db_name"),"design_file","product_ID",rs2a.getString("product_ID"),"serial_number_tag");
String calculate_bonus_sn_tag=getNameFromID.getNameFromID((String)dbSession.getAttribute("unit_db_name"),"design_file","product_ID",rs2a.getString("product_ID"),"calculate_bonus_sn_tag");
	if(serial_number_tag1==1||serial_number_tag1==2){

StringTokenizer tokenTO1 = new StringTokenizer(serial_number[j-1],", ");   
	double cost_price_sum66=0.0d;
	while(tokenTO1.hasMoreTokens()) {
		String sql66="select * from  stock_balance_details_details where serial_number='"+tokenTO1.nextToken()+"' and stock_ID='"+stock_ID+"' and product_ID='"+rs2a.getString("product_ID")+"'";
		ResultSet rs66=stock_db.executeQuery(sql66);
		if(!rs66.next()){
			p++;
			}
		
		}
	}
j++;
}
if(p==0){
String time1="";
java.util.Date now1 = new java.util.Date();
SimpleDateFormat formatter1 = new SimpleDateFormat("yyyyMMdd");
time1=formatter1.format(now1);
String order_ID1=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));
String sql1="select * from crm_order_retail_temp where order_ID='"+order_ID+"'";//在临时表读记录
		String sale_bonus_type="";
		String bonus_cost_for_profit_type="";
String sql_hr2="select * from hr_config_public_char where kind='零售绩效计算方式'"; 
   ResultSet rs_hr2=crm_db.executeQuery(sql_hr2);
if(rs_hr2.next()){ 
	sale_bonus_type=rs_hr2.getString("type_name");
	bonus_cost_for_profit_type=rs_hr2.getString("bonus_cost_for_profit_type");
}
ResultSet rs1=crm_db.executeQuery(sql1);
String customer_ID="";
String sales_ID="";
String stock_name="";
if(rs1.next()){
customer_ID=rs1.getString("customer_ID");
sales_ID=rs1.getString("sales_ID");
stock_name=rs1.getString("stock_name");
String type="零售非会员";
	if(!customer_ID.equals("01050000000000000000")){
		type="零售会员";
	}
	String sql3 = "insert into crm_order(order_ID,chain_ID,chain_name,hr_chain_ID,hr_chain_name,customer_ID,customer_name,register_time,accomplish_time,sales_name,sales_ID,register,type,remark,check_tag,excel_tag,order_type,bonus_calculate_type) values ('"+order_ID1+"','"+rs1.getString("chain_ID")+"','"+rs1.getString("chain_name")+"','"+rs1.getString("hr_chain_ID")+"','"+rs1.getString("hr_chain_name")+"','"+rs1.getString("customer_ID")+"','"+rs1.getString("customer_name")+"','"+rs1.getString("register_time")+"','"+rs1.getString("register_time")+"','"+rs1.getString("sales_name")+"','"+rs1.getString("sales_ID")+"','"+rs1.getString("register")+"','"+type+"','"+rs1.getString("remark")+"','0','2','零售','"+sale_bonus_type+"')" ;
	crm_db.executeUpdate(sql3) ;

}
String id="";
String sqlb="select id from crm_order where order_ID='"+order_ID1+"'";
rs1=crm_db.executeQuery(sqlb);
	if(rs1.next()){
		id=rs1.getString("id");
	}
String sql2="select * from crm_order_retail_details_temp where order_ID='"+order_ID+"'";//在临时表读记录
ResultSet rs2=crm_db.executeQuery(sql2);
int i=1;
double sale_price_sum=0.0d;
double cost_price_sum=0.0d;
double real_cost_price_sum=0.0d;
int pay_amount_sum=0;
double retail_sale_bonus_sum=0.00d;
double retail_profit_bonus_sum=0.00d;
while(rs2.next()){
	
	double subtotal=rs2.getDouble("list_price")*(1-rs2.getDouble("off_discount")/100)*rs2.getDouble("amount");
	double cost_price_after_discount_sum=rs2.getDouble("cost_price")*rs2.getDouble("amount");
	double real_cost_price_after_discount_sum=rs2.getDouble("real_cost_price")*rs2.getDouble("amount");
	sale_price_sum+=subtotal;
	cost_price_sum+=cost_price_after_discount_sum;
	real_cost_price_sum+=real_cost_price_after_discount_sum;
	pay_amount_sum+=rs2.getDouble("amount");
	double retail_sale_bonus_subtotal=getRateFromID.getRateFromID((String)dbSession.getAttribute("unit_db_name"),"design_file","product_ID",rs2.getString("product_ID"),"retail_sale_bonus_rate")*subtotal/100;
double retail_profit_bonus_subtotal=0.0d;
double serial_number_tag1=getRateFromID.getRateFromID((String)dbSession.getAttribute("unit_db_name"),"design_file","product_ID",rs2.getString("product_ID"),"serial_number_tag");

String calculate_bonus_sn_tag=getNameFromID.getNameFromID((String)dbSession.getAttribute("unit_db_name"),"design_file","product_ID",rs2.getString("product_ID"),"calculate_bonus_sn_tag");
	if(serial_number_tag1==1&&calculate_bonus_sn_tag.equals("是")){

StringTokenizer tokenTO1 = new StringTokenizer(serial_number[i-1],", ");   
	double cost_price_sum66=0.0d;
	while(tokenTO1.hasMoreTokens()) {
		String sql66="select * from  stock_balance_details_details where serial_number='"+tokenTO1.nextToken()+"' and stock_ID='"+stock_ID+"' and product_ID='"+rs2.getString("product_ID")+"'";
		ResultSet rs66=stock_db.executeQuery(sql66);
		if(rs66.next()){
			cost_price_sum66+=rs66.getDouble("cost_price");
			}
		
		}
retail_profit_bonus_subtotal=getRateFromID.getRateFromID((String)dbSession.getAttribute("unit_db_name"),"design_file","product_ID",rs2.getString("product_ID"),"retail_profit_bonus_rate")*(subtotal-cost_price_sum66)/100;

}else{
	if(bonus_cost_for_profit_type.equals("按计划成本单价")){
retail_profit_bonus_subtotal=getRateFromID.getRateFromID((String)dbSession.getAttribute("unit_db_name"),"design_file","product_ID",rs2.getString("product_ID"),"retail_profit_bonus_rate")*(subtotal-cost_price_after_discount_sum)/100;
}else{
retail_profit_bonus_subtotal=getRateFromID.getRateFromID((String)dbSession.getAttribute("unit_db_name"),"design_file","product_ID",rs2.getString("product_ID"),"retail_profit_bonus_rate")*(subtotal-real_cost_price_after_discount_sum)/100;
}

	
	
	}
retail_sale_bonus_sum+=retail_sale_bonus_subtotal;
retail_profit_bonus_sum+=retail_profit_bonus_subtotal;

	String sql4 = "insert into crm_order_details(order_ID,details_number,product_ID,product_name,product_describe,list_price,amount,cost_price,real_cost_price,off_discount,subtotal,amount_unit,serial_number,amount_number,retail_sale_bonus_subtotal,retail_profit_bonus_subtotal) values ('"+order_ID1+"','"+i+"','"+rs2.getString("product_ID")+"','"+rs2.getString("product_name")+"','"+rs2.getString("product_describe")+"','"+rs2.getString("list_price")+"','"+rs2.getString("amount")+"','"+rs2.getString("cost_price")+"','"+rs2.getString("real_cost_price")+"','"+rs2.getString("off_discount")+"','"+rs2.getString("subtotal")+"','"+rs2.getString("amount_unit")+"','"+serial_number[i-1]+"','"+amount_number[i-1]+"','"+retail_sale_bonus_subtotal+"','"+retail_profit_bonus_subtotal+"')" ;
	i++;
		
	stock_db.executeUpdate(sql4) ;
}
String sql5="update crm_order set check_tag='1',gather_tag='3',invoice_tag='3',pay_tag='3',order_tag='2',order_status='完成',sale_price_sum='"+sale_price_sum+"',cost_price_sum='"+cost_price_sum+"',pay_amount_sum='"+pay_amount_sum+"',retail_sale_bonus_sum='"+retail_sale_bonus_sum+"' ,retail_profit_bonus_sum='"+retail_profit_bonus_sum+"',gathered_sum='"+sale_price_sum+"',invoiced_sum='"+sale_price_sum+"' where order_ID='"+order_ID1+"'";

crm_db.executeUpdate(sql5) ;


double sale_bonus_sum=0.0d;
String sql_hr1="select * from hr_file where human_ID='"+sales_ID+"'"; 
ResultSet rs_hr1=crm_db.executeQuery(sql_hr1);
if(rs_hr1.next()){
	if(sale_bonus_type.equals("按毛利润计算")){
		sale_bonus_sum=rs_hr1.getDouble("sale_bonus_sum")+retail_profit_bonus_sum;
	}else{	
		sale_bonus_sum=rs_hr1.getDouble("sale_bonus_sum")+retail_sale_bonus_sum;
	}
String sql_hr="update hr_file set sale_bonus_sum='"+sale_bonus_sum+"' where human_ID='"+sales_ID+"'";
crm_db.executeUpdate(sql_hr);
}

int trade_amount=0;
double achievement_sum=0.0d;
int return_amount=0;
double return_sum=0.0d;
String sql6="select * from crm_file where customer_ID='"+customer_ID+"'";
ResultSet rs6=crm_db.executeQuery(sql6);
if(rs6.next()){
	trade_amount=rs6.getInt("trade_amount");
	achievement_sum=rs6.getDouble("achievement_sum");
	return_amount=rs6.getInt("return_amount");
	return_sum=rs6.getDouble("return_sum");
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
String sql7="update crm_file set trade_amount='"+trade_amount+"',return_amount='"+return_amount+"',achievement_sum='"+achievement_sum+"',return_sum='"+return_sum+"',lately_trade_time='"+time+"' where customer_ID='"+customer_ID+"'";
crm_db.executeUpdate(sql7);
String fund_ID=NseerId.getId("fund/gather",(String)dbSession.getAttribute("unit_db_name"));
String sql8="insert into fund_fund(fund_ID,funder,funder_ID,reason,demand_cost_price_sum,executed_cost_price_sum,apply_ID_group,currency_name,personal_unit,register_time,check_time,finish_time,file_chain_ID,file_chain_name,register,checker,check_tag,excel_tag,execute_tag,fund_tag,fund_execute_tag,remark) values('"+fund_ID+"','"+funder+"','"+funder_ID+"','收款','"+sale_price_sum+"','"+sale_price_sum+"','"+order_ID1+"','人民币','元','"+time+"','"+time+"','"+time+"','1131','应收账款','"+funder+"','"+funder+"','1','2','2','1','1','')";
crm_db.executeUpdate(sql8);
String sql9="insert into fund_details(fund_ID,details_number,fund_chain_ID,fund_chain_name,currency_name,personal_unit,cost_price_subtotal,executed_cost_price_subtotal) values('"+fund_ID+"','1','1001','现金','人民币','元','"+sale_price_sum+"','"+sale_price_sum+"')";
crm_db.executeUpdate(sql9);
String pay_ID=NseerId.getId("stock/pay",(String)dbSession.getAttribute("unit_db_name"));
String sql10="insert into stock_pay(pay_ID,reason,reasonexact,demand_amount,paid_amount,cost_price_sum,paid_cost_price_sum,register,checker,check_time,register_ID,register_time,finish_time,pay_tag,pay_pre_tag) values('"+pay_ID+"','销售出库','"+order_ID1+"','"+pay_amount_sum+"','"+pay_amount_sum+"','"+cost_price_sum+"','"+cost_price_sum+"','"+funder+"','"+funder+"','"+time+"','"+funder_ID+"','"+time+"','"+time+"','2','1')";
stock_db.executeUpdate(sql10);
	String sql11="select * from crm_order_details where order_ID='"+order_ID1+"'";
	ResultSet rs11=stock_db.executeQuery(sql11);
	while(rs11.next()){
		int serial_number_tag=0;
	String sqla6="select * from stock_cell where product_ID='"+rs11.getString("product_ID")+"' and check_tag='1'";
	ResultSet rsa6=crm_db.executeQuery(sqla6);
	if(rsa6.next()){
		serial_number_tag=rsa6.getInt("serial_number_tag");
	}
	double subtotal=rs11.getDouble("cost_price")*rs11.getDouble("amount");
	cost_price_sum+=subtotal;
	double balance_amount11=getRateFromID.getRateFromID((String)dbSession.getAttribute("unit_db_name"),"stock_balance","product_ID",rs11.getString("product_ID"),"amount")-rs11.getDouble("amount");
		String sql12="insert into stock_paying_gathering(pay_ID,product_ID,details_number,product_name,amount,demand_amount,paid_amount,cost_price,subtotal,paid_subtotal,register,register_time,stock_ID,stock_name,serial_number,amount_number,paying_or_gathering,balance_amount) values('"+pay_ID+"','"+rs11.getString("product_ID")+"','"+rs11.getString("details_number")+"','"+rs11.getString("product_name")+"','"+rs11.getString("amount")+"','"+rs11.getString("amount")+"','"+rs11.getString("amount")+"','"+rs11.getString("cost_price")+"','"+subtotal+"','"+subtotal+"','"+funder+"','"+time+"','"+stock_ID+"','"+stock_name+"','"+rs11.getString("serial_number")+"','"+rs11.getString("amount_number")+"','出库','"+balance_amount11+"')";
		crm_db.executeUpdate(sql12);
		String sql13="insert into stock_pre_paying(pay_ID,product_ID,details_number,product_name,amount,unpay_amount,paid_amount,cost_price,subtotal,paid_subtotal,register,register_time,stock_ID,stock_name) values('"+pay_ID+"','"+rs11.getString("product_ID")+"','"+rs11.getString("details_number")+"','"+rs11.getString("product_name")+"','"+rs11.getString("amount")+"','0','"+rs11.getString("amount")+"','"+rs11.getString("cost_price")+"','"+subtotal+"','"+subtotal+"','"+funder+"','"+time+"','"+stock_ID+"','"+stock_name+"')";
		crm_db.executeUpdate(sql13);
		if(serial_number_tag==1){
	if(!rs11.getString("serial_number").equals("")){
	StringTokenizer tokenTO1 = new StringTokenizer(rs11.getString("serial_number"),", ");        
	while(tokenTO1.hasMoreTokens()) {
		String sql14="delete from  stock_balance_details_details where serial_number='"+tokenTO1.nextToken()+"' and stock_ID='"+stock_ID+"' and product_ID='"+rs11.getString("product_ID")+"'";
		crm_db.executeUpdate(sql14);
		}
	}
		}else{
			if(!rs11.getString("serial_number").equals("")){
			StringTokenizer tokenTO2 = new StringTokenizer(rs11.getString("serial_number"),", ");
			StringTokenizer tokenTO3 = new StringTokenizer(rs11.getString("amount_number"),", ");
			while(tokenTO2.hasMoreTokens()&&tokenTO3.hasMoreTokens()) {
				String serial_number1=tokenTO2.nextToken();
				String amount_number1=tokenTO3.nextToken();
				String sqla10="select * from stock_balance_details_details where serial_number='"+serial_number1+"' and stock_ID='"+stock_ID+"' and product_ID='"+rs11.getString("product_ID")+"'";
				ResultSet rsa10=crm_db.executeQuery(sqla10);
				double cost_price_details=0.0d;
				double subtotal_details=0.0d;
				if(rsa10.next()){
					cost_price_details=rsa10.getDouble("cost_price");
					subtotal_details=rsa10.getDouble("cost_price")*Double.parseDouble(amount_number1);
					double balance_amount=rsa10.getDouble("amount")-Double.parseDouble(amount_number1);
				String sqlb10="update stock_balance_details_details set amount='"+balance_amount+"' where serial_number='"+serial_number1+"' and stock_ID='"+stock_ID+"' and product_ID='"+rs11.getString("product_ID")+"'";
				crm_db.executeUpdate(sqlb10);
				}
			}
			}
		}
	String sql15="select * from stock_balance_details where product_ID='"+rs11.getString("product_ID")+"' and stock_ID='"+stock_ID+"'" ; 
	ResultSet rs15=crm_db.executeQuery(sql15);
	if(rs15.next()){
		double cost_price15=rs15.getDouble("cost_price");
		double amount15=rs15.getDouble("amount")-rs11.getDouble("amount");
		double subtotal15=rs15.getDouble("subtotal")-rs11.getDouble("real_cost_price")*rs11.getDouble("amount");
		if(amount15!=0){
		cost_price15=subtotal15/amount15;
		}
		String sql16="update stock_balance_details set amount='"+amount15+"',subtotal='"+subtotal15+"',cost_price='"+cost_price15+"' where id='"+rs15.getString("id")+"'";
			crm_db.executeUpdate(sql16);
	}
String sql17="select * from stock_balance where product_ID='"+rs11.getString("product_ID")+"'"; 
	ResultSet rs17=crm_db.executeQuery(sql17);
	if(rs17.next()){
		double cost_price3=rs17.getDouble("cost_price");
		double amount3=rs17.getDouble("amount")-rs11.getDouble("amount");
		double subtotal3=rs17.getDouble("cost_price_sum")-rs11.getDouble("real_cost_price")*rs11.getDouble("amount");
		if(amount3!=0){
		cost_price3=subtotal3/amount3;
		}
		String sql18="update stock_balance set amount='"+amount3+"',cost_price_sum='"+subtotal3+"',cost_price='"+cost_price3+"' where id='"+rs17.getString("id")+"'";
		crm_db.executeUpdate(sql18);
	}}
	String sql19="delete from crm_order_retail_temp where order_ID='"+order_ID+"'";
	crm_db.executeUpdate(sql19);
	String sql20="delete from crm_order_retail_details_temp where order_ID='"+order_ID+"'";
	crm_db.executeUpdate(sql20);

response.sendRedirect("crm/retail/register_ok_a.jsp?order_ID1="+order_ID1+"");

}else{

response.sendRedirect("crm/retail/register_ok_b.jsp");
}

stock_db.commit();
crm_db.commit();

stock_db.close();
crm_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){ex.printStackTrace();}
}
}