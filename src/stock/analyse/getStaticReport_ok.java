/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package stock.analyse;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import java.text.*;

import include.nseer_cookie.NseerId;
import include.nseer_cookie.counter;
import include.get_sql.getInsertSql;

public class getStaticReport_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 stock_db1 = new nseer_db_backup1(dbApplication);
getInsertSql getInsertSql=new getInsertSql();
counter count=new counter(dbApplication);

try{
if(stock_db.conn((String)dbSession.getAttribute("unit_db_name"))&&stock_db1.conn((String)dbSession.getAttribute("unit_db_name"))){
String time="";
java.util.Date  now  =  new  java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
time=formatter.format(now);
String time1=time+" 00:00:00";
String time2=time+" 23:59:59";
String register_ID=(String)session.getAttribute("human_IDD");
String register=(String)session.getAttribute("realeditorc");
java.util.Date now1 = new java.util.Date();
SimpleDateFormat formatter1 = new SimpleDateFormat("yyyyMMdd");
String timea=formatter1.format(now1);
String static_report_ID=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));

String sql1="select * from stock_balance_details_details" ;
ResultSet rs1=stock_db.executeQuery(sql1);
while(rs1.next()){
	String sql2="insert into stock_balance_static_report_details_details(STATIC_REPORT_ID,STATIC_REPORT_TIME,REGISTER_ID,REGISTER,CHAIN_ID,CHAIN_NAME,PRODUCT_ID,PRODUCT_NAME,PRODUCT_DESCRIBE,AMOUNT_UNIT,AMOUNT,MAX_CAPACITY_AMOUNT,MAX_AMOUNT,MIN_AMOUNT,COST_PRICE,SUBTOTAL,STOCK_ID,STOCK_NAME,NICK_NAME,CHECK_TAG,UNIQUE_TAG,REGISTER_TIME,STOCK_GATHER_GROUP_ID,SERIAL_NUMBER,TYPE,BALANCE_TYPE ) values('"+static_report_ID+"','"+time+"','"+register_ID+"','"+register+"','"+rs1.getString("CHAIN_ID")+"','"+rs1.getString("CHAIN_NAME")+"','"+rs1.getString("PRODUCT_ID")+"','"+rs1.getString("PRODUCT_NAME")+"','"+rs1.getString("PRODUCT_DESCRIBE")+"','"+rs1.getString("AMOUNT_UNIT")+"','"+rs1.getString("AMOUNT")+"','"+rs1.getString("MAX_CAPACITY_AMOUNT")+"','"+rs1.getString("MAX_AMOUNT")+"','"+rs1.getString("MIN_AMOUNT")+"','"+rs1.getString("COST_PRICE")+"','"+rs1.getString("SUBTOTAL")+"','"+rs1.getString("STOCK_ID")+"','"+rs1.getString("STOCK_NAME")+"','"+rs1.getString("NICK_NAME")+"','"+rs1.getString("CHECK_TAG")+"','"+rs1.getString("UNIQUE_TAG")+"','"+rs1.getString("REGISTER_TIME")+"','"+rs1.getString("STOCK_GATHER_GROUP_ID")+"','"+rs1.getString("SERIAL_NUMBER")+"','"+rs1.getString("TYPE")+"','"+rs1.getString("BALANCE_TYPE")+"')";
	stock_db1.executeUpdate(sql2);
}
String sql3="select * from stock_balance_details" ;
ResultSet rs3=stock_db.executeQuery(sql3);
while(rs3.next()){
String sql4="insert into stock_balance_static_report_details(STATIC_REPORT_ID,STATIC_REPORT_TIME,REGISTER_ID,REGISTER,CHAIN_ID,CHAIN_NAME,PRODUCT_ID,PRODUCT_NAME,PRODUCT_DESCRIBE,AMOUNT_UNIT,AMOUNT,MAX_CAPACITY_AMOUNT,MAX_AMOUNT,MIN_AMOUNT,COST_PRICE,SUBTOTAL,STOCK_ID,STOCK_NAME,NICK_NAME,CHECK_TAG,UNIQUE_TAG,REGISTER_TIME,TYPE,BALANCE_TYPE ) values('"+static_report_ID+"','"+time+"','"+register_ID+"','"+register+"','"+rs3.getString("CHAIN_ID")+"','"+rs3.getString("CHAIN_NAME")+"','"+rs3.getString("PRODUCT_ID")+"','"+rs3.getString("PRODUCT_NAME")+"','"+rs3.getString("PRODUCT_DESCRIBE")+"','"+rs3.getString("AMOUNT_UNIT")+"','"+rs3.getString("AMOUNT")+"','"+rs3.getString("MAX_CAPACITY_AMOUNT")+"','"+rs3.getString("MAX_AMOUNT")+"','"+rs3.getString("MIN_AMOUNT")+"','"+rs3.getString("COST_PRICE")+"','"+rs3.getString("SUBTOTAL")+"','"+rs3.getString("STOCK_ID")+"','"+rs3.getString("STOCK_NAME")+"','"+rs3.getString("NICK_NAME")+"','"+rs3.getString("CHECK_TAG")+"','"+rs3.getString("UNIQUE_TAG")+"','"+rs3.getString("REGISTER_TIME")+"','"+rs3.getString("TYPE")+"','"+rs3.getString("BALANCE_TYPE")+"')";
stock_db1.executeUpdate(sql4);
}
String sql5="select * from stock_balance" ;
ResultSet rs5=stock_db.executeQuery(sql5);
while(rs5.next()){
String sql6="insert into stock_balance_static_report(STATIC_REPORT_ID,STATIC_REPORT_TIME,REGISTER_ID,REGISTER,CHAIN_ID,CHAIN_NAME,PRODUCT_ID,PRODUCT_NAME,PRODUCT_DESCRIBE,AMOUNT_UNIT,COST_PRICE_SUM,AMOUNT,COST_PRICE,ADDRESS_GROUP,REGISTER_TIME,TYPE,BALANCE_TYPE) values('"+static_report_ID+"','"+time+"','"+register_ID+"','"+register+"','"+rs5.getString("CHAIN_ID")+"','"+rs5.getString("CHAIN_NAME")+"','"+rs5.getString("PRODUCT_ID")+"','"+rs5.getString("PRODUCT_NAME")+"','"+rs5.getString("PRODUCT_DESCRIBE")+"','"+rs5.getString("AMOUNT_UNIT")+"','"+rs5.getString("COST_PRICE_SUM")+"','"+rs5.getString("AMOUNT")+"','"+rs5.getString("COST_PRICE")+"','"+rs5.getString("ADDRESS_GROUP")+"','"+rs5.getString("REGISTER_TIME")+"','"+rs5.getString("TYPE")+"','"+rs5.getString("BALANCE_TYPE")+"')";
stock_db1.executeUpdate(sql6);
}
stock_db.commit();
stock_db1.commit();
stock_db.close();
stock_db1.close();
response.sendRedirect("stock/analyse/getStaticReport_ok_a.jsp?static_report_ID="+static_report_ID+"");
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}