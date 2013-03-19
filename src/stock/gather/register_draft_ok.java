/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package stock.gather;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import java.text.SimpleDateFormat;

import javax.servlet.*;
import java.io.* ;
import java.util.* ;

import include.get_rate_from_ID.getRateFromID;
import include.nseer_db.*;
import include.nseer_cookie.*;
import validata.ValidataNumber;
import stock.getLength;

public class register_draft_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);
ValidataNumber validata=new ValidataNumber();
counter count=new counter(dbApplication);
getLength length=new getLength();
getRateFromID getRateFromID=new getRateFromID();

try{
	 
if(stock_db.conn((String)dbSession.getAttribute("unit_db_name"))){
java.util.Date  now  =  new  java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String gather_ID=request.getParameter("gather_ID");
String[] serial_number_group=request.getParameterValues("serial_number");
String[] stock_name=request.getParameterValues("stock_name");
String[] amount=request.getParameterValues("amount");
String[] serial_number=new String[stock_name.length];
String[] product_ID=request.getParameterValues("product_ID");
int p=0;
int lll=0;
for(int i=0;i<stock_name.length;i++){


	
	if(!amount[i].equals("")){
		if(!validata.validata(amount[i])){
			p++;
		}
	}else{
		amount[i]="0";
	}
	serial_number[i]="";
	int serial_number_tag=0;
	String sql6="select * from stock_cell where product_ID='"+product_ID[i]+"' and check_tag='1'";
	ResultSet rs6=stock_db.executeQuery(sql6);
	if(rs6.next()){
		serial_number_tag=rs6.getInt("serial_number_tag");
	}
	if(serial_number_tag==1){
		lll=length.getLength((String)dbSession.getAttribute("unit_db_name"));
		}else{
			lll=length.getLength2((String)dbSession.getAttribute("unit_db_name"));
			}
	if(serial_number_tag!=0&&Double.parseDouble(amount[i])!=0&&serial_number_group[i].equals("")){
		p++;
	}else if(serial_number_tag==0&&Double.parseDouble(amount[i])!=0&&!serial_number_group[i].equals("")){
		p++;
	}
	if(!serial_number_group[i].equals("")){
	if(serial_number_group[i].length()%lll==0){
	
		if(serial_number_tag==1&&serial_number_group[i].length()/lll!=Double.parseDouble(amount[i])){
			p++;
		}
	}else{
		p++;
	}
	if(p==0){
	int j=0;
	while(j<serial_number_group[i].length()){
		serial_number[i]+=serial_number_group[i].substring(j,j+lll)+", ";
			if(serial_number_tag==1){

		String sql3="select * from stock_balance_details_details where serial_number='"+serial_number_group[i].substring(j,j+lll)+"' and stock_name!='内部调入' and stock_name!='内部调出'";
		ResultSet rs3=stock_db.executeQuery(sql3);
		if(rs3.next()){
			p++;
		}
	}
		String sql="insert into stock_serial_number_temp(serial_number) values('"+serial_number_group[i].substring(j,j+lll)+"')";
		stock_db.executeUpdate(sql);
		j+=lll;
	}
	serial_number[i]=serial_number[i].substring(0,serial_number[i].length()-2);
	if(serial_number_tag==1){
	String sql1="select distinct serial_number from stock_serial_number_temp";
	ResultSet rs1=stock_db.executeQuery(sql1);
	rs1.last();
	if(rs1.getRow()!=Double.parseDouble(amount[i])){
		p++;
	}
	String sql2="delete from stock_serial_number_temp";
	stock_db.executeUpdate(sql2);
	}else{
	String sql1="select distinct serial_number from stock_serial_number_temp";
	ResultSet rs1=stock_db.executeQuery(sql1);
	rs1.last();
	if(rs1.getRow()!=1){
		p++;
	}
	String sql2="delete from stock_serial_number_temp";
	stock_db.executeUpdate(sql2);
	}




	}
	}
	
}
if(p==0){
String reason=request.getParameter("reason");
String reasonexact=request.getParameter("reasonexact");
String reasonexact_details=request.getParameter("reasonexact_details");
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String[] product_name=request.getParameterValues("product_name");
String[] cost_price=request.getParameterValues("cost_price");
String[] demand_amount=request.getParameterValues("demand_amount") ;
String[] gathered_amount=request.getParameterValues("gathered_amount") ;
String[] gathered_subtotal=request.getParameterValues("gathered_subtotal");
String[] stock_ID=request.getParameterValues("stock_ID");
String[] nick_name=request.getParameterValues("nick_name");
String[] max_capacity_amount=request.getParameterValues("max_capacity_amount");
String[] details_number=request.getParameterValues("details_number");
String[] available_amount=request.getParameterValues("available_amount");
int n=0;
double amount_sum=0.0d;
for(int i=0;i<stock_name.length;i++){
	if(!amount[i].equals("")){
		if(Double.parseDouble(demand_amount[i])>=0){
		amount_sum+=Double.parseDouble(amount[i]);
		if(Double.parseDouble(amount[i])>Double.parseDouble(available_amount[i])){
		n++;
	}else if(Math.abs(Double.parseDouble(amount[i])+Double.parseDouble(gathered_amount[i]))>Math.abs(Double.parseDouble(demand_amount[i]))){
		n++;
	}
		}
	}
}
if(n==0){
try{
int gathering_time=0;
String sqq="select gathering_time from stock_gather where gather_ID='"+gather_ID+"'";
ResultSet rsq=stock_db.executeQuery(sqq);
if(rsq.next()){
	gathering_time=rsq.getInt("gathering_time")+1;
}
sqq="update stock_gather set gathering_time='"+gathering_time+"',check_tag='5' where gather_ID='"+gather_ID+"'";
stock_db.executeUpdate(sqq);
double amount4=0.0d;
double cost_price_sum=0.0d;
	for(int i=0;i<stock_name.length;i++){
	if(!amount[i].equals("")&&Double.parseDouble(amount[i])!=0){

			int serial_number_tag=0;
	String sql6="select * from stock_cell where product_ID='"+product_ID[i]+"' and check_tag='1'";
	ResultSet rs6=stock_db.executeQuery(sql6);
	if(rs6.next()){
		serial_number_tag=rs6.getInt("serial_number_tag");
	}
	if(serial_number_tag==1){
		lll=length.getLength((String)dbSession.getAttribute("unit_db_name"));
		}else{
			lll=length.getLength2((String)dbSession.getAttribute("unit_db_name"));
			}		
			if(serial_number_tag==2){

			serial_number[i]=serial_number[i].substring(0,lll);
		}
	double subtotal=Double.parseDouble(cost_price[i])*Double.parseDouble(amount[i]);
	double amount22=Double.parseDouble(amount[i])+Double.parseDouble(gathered_amount[i]);
	
		String sql4="insert into stock_paying_gathering(gather_ID,product_ID,details_number,product_name,amount,demand_amount,gathered_amount,cost_price,subtotal,gathered_subtotal,register,register_time,stock_ID,stock_name,max_capacity_amount,nick_name,serial_number,check_tag,gathering_time) values('"+gather_ID+"','"+product_ID[i]+"','"+details_number[i]+"','"+product_name[i]+"','"+amount[i]+"','"+demand_amount[i]+"','"+gathered_amount[i]+"','"+cost_price[i]+"','"+subtotal+"','"+gathered_subtotal[i]+"','"+register+"','"+register_time+"','"+stock_ID[i]+"','"+stock_name[i]+"','"+max_capacity_amount[i]+"','"+nick_name[i]+"','"+serial_number[i]+"','0','"+gathering_time+"')";
		//out.println(sql4);
		stock_db.executeUpdate(sql4);
		String sql="update stock_pre_gathering set gather_check_tag='5' where gather_ID='"+gather_ID+"' and product_ID='"+product_ID[i]+"' and stock_ID='"+stock_ID[i]+"'";
		stock_db.executeUpdate(sql);
	

	}
	}


	if(reason.equals("采购入库")){
		String sql5="update purchase_purchase set stock_gather_tag='2' where purchase_ID='"+reasonexact+"'"; 
		stock_db.executeUpdate(sql5);
	}

response.sendRedirect("stock/gather/register_ok.jsp?finished_tag=0");

}
catch (Exception ex){
ex.printStackTrace();
}

}else{
response.sendRedirect("stock/gather/register_ok.jsp?finished_tag=1");
}
}else{
response.sendRedirect("stock/gather/register_ok.jsp?finished_tag=2");
}
stock_db.commit();
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