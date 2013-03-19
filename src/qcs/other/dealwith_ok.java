/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package qcs.other;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.text.SimpleDateFormat;

import include.get_rate_from_ID.getRateFromID;
import include.nseer_db.*;
import include.nseer_cookie.*;
import java.io.*;
import java.util.*;
import validata.ValidataRecord;
import com.jspsmart.upload.*;


import include.nseer_cookie.counter;

public class dealwith_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
ValidataRecord vr = new ValidataRecord();
getRateFromID getRateFromID= new getRateFromID();

try{
//实例化

HttpSession session=request.getSession();
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
counter count=new counter(dbApplication);
nseer_db_backup crm_db = new nseer_db_backup(dbApplication);
nseer_db_backup stock_db = new nseer_db_backup(dbApplication);
nseer_db_backup qcs_db = new nseer_db_backup(dbApplication);
java.util.Date now1 = new java.util.Date();
SimpleDateFormat formatter1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
String time=formatter1.format(now1);
String time1=formatter.format(now1);
if(qcs_db.conn((String)dbSession.getAttribute("unit_db_name"))&&crm_db.conn((String)dbSession.getAttribute("unit_db_name"))&&stock_db.conn((String)dbSession.getAttribute("unit_db_name"))){
try{
String qcs_id = request.getParameter("qcs_id");
String product_id = request.getParameter("product_id");
String product_name = request.getParameter("product_name");
String dealwith_type = request.getParameter("dealwith_type");
String provider = request.getParameter("provider");
String dealwith_tag = request.getParameter("dealwith_tag");
String amount = request.getParameter("qcs_amount");
int num=1;
String sqlq="update qcs_other set dealwith_tag='"+dealwith_tag+"' where qcs_id='"+qcs_id+"'";
qcs_db.executeUpdate(sqlq);
if(provider!=null&&!provider.equals("")){
String provider_id =Divide.getId(provider);
String provider_name =Divide.getName(provider);

if(dealwith_type.split("/")[0].equals("01")){
	String sql="select * from purchase_file where provider_id='"+provider_id+"'";
	ResultSet rs=qcs_db.executeQuery(sql);
	if(rs.next()){
		String chain_id=rs.getString("chain_id");
		String chain_name=rs.getString("chain_name");
		String provider_class=rs.getString("provider_class");
		String provider_tel1=rs.getString("provider_tel1");
		String provider_web=rs.getString("provider_web");
		String type=rs.getString("type");
		String contact_person1=rs.getString("contact_person1");
		sql="select product_providers_recommend_id from purchase_product_providers_recommend where product_id='"+product_id+"' and (check_tag='1' or check_tag='0')";
		List rsList = GetWorkflow.getList(qcs_db, "purchase_config_workflow", "03");
		rs=qcs_db.executeQuery(sql);
		if(rs.next()){
			String product_providers_recommend_id=rs.getString("product_providers_recommend_id");
			sql="select id from purchase_product_providers_recommend_details where product_providers_recommend_id='"+product_providers_recommend_id+"' and provider_id='"+provider_id+"'";
			rs=qcs_db.executeQuery(sql);
			if(!rs.next()){
				sql="select details_number from purchase_product_providers_recommend_details where product_providers_recommend_id='"+product_providers_recommend_id+"' order by details_number desc";
				rs=qcs_db.executeQuery(sql);
				if(rs.next()){
					int details_number=rs.getInt("details_number")+1;
					sql = "insert into purchase_product_providers_recommend_details(product_providers_recommend_id,details_number,provider_id,provider_name,provider_class,provider_tel,provider_web,type,contact_person) values ('"+product_providers_recommend_id+"','"+details_number+"','"+provider_id+"','"+provider_name+"','"+provider_class+"','"+provider_tel1+"','"+provider_web+"','"+type+"','"+contact_person1+"')" ;
					qcs_db.executeUpdate(sql);			
				}
				sql="update purchase_product_providers_recommend set check_tag='0' where product_providers_recommend_id='"+product_providers_recommend_id+"'";
				qcs_db.executeUpdate(sql);				
				if(rsList.size()==0){
					sql="update purchase_product_providers_recommend set check_tag='1' where product_providers_recommend_ID='"+product_providers_recommend_id+"'";
					qcs_db.executeUpdate(sql);
				}else{
					sql="delete from purchase_workflow where object_ID='"+product_providers_recommend_id+"'";
					qcs_db.executeUpdate(sql) ;
					sql="update purchase_product_providers_recommend set check_tag='0' where product_providers_recommend_ID='"+product_providers_recommend_id+"'";
					qcs_db.executeUpdate(sql) ;
					Iterator ite=rsList.iterator();
					while(ite.hasNext()){
						String[] elem=(String[])ite.next();
						sql = "insert into purchase_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+product_providers_recommend_id+"','"+elem[1]+"','"+elem[2]+"')" ;
						qcs_db.executeUpdate(sql) ;
					}
				}
			}	
		}else{
			String product_providers_recommend_id=NseerId.getId("purchase/product_providers",(String)dbSession.getAttribute("unit_db_name"));
			String sqla="update design_file set recommend_provider_tag='1' where product_id='"+product_id+"'";
			qcs_db.executeUpdate(sqla);
			String sqlb = "insert into purchase_product_providers_recommend(product_providers_recommend_id,chain_id,chain_name,product_id,product_name,recommend_describe,register_time,recommender,register,check_tag,excel_tag) values ('"+product_providers_recommend_id+"','"+chain_id+"','"+chain_name+"','"+product_id+"','"+product_name+"','','"+time+"','','','0','2')" ;
			qcs_db.executeUpdate(sqlb) ;
			sqlb = "insert into purchase_product_providers_recommend_details(product_providers_recommend_id,details_number,provider_id,provider_name,provider_class,provider_tel,provider_web,type,contact_person) values ('"+product_providers_recommend_id+"','1','"+provider_id+"','"+provider_name+"','"+provider_class+"','"+provider_tel1+"','"+provider_web+"','"+type+"','"+contact_person1+"')" ;
			qcs_db.executeUpdate(sqlb);
			if(rsList.size()==0){
				sql="update purchase_product_providers_recommend set check_tag='1' where product_providers_recommend_ID='"+product_providers_recommend_id+"'";
				qcs_db.executeUpdate(sql) ;
			}else{
				Iterator ite=rsList.iterator();
				while(ite.hasNext()){
					String[] elem=(String[])ite.next();
					sql = "insert into purchase_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+product_providers_recommend_id+"','"+elem[1]+"','"+elem[2]+"')" ;
					qcs_db.executeUpdate(sql);
				}
			}
		}
	}
}else if(dealwith_type.split("/")[0].equals("02")){
String chain_id="";
String chain_name="";
String product_describe="";
	String customer_id =Divide.getId(provider);
	String customer_name =Divide.getName(provider);
	String order_id=NseerId.getId("crm/order",(String)dbSession.getAttribute("unit_db_name"));
	String sql3="select * from crm_file where customer_id='"+customer_id+"'";
	ResultSet rs=qcs_db.executeQuery(sql3);
	if(rs.next()){
		chain_id=rs.getString("chain_id");
		chain_name=rs.getString("chain_name");
	String sql = "insert into crm_order(order_id,chain_ID,chain_name,customer_id,customer_name,demand_contact_person_tel,demand_pay_time,register_time,sales_name,sales_ID,register,type,remark,check_tag,excel_tag) values ('"+order_id+"','"+chain_id+"','"+chain_name+"','"+customer_id+"','"+customer_name+"','"+rs.getString("contact_person1_office_tel")+"','','"+time+"','"+rs.getString("sales_name")+"','"+rs.getString("sales_ID")+"','','','','0','2')" ;
	qcs_db.executeUpdate(sql) ;
	}

	String id="";
	String sqlb="select id from crm_order where order_id='"+order_id+"'";
	rs=qcs_db.executeQuery(sqlb);
	if(rs.next()){
		id=rs.getString("id");
	}
	List rsList = GetWorkflow.getList(qcs_db, "crm_config_workflow", "04");
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
	ResultSet rs_hr2=qcs_db.executeQuery(sql_hr2);
	if(rs_hr2.next()){ 
		sale_bonus_type=rs_hr2.getString("type_name");
		bonus_cost_for_profit_type=rs_hr2.getString("bonus_cost_for_profit_type");
	}
	String sql0="select * from design_file where product_id='"+product_id+"'";
	rs=qcs_db.executeQuery(sql0);
	if(rs.next()){
		Double amount_d=Double.parseDouble(amount)*(-1);
		Double subtotal=rs.getDouble("list_price")*amount_d;
		cost_price_sum=rs.getDouble("cost_price")*amount_d;
		real_cost_price_sum=rs.getDouble("real_cost_price")*amount_d;
	String sql1 = "insert into crm_order_details(order_id,details_number,product_id,product_name,product_describe,list_price,amount,cost_price,real_cost_price,subtotal,amount_unit) values ('"+order_id+"','1','"+product_id+"','"+product_name+"','"+rs.getString("product_describe")+"','"+rs.getString("list_price")+"','"+amount_d+"','"+rs.getString("cost_price")+"','"+rs.getString("real_cost_price")+"','"+subtotal+"','"+rs.getString("amount_unit")+"')" ;
	qcs_db.executeUpdate(sql1);
	String sql2="update crm_order set sale_price_sum='"+subtotal+"',uninvoice_sum='"+subtotal+"',ungather_sum='"+subtotal+"',cost_price_sum='"+cost_price_sum+"',real_cost_price_sum='"+real_cost_price_sum+"',pay_amount_sum='"+amount_d+"',unpay_amount_sum='"+amount_d+"' where order_id='"+order_id+"'";
	qcs_db.executeUpdate(sql2);
	String mod1="/erp/stock_pay_register_ok";
	int filenum1=count.readTime((String)dbSession.getAttribute("unit_db_name"),mod1);
	String pay_ID=time+filenum1;
	count.writeTime((String)dbSession.getAttribute("unit_db_name"),mod1);String main_code2="";
	String first_code2="";	
	String second_code2="";
	sqlb="select * from document_first where main_kind_name='stock' and first_kind_name='pay' ";
	ResultSet rsb=crm_db.executeQuery(sqlb) ;
	if(rsb.next()){
	   main_code2=rsb.getString("main_code");
	   first_code2=rsb.getString("first_code");
	   second_code2=rsb.getString("second_code");
	}
	   pay_ID=main_code2+first_code2+second_code2+pay_ID;


if(rsList.size()==0){
	double order_sale_bonus_subtotal=getRateFromID.getRateFromID((String)dbSession.getAttribute("unit_db_name"),"design_file","product_id",product_id,"order_sale_bonus_rate")*subtotal/100;
	double order_profit_bonus_subtotal=0.0d;
		String product_type="";
String sql16="select * from design_file where product_id='"+product_id+"'";
ResultSet rs16=qcs_db.executeQuery(sql16);
if(rs16.next()){
	product_type=rs16.getString("type");
}
if(product_type.equals("物料")||product_type.equals("外购商品")){

	stock_product_number+=Double.parseDouble(amount);
	stock_price+=cost_price_sum;
	String sql6="insert into stock_pay_details(pay_ID,details_number,product_id,product_name,product_describe,type,cost_price,subtotal,amount,unpay_amount,apply_manufacture_amount,apply_purchase_amount) values('"+pay_ID+"','"+stock_number+"','"+product_id+"','"+product_name+"','','"+product_type+"','','"+cost_price_sum+"','"+amount+"','"+amount+"','0','"+amount+"')";
	qcs_db.executeUpdate(sql6);
	stock_number+=1;
}else if(product_type.equals("商品")||product_type.equals("部件")||product_type.equals("委外部件")){
	stock_product_number+=Double.parseDouble(amount);
	stock_price+=cost_price_sum;
	String sql6="insert into stock_pay_details(pay_ID,details_number,product_id,product_name,product_describe,type,cost_price,subtotal,amount,unpay_amount,apply_manufacture_amount,apply_purchase_amount) values('"+pay_ID+"','"+stock_number+"','"+product_id+"','"+product_name+"','"+product_describe+"','"+product_type+"','','"+cost_price_sum+"','"+amount+"','"+amount+"','"+amount+"','0')";
	qcs_db.executeUpdate(sql6);
	stock_number+=1;
}else if(product_type.equals("服务型产品")){
service_count++;
}
	
		sql2="";
if(service_count==num){
sql2="update crm_order set sale_price_sum='"+sale_price_sum+"',uninvoice_sum='"+sale_price_sum+"',ungather_sum='"+sale_price_sum+"',cost_price_sum='"+cost_price_sum+"',pay_amount_sum='"+pay_amount_sum+"',unpay_amount_sum='"+pay_amount_sum+"',check_tag='1',modify_tag='0',manufacture_tag='1',pay_tag='3',logistics_tag='3',receive_tag='3',gather_tag='1',invoice_tag='1',order_tag='1',order_status='执行',order_sale_bonus_sum='"+order_sale_bonus_sum+"' ,order_profit_bonus_sum='"+order_profit_bonus_sum+"',bonus_calculate_type='"+sale_bonus_type+"' where id='"+id+"'";
}else{
sql2="update crm_order set sale_price_sum='"+sale_price_sum+"',uninvoice_sum='"+sale_price_sum+"',ungather_sum='"+sale_price_sum+"',cost_price_sum='"+cost_price_sum+"',pay_amount_sum='"+pay_amount_sum+"',unpay_amount_sum='"+pay_amount_sum+"',check_tag='1',modify_tag='0',manufacture_tag='1',pay_tag='1',gather_tag='1',invoice_tag='1',order_tag='1',logistics_tag='1',receive_tag='1',order_status='执行',order_sale_bonus_sum='"+order_sale_bonus_sum+"' ,order_profit_bonus_sum='"+order_profit_bonus_sum+"',bonus_calculate_type='"+sale_bonus_type+"' where id='"+id+"'";
}
qcs_db.executeUpdate(sql2) ;
int trade_amount=0;
double achievement_sum=0.0d;
int return_amount=0;
double return_sum=0.0d;
sql3="select * from crm_file where customer_id='"+customer_id+"'";
ResultSet rs3=qcs_db.executeQuery(sql3);
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
String sql4="update crm_file set trade_amount='"+trade_amount+"',return_amount='"+return_amount+"',achievement_sum='"+achievement_sum+"',return_sum='"+return_sum+"',lately_trade_time='"+time+"' where customer_id='"+customer_id+"'";
qcs_db.executeUpdate(sql4);

	double cost_price1=stock_price/stock_product_number;
if(service_count!=num){
	if(!vr.validata((String)dbSession.getAttribute("unit_db_name"),"stock_pay","reasonexact",order_id)){
String sql5="insert into stock_pay(pay_ID,reason,reasonexact,demand_amount,cost_price,cost_price_sum) values('"+pay_ID+"','销售出库','"+order_id+"','"+stock_product_number+"','"+cost_price1+"','"+stock_price+"')";

qcs_db.executeUpdate(sql5);
	}
}
if(!vr.validata((String)dbSession.getAttribute("unit_db_name"),"fund_fund","reasonexact",order_id)){
	String fund_ID=NseerId.getId("fund/gather",(String)dbSession.getAttribute("unit_db_name"));
	String sql14="insert into fund_fund(fund_ID,reason,reasonexact,chain_ID,chain_name,funder,funder_ID,file_chain_ID,file_chain_name,demand_cost_price_sum,currency_name,personal_unit,register,register_time,sales_purchaser_ID,sales_purchaser_name) values('"+fund_ID+"','收款','"+order_id+"','"+chain_id+"','"+chain_name+"','"+customer_name+"','"+customer_id+"','1131','应收账款','"+sale_price_sum+"','人民币','元','','"+time+"','','')";
	qcs_db.executeUpdate(sql14) ;
}
	}else{
		String sql="update crm_order set sale_price_sum='"+sale_price_sum+"',uninvoice_sum='"+sale_price_sum+"',ungather_sum='"+sale_price_sum+"',cost_price_sum='"+cost_price_sum+"',real_cost_price_sum='"+real_cost_price_sum+"',pay_amount_sum='"+pay_amount_sum+"',unpay_amount_sum='"+pay_amount_sum+"' where order_id='"+order_id+"'";
		qcs_db.executeUpdate(sql) ;
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		String[] elem=(String[])ite.next();
		sql = "insert into crm_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+order_id+"','"+elem[1]+"','"+elem[2]+"')" ;
		qcs_db.executeUpdate(sql) ;
		}
	}

	}

}
}
qcs_db.close();
crm_db.close();
stock_db.close();
response.sendRedirect("qcs/other/dealwith_ok.jsp?finished_tag=0");
}catch(Exception ex){
	ex.printStackTrace();
	response.sendRedirect("qcs/other/dealwith_ok.jsp?finished_tag=1");
}
}else{
	response.sendRedirect("error_conn.htm");
}

}catch(Exception ex){
	ex.printStackTrace();
	}
}
}
