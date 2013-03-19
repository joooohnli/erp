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
import validata.ValidataRecordNumber;
import include.nseer_cookie.*;

public class register_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 manufacture_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 manufacturedb = new nseer_db_backup1(dbApplication);
nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);
ValidataRecordNumber vrn=new ValidataRecordNumber();
counter count=new counter(dbApplication);

try{
	if(manufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))&& manufacturedb.conn((String)dbSession.getAttribute("unit_db_name"))&& stock_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String product_ID=request.getParameter("product_ID");
String product_name=request.getParameter("product_name");
String product_describe=request.getParameter("product_describe");
String amount=request.getParameter("amount");
String pay_ID_group=request.getParameter("pay_ID_group");
String designer=request.getParameter("designer") ;
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String bodyb = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyb);
String design_ID=request.getParameter("design_ID") ;
String choice_group=request.getParameter("choice_group");
String[] procedure_ID=request.getParameterValues("procedure_ID");
String[] procedure_name=request.getParameterValues("procedure_name");
String[] procedure_describe=request.getParameterValues("procedure_describe");
String[] labour_hour_amount=request.getParameterValues("labour_hour_amount");
String[] amount_unit=request.getParameterValues("amount_unit");
String[] cost_price=request.getParameterValues("cost_price");
String[] subtotal=request.getParameterValues("subtotal");
double module_cost_price_sum=0.0d;
double labour_cost_price_sum=0.0d;
int n=0;
for(int i=0;i<procedure_name.length;i++){
	StringTokenizer tokenTO1 = new StringTokenizer(choice_group,", ");        
	while(tokenTO1.hasMoreTokens()) {
        String sql5="select * from manufacture_apply where manufacture_tag='1' and id='"+tokenTO1.nextToken()+"'";
		ResultSet rs5=manufacture_db.executeQuery(sql5) ;
		if(rs5.next()){
			n++;
		}
		}
}
if(n==0){
String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
time=formatter.format(now);

StringTokenizer tokenTO = new StringTokenizer(choice_group,", ");        
	while(tokenTO.hasMoreTokens()) {
        String sql4="update manufacture_apply set manufacture_tag='1' where id='"+tokenTO.nextToken()+"'";
		manufacture_db.executeUpdate(sql4) ;
		}
try{
	
String manufacture_ID=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));
for(int i=0;i<procedure_name.length;i++){
	int j=i+1;
	double module_subtotal=0.0d;
	labour_cost_price_sum+=Double.parseDouble(subtotal[i]);
	
	String sql1="select * from manufacture_design_procedure_module_details where design_ID='"+design_ID+"' and procedure_name='"+procedure_name[i]+"'";
	ResultSet rs1=manufacturedb.executeQuery(sql1);
	while(rs1.next()){
		double module_amount=rs1.getDouble("amount")*Double.parseDouble(amount);
		double subtotal1=rs1.getDouble("cost_price")*module_amount;
		module_subtotal+=subtotal1;
		module_cost_price_sum+=subtotal1;
		String sql2="insert into manufacture_procedure_module(manufacture_ID,procedure_name,details_number,product_ID,product_name,product_describe,type,amount,amount_unit,cost_price,subtotal) values('"+manufacture_ID+"','"+procedure_name[i]+"','"+rs1.getString("details_number")+"','"+rs1.getString("product_ID")+"','"+rs1.getString("product_name")+"','"+rs1.getString("product_describe")+"','"+rs1.getString("type")+"','"+module_amount+"','"+rs1.getString("amount_unit")+"','"+rs1.getString("cost_price")+"','"+subtotal1+"')";
		manufacture_db.executeUpdate(sql2);
	}

	String sql="insert into manufacture_procedure(manufacture_ID,details_number,procedure_ID,procedure_name,procedure_describe,labour_hour_amount,amount_unit,cost_price,subtotal,module_subtotal) values('"+manufacture_ID+"','"+j+"','"+procedure_ID[i]+"','"+procedure_name[i]+"','"+procedure_describe[i]+"','"+labour_hour_amount[i]+"','"+amount_unit[i]+"','"+cost_price[i]+"','"+subtotal[i]+"','"+module_subtotal+"')";
	manufacture_db.executeUpdate(sql);
}

	String sql3="insert into manufacture_manufacture(manufacture_ID,product_ID,product_name,product_describe,amount,pay_ID_group,apply_id_group,module_cost_price_sum,labour_cost_price_sum,register_time,designer,register,remark,check_tag,excel_tag) values('"+manufacture_ID+"','"+product_ID+"','"+product_name+"','"+product_describe+"','"+amount+"','"+pay_ID_group+"','"+choice_group+"','"+module_cost_price_sum+"','"+labour_cost_price_sum+"','"+register_time+"','"+designer+"','"+register+"','"+remark+"','0','2')";
	manufacture_db.executeUpdate(sql3);

    List rsList = GetWorkflow.getList(manufacture_db, "manufacture_config_workflow", "04");
    String[] elem=new String[3];

	if(rsList.size()==0){
	String sql= "update manufacture_manufacture set check_tag='1' where manufacture_ID='"+manufacture_ID+"'" ;
	manufacture_db.executeUpdate(sql) ;
	String sql1="select * from manufacture_manufacture where manufacture_ID='"+manufacture_ID+"'";
	ResultSet rs1=manufacture_db.executeQuery(sql1) ;
	if(rs1.next()){
		double cost_price_sum=rs1.getDouble("module_cost_price_sum")+rs1.getDouble("labour_cost_price_sum");
		double cost_price1=cost_price_sum/rs1.getDouble("amount");
		String sql2="update manufacture_procedure set demand_amount='"+rs1.getString("amount")+"' where manufacture_ID='"+manufacture_ID+"' and details_number='1'";
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
		double module_cost_price_sum1=0.0d;
		double demand_amount=0.0d;
		double part_cost_price_sum=0.0d;
		double part_demand_amount=0.0d;
		String sql6="select * from manufacture_procedure_module where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+rs9.getString("procedure_name")+"' order by details_number";
		ResultSet rs6=manufacture_db.executeQuery(sql6) ;
		while(rs6.next()){
			module_cost_price_sum1+=rs6.getDouble("subtotal");
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
		String sql5="insert into stock_pay(pay_ID,reason,reasonexact,reasonexact_details,demand_amount,apply_purchase_amount,cost_price_sum,register,register_time) values('"+pay_ID+"','生产领料','"+manufacture_ID+"','"+rs9.getString("procedure_name")+"','"+demand_amount+"','"+demand_amount+"','"+module_cost_price_sum1+"','"+register+"','"+register_time+"')";
		stock_db.executeUpdate(sql5) ;
	}else if(j!=0&&vrn.validata((String)dbSession.getAttribute("unit_db_name"),"stock_pay","reasonexact",manufacture_ID)<2*procedure_amount){
		String sql5="insert into stock_pay(pay_ID,reason,reasonexact,reasonexact_details,demand_amount,apply_purchase_amount,cost_price_sum,register,register_time) values('"+pay_ID+"','生产领料','"+manufacture_ID+"','"+rs9.getString("procedure_name")+"','"+demand_amount+"','"+demand_amount+"','"+module_cost_price_sum1+"','"+register+"','"+register_time+"')";
		stock_db.executeUpdate(sql5) ;
		String sql11="insert into stock_pay(pay_ID,reason,reasonexact,reasonexact_details,demand_amount,apply_purchase_amount,cost_price_sum,register,register_time) values('"+part_pay_ID+"','部件出库','"+manufacture_ID+"','"+rs9.getString("procedure_name")+"','"+part_demand_amount+"','"+part_demand_amount+"','"+part_cost_price_sum+"','"+register+"','"+register_time+"')";
		stock_db.executeUpdate(sql11) ;
	}
	}		 
	}else{
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		elem=(String[])ite.next();
		String sql = "insert into manufacture_workflow(config_id,object_ID,describe1,describe2,type_id) values ('"+elem[0]+"','"+manufacture_ID+"','"+elem[1]+"','"+elem[2]+"','04')" ;
		manufacture_db.executeUpdate(sql) ;
  
		}
	}
	
}
catch (Exception ex){
ex.printStackTrace();
}
	response.sendRedirect("manufacture/manufacture/register_ok_a.jsp");
}else{
	
	response.sendRedirect("manufacture/manufacture/register_ok_b.jsp");
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