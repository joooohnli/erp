/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package manufacture.manufacture;
 
 
import include.nseer_cookie.counter;
import include.nseer_cookie.exchange;
import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

import validata.ValidataNumber;
import validata.ValidataRecordNumber;
import validata.ValidataTag;
import include.nseer_cookie.NseerId;;

public class check_ok extends HttpServlet{
public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 manufacture_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 manufacturedb = new nseer_db_backup1(dbApplication);
counter count=new counter(dbApplication);
ValidataNumber validata=new ValidataNumber();
ValidataTag vt=new ValidataTag();
ValidataRecordNumber vrn=new ValidataRecordNumber();
String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
time=formatter.format(now);
try{
	if(manufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))&&manufacturedb.conn((String)dbSession.getAttribute("unit_db_name"))&&stock_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String config_id=request.getParameter("config_id");
String manufacture_ID=request.getParameter("manufacture_ID");
String designer=request.getParameter("designer") ;
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String checker=request.getParameter("checker") ;
String checker_ID=request.getParameter("checker_ID") ;
String check_time=request.getParameter("check_time") ;
String bodyb = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyb);
String sql6="select id from manufacture_workflow where object_ID='"+manufacture_ID+"' and ((check_tag='0' and config_id<'"+config_id+"') or (check_tag='1' and config_id='"+config_id+"'))";
ResultSet rs6=manufacture_db.executeQuery(sql6);
if(!rs6.next()){					
	if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"manufacture_manufacture","manufacture_ID",manufacture_ID,"check_tag").equals("0")){

String sql = "update manufacture_manufacture set designer='"+designer+"',register='"+register+"',register_time='"+register_time+"',remark='"+remark+"',checker='"+checker+"',check_time='"+check_time+"' where manufacture_ID='"+manufacture_ID+"'" ;
manufacture_db.executeUpdate(sql) ;
String sql2 = "update manufacture_workflow set checker='"+checker+"',checker_ID='"+checker_ID+"',check_time='"+check_time+"',check_tag='1' where object_ID='"+manufacture_ID+"' and config_id='"+config_id+"'" ;
	manufacture_db.executeUpdate(sql2);
	sql2="select id from manufacture_workflow where object_ID='"+manufacture_ID+"' and check_tag='0'";
	ResultSet rset=manufacture_db.executeQuery(sql2);
	if(!rset.next()){
		sql = "update manufacture_manufacture set check_tag='1' where manufacture_ID='"+manufacture_ID+"'" ;
			manufacture_db.executeUpdate(sql) ;
	String sql1="select * from manufacture_manufacture where manufacture_ID='"+manufacture_ID+"'";
	ResultSet rs1=manufacture_db.executeQuery(sql1) ;
	if(rs1.next()){
		double cost_price_sum=rs1.getDouble("module_cost_price_sum")+rs1.getDouble("labour_cost_price_sum");
		double cost_price=cost_price_sum/rs1.getDouble("amount");
		 sql2="update manufacture_procedure set demand_amount='"+rs1.getString("amount")+"' where manufacture_ID='"+manufacture_ID+"' and details_number='1'";
		manufacture_db.executeUpdate(sql2) ;
		
	}
manufacture_db.commit();
	int procedure_amount=0;
	String sql10="select count(*) from manufacture_procedure where manufacture_ID='"+manufacture_ID+"'";
	ResultSet rs10=manufacturedb.executeQuery(sql10) ;
	if(rs10.next()){
		procedure_amount=rs10.getInt("count(*)");
	}
	

	String sql9="select * from manufacture_procedure where manufacture_ID='"+manufacture_ID+"' order by details_number";
	ResultSet rs9=manufacturedb.executeQuery(sql9) ;
	while(rs9.next()){
		
String pay_ID=NseerId.getId("stock/pay",(String)dbSession.getAttribute("unit_db_name"));
String part_pay_ID=pay_ID+"part";
		int i=1;
		int j=0;
		double module_cost_price_sum=0.0d;
		double demand_amount=0.0d;
		double part_cost_price_sum=0.0d;
		double part_demand_amount=0.0d;
		 sql6="select * from manufacture_procedure_module where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+rs9.getString("procedure_name")+"' order by details_number";
		 rs6=manufacture_db.executeQuery(sql6) ;
		while(rs6.next()){
			module_cost_price_sum+=rs6.getDouble("subtotal");
			demand_amount+=rs6.getDouble("amount");
			if(rs6.getString("type").equals("物料")){
			String sql7="insert into stock_pay_details(pay_ID,details_number,product_ID,product_name,product_describe,type,amount,apply_purchase_amount,amount_unit,cost_price,subtotal) values('"+pay_ID+"','"+i+"','"+rs6.getString("product_ID")+"','"+rs6.getString("product_name")+"','"+rs6.getString("product_describe")+"','"+rs6.getString("type")+"','"+rs6.getString("amount")+"','"+rs6.getString("amount")+"','"+rs6.getString("amount_unit")+"','"+rs6.getString("cost_price")+"','"+rs6.getString("subtotal")+"')";
			stock_db.executeUpdate(sql7) ;
			}
			i++;
			if(rs6.getString("type").equals("部件")||rs6.getString("type").equals("委外部件")){
				part_cost_price_sum+=rs6.getDouble("subtotal");
				part_demand_amount+=rs6.getDouble("amount");
				j++;
				String sql13="insert into stock_pay_details(pay_ID,details_number,product_ID,product_name,product_describe,type,amount,apply_purchase_amount,amount_unit,cost_price,subtotal) values('"+pay_ID+"','"+i+"','"+rs6.getString("product_ID")+"','"+rs6.getString("product_name")+"','"+rs6.getString("product_describe")+"','"+rs6.getString("type")+"','"+rs6.getString("amount")+"','0','"+rs6.getString("amount_unit")+"','"+rs6.getString("cost_price")+"','"+rs6.getString("subtotal")+"')";
				stock_db.executeUpdate(sql13) ;
				String sql12="insert into stock_pay_details(pay_ID,details_number,product_ID,product_name,product_describe,type,amount,apply_manufacture_amount,amount_unit,cost_price,subtotal) values('"+part_pay_ID+"','"+j+"','"+rs6.getString("product_ID")+"','"+rs6.getString("product_name")+"','"+rs6.getString("product_describe")+"','"+rs6.getString("type")+"','"+rs6.getString("amount")+"','"+rs6.getString("amount")+"','"+rs6.getString("amount_unit")+"','"+rs6.getString("cost_price")+"','"+rs6.getString("subtotal")+"')";
				stock_db.executeUpdate(sql12) ;
			}
		}
if(j==0&&vrn.validata((String)dbSession.getAttribute("unit_db_name"),"stock_pay","reasonexact",manufacture_ID)<procedure_amount){
		String sql5="insert into stock_pay(pay_ID,reason,reasonexact,reasonexact_details,demand_amount,apply_purchase_amount,cost_price_sum,register,register_time) values('"+pay_ID+"','生产领料','"+manufacture_ID+"','"+rs9.getString("procedure_name")+"','"+demand_amount+"','"+demand_amount+"','"+module_cost_price_sum+"','"+checker+"','"+check_time+"')";
		stock_db.executeUpdate(sql5) ;
	}else if(j!=0&&vrn.validata((String)dbSession.getAttribute("unit_db_name"),"stock_pay","reasonexact",manufacture_ID)<2*procedure_amount){
		String sql5="insert into stock_pay(pay_ID,reason,reasonexact,reasonexact_details,demand_amount,apply_purchase_amount,cost_price_sum,register,register_time) values('"+pay_ID+"','生产领料','"+manufacture_ID+"','"+rs9.getString("procedure_name")+"','"+demand_amount+"','"+demand_amount+"','"+module_cost_price_sum+"','"+checker+"','"+check_time+"')";
		stock_db.executeUpdate(sql5) ;
		String sql11="insert into stock_pay(pay_ID,reason,reasonexact,reasonexact_details,demand_amount,apply_purchase_amount,cost_price_sum,register,register_time) values('"+part_pay_ID+"','部件出库','"+manufacture_ID+"','"+rs9.getString("procedure_name")+"','"+part_demand_amount+"','"+part_demand_amount+"','"+part_cost_price_sum+"','"+checker+"','"+check_time+"')";
		stock_db.executeUpdate(sql11) ;
	}
	}
	}
	response.sendRedirect("manufacture/manufacture/check_ok.jsp?finished_tag=0");

}else{
	response.sendRedirect("manufacture/manufacture/check_ok.jsp?finished_tag=1");
}
}else{
response.sendRedirect("manufacture/manufacture/check_ok.jsp?finished_tag=2");
}
manufacture_db.commit();
manufacturedb.commit();
stock_db.commit();
manufacturedb.close();	
manufacture_db.close();
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