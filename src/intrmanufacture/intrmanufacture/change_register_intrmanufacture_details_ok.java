/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package intrmanufacture.intrmanufacture;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.util.*;
import java.io.*;
import include.nseer_cookie.exchange;
import include.nseer_db.*;
import stock.getAvailable;
import include.nseer_cookie.counter;
import validata.ValidataNumber;


public class change_register_intrmanufacture_details_ok extends HttpServlet{

//创建方法

ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


try{

HttpSession session=request.getSession();
PrintWriter out=response.getWriter();

nseer_db_backup1 intrmanufacture_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 fund_db = new nseer_db_backup1(dbApplication);

if(intrmanufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))&&stock_db.conn((String)dbSession.getAttribute("unit_db_name"))&&fund_db.conn((String)dbSession.getAttribute("unit_db_name"))){

getAvailable available= new  getAvailable();
counter  count= new  counter(dbApplication);
ValidataNumber  validata= new ValidataNumber();

double amount1=0.0d;
String intrmanufacture_ID=request.getParameter("intrmanufacture_ID") ;
String demand_gather_shipFee_sum2=request.getParameter("demand_gather_shipFee_sum") ;
String demand_price2=request.getParameter("demand_price") ;
String demand_amount=request.getParameter("demand_amount") ;
if(demand_gather_shipFee_sum2.equals("")) demand_gather_shipFee_sum2="0";
int n=0;		
if(!validata.validata(demand_price2)||!validata.validata(demand_amount)){
			n++;
		}
if(n==0){
String details_number=request.getParameter("details_number") ;
String provider_ID=request.getParameter("provider_ID") ;
String provider_name=request.getParameter("provider_name") ;
String designer=request.getParameter("designer") ;
String contact_person=request.getParameter("contact_person") ;
String provider_tel=request.getParameter("provider_tel") ;
String provider_fax=request.getParameter("provider_fax") ;
String demand_gather_time=request.getParameter("demand_gather_time") ;
String demand_gather_type=request.getParameter("demand_gather_type") ;
String demand_gather_shipFee_type=request.getParameter("demand_gather_shipFee_type") ;
StringTokenizer tokenTO1 = new StringTokenizer(demand_gather_shipFee_sum2,",");        
String demand_gather_shipFee_sum="";
            while(tokenTO1.hasMoreTokens()) {
                String demand_gather_shipFee_sum1 = tokenTO1.nextToken();
		demand_gather_shipFee_sum +=demand_gather_shipFee_sum1;
		}
String demand_pay_time=request.getParameter("demand_pay_time") ;
String demand_pay_type=request.getParameter("demand_pay_type") ;
String demand_pay_method=request.getParameter("demand_pay_method") ;
String demand_invoice_type=request.getParameter("demand_invoice_type") ;
String amount=request.getParameter("amount") ;
StringTokenizer tokenTO2 = new StringTokenizer(demand_price2,",");        
String demand_price="";
            while(tokenTO2.hasMoreTokens()) {
                String demand_price1 = tokenTO2.nextToken();
		demand_price +=demand_price1;
		}
double demand_cost_price_sum=Double.parseDouble(demand_price)*Double.parseDouble(demand_amount);
String credit_period=request.getParameter("credit_period") ;
String bodyc = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyc);
String sql1="select sum(demand_amount) from intrmanufacture_details where intrmanufacture_ID='"+intrmanufacture_ID+"' and provider_ID!='"+provider_ID+"'";
ResultSet rs1=intrmanufacture_db.executeQuery(sql1) ;
while(rs1.next()){
	amount1=rs1.getDouble("sum(demand_amount)");
}
double amount2=amount1+Double.parseDouble(demand_amount);
double amount99=Double.parseDouble(demand_amount);
String gather_ID="";
	String sql22="select * from stock_gather where reasonexact='"+intrmanufacture_ID+"'";
	ResultSet rs22=stock_db.executeQuery(sql22) ;
	while(rs22.next()){
		gather_ID=rs22.getString("gather_ID");
	}
	String sql66="select * from stock_pre_gathering where gather_ID='"+gather_ID+"' order by details_number";
	ResultSet rs66=stock_db.executeQuery(sql66) ;
	while(rs66.next()&&amount99>0){//更新入库单调度表，按序号循环执行
		double amount10=new Double(rs66.getDouble("max_capacity_amount")*available.available((String)dbSession.getAttribute("unit_db_name"),rs66.getString("stock_name"))).intValue();
		
		if(amount10>=amount99){//当前可存放数量不小于增加数量
		amount99=0;//置零以终止循环
		}else{
		amount99=amount99-amount10;
		}
	}
if(Double.parseDouble(demand_amount)>=0&&amount99==0){
try{
	String sql = "insert into intrmanufacture_details(intrmanufacture_ID,details_number,provider_ID,provider_name,designer,demand_contact_person,demand_contact_person_tel,demand_gather_time,demand_gather_type,demand_gather_shipFee_type,demand_gather_shipFee_sum,demand_pay_time,demand_pay_type,demand_pay_method,demand_invoice_type,demand_amount,demand_price,demand_cost_price_sum,credit_period,remark,check_tag) values ('"+intrmanufacture_ID+"','"+details_number+"','"+provider_ID+"','"+provider_name+"','"+designer+"','"+contact_person+"','"+provider_tel+"','"+demand_gather_time+"','"+demand_gather_type+"','"+demand_gather_shipFee_type+"','"+demand_gather_shipFee_sum+"','"+demand_pay_time+"','"+demand_pay_type+"','"+demand_pay_method+"','"+demand_invoice_type+"','"+demand_amount+"','"+demand_price+"','"+demand_cost_price_sum+"','"+credit_period+"','"+remark+"','0')" ;
	intrmanufacture_db.executeUpdate(sql) ;
	int filenum=count.read((String)dbSession.getAttribute("unit_db_name"),"fundfundcount");
	String fund_ID="L"+filenum;
	count.write((String)dbSession.getAttribute("unit_db_name"),"fundfundcount",filenum);
	String sql12="insert into fund_fund(fund_ID,reason,reasonexact,funder,funder_ID,file_chain_id,file_chain_name,demand_cost_price_sum,currency_name,personal_unit) values('"+fund_ID+"','付款','"+intrmanufacture_ID+"','"+provider_name+"','"+provider_ID+"','2121','应付账款-委外加工费','"+demand_cost_price_sum+"','人民币','元')";
	fund_db.executeUpdate(sql12) ;
	double amount7=Double.parseDouble(amount)+Double.parseDouble(demand_amount);
	String sql9 = "update intrmanufacture_intrmanufacture set demand_amount='"+amount7+"' where intrmanufacture_ID='"+intrmanufacture_ID+"'"; 
	intrmanufacture_db.executeUpdate(sql9) ;
	String sql2="select * from stock_gather where reasonexact='"+intrmanufacture_ID+"'";
	ResultSet rs2=stock_db.executeQuery(sql2) ;
	while(rs2.next()){
		gather_ID=rs2.getString("gather_ID");
		double amount4=rs2.getDouble("demand_amount")+Double.parseDouble(demand_amount);
		String sql3="update stock_gather set demand_amount='"+amount4+"' where reasonexact='"+intrmanufacture_ID+"'";
		stock_db.executeUpdate(sql3) ;
	}
	String sql4="select * from stock_gather_details where gather_ID='"+gather_ID+"'";
	ResultSet rs4=stock_db.executeQuery(sql4) ;
	while(rs4.next()){
		double amount5=rs4.getDouble("amount")+Double.parseDouble(demand_amount);
		String sql5="update stock_gather_details set amount='"+amount5+"' where gather_ID='"+gather_ID+"'";
		stock_db.executeUpdate(sql5) ;
	}
	double amount9=Double.parseDouble(demand_amount);
	String sql6="select * from stock_pre_gathering where gather_ID='"+gather_ID+"' order by details_number";
	ResultSet rs6=stock_db.executeQuery(sql6) ;
	while(rs6.next()&&amount9>0){//更新入库单调度表，按序号循环执行
		double amount10=new Double(rs6.getDouble("max_capacity_amount")*available.available((String)dbSession.getAttribute("unit_db_name"),rs6.getString("stock_name"))).intValue();
		
		if(amount10>=amount9){//当前可存放数量不小于增加数量
			double amount6=rs6.getDouble("amount")+amount9;
			double amount11=amount6-rs6.getDouble("gathered_amount");
		String sql7="update stock_pre_gathering set amount='"+amount6+"',ungather_amount='"+amount11+"' where gather_ID='"+gather_ID+"' and details_number='"+rs6.getString("details_number")+"'";
		stock_db.executeUpdate(sql7) ;
		amount9=0;//置零以终止循环
		}else{
			double amount8=rs6.getDouble("amount")+amount10;
			double amount12=amount8-rs6.getDouble("gathered_amount");
		String sql8="update stock_pre_gathering set amount='"+amount8+"',ungather_amount='"+amount12+"' where gather_ID='"+gather_ID+"' and details_number='"+rs6.getString("details_number")+"'";
		stock_db.executeUpdate(sql8) ;
		amount9=amount9-amount10;
		}
	}
		
		response.sendRedirect("change_choose_attachment.jsp?provider_ID="+provider_ID+"&&intrmanufacture_ID="+intrmanufacture_ID+"");
}
catch (Exception ex){
out.println("error"+ex);
}

session.setAttribute("provider_name",provider_name);
session.setAttribute("intrmanufacture_ID",intrmanufacture_ID);
response.sendRedirect("intrmanufacture/intrmanufacture/change_register_intrmanufacture_details_ok_a.jsp");

}else{
	
response.sendRedirect("intrmanufacture/intrmanufacture/change_register_intrmanufacture_details_ok_b.jsp?intrmanufacture_ID="+intrmanufacture_ID+"");

}
}else{

response.sendRedirect("intrmanufacture/intrmanufacture/change_register_intrmanufacture_details_ok_c.jsp?intrmanufacture_ID="+intrmanufacture_ID+"");
}
	intrmanufacture_db.commit();
	stock_db.commit();
		fund_db.commit();
	intrmanufacture_db.close();
		stock_db.close();
		fund_db.close();


}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}