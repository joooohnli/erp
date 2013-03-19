/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package stock.transfer_gather;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import java.text.*;

import include.nseer_cookie.GetWorkflow;
import include.nseer_cookie.exchange;
import include.nseer_cookie.counter;
import validata.ValidataNumber;
import validata.ValidataRecord;

public class draft_ok extends HttpServlet{
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
ValidataRecord vr=new ValidataRecord();
try{
	 String time="";
	 java.util.Date now = new java.util.Date();
	 SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
	 time=formatter.format(now);
	 String mod=request.getRequestURI();
if(stock_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String product_amount=request.getParameter("product_amount") ;
int num=Integer.parseInt(product_amount);
int p=0;
for(int i=1;i<num;i++){
	String tem_amount="amount"+i;
String amount=request.getParameter(tem_amount) ;
	if(!validata.validata(amount)){
			p++;
		}
}
if(p==0){
String reasonexact=request.getParameter("reasonexact") ;
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String bodyb = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyb);
try{
String stock_ID ="";
String stock_name="";
StringTokenizer tokenTO =null;
if(!reasonexact.equals("  /")){
tokenTO = new StringTokenizer(reasonexact,"/");        
            while(tokenTO.hasMoreTokens()) {
                stock_ID = tokenTO.nextToken();
				stock_name = tokenTO.nextToken();
		}
}else{
   tokenTO = new StringTokenizer(reasonexact,"/");        
     if(tokenTO.hasMoreTokens()) {
         stock_ID = tokenTO.nextToken();}
}
String mod1="/erp/stock_gather_register_ok";
int filenumber1=count.readTime((String)dbSession.getAttribute("unit_db_name"),mod1);
String stock_gather_ID=time+filenumber1;
count.writeTime((String)dbSession.getAttribute("unit_db_name"),mod1);
String mod2="/erp/stock_pay_register_ok";
int filenumber2=count.readTime((String)dbSession.getAttribute("unit_db_name"),mod2);
String stock_pay_ID=time+filenumber2;
count.writeTime((String)dbSession.getAttribute("unit_db_name"),mod2);
	int filenum=count.readTime1((String)dbSession.getAttribute("unit_db_name"),mod);
	count.writeTime1((String)dbSession.getAttribute("unit_db_name"),mod);
	String gather_ID=time+filenum;
    mod=mod.substring(mod.lastIndexOf("/")+1);
	StringTokenizer tokenTOO = new StringTokenizer(mod,"_");
	   String sqla="";
	   String main_kind1="";
	   String first_kind1="";
	   String second_kind1="";
	  if (tokenTOO.hasMoreTokens()) {
				main_kind1 = tokenTOO.nextToken();
				first_kind1 = tokenTOO.nextToken();
                second_kind1 = tokenTOO.nextToken();
		 }
		 String first_kind=first_kind1+"_"+second_kind1;
			sqla="select * from document_first where main_kind_name='"+main_kind1+"' and first_kind_name='"+first_kind+"' ";
String main_code="";
String first_code="";
String second_code="";
ResultSet rsa=stock_db.executeQuery(sqla) ;
if(rsa.next()){
   main_code=rsa.getString("main_code");
   first_code=rsa.getString("first_code");
   second_code=rsa.getString("second_code");
}
gather_ID=main_code+first_code+second_code+gather_ID;
String main_code1="";
String first_code1="";
String second_code1="";
String main_code2="";
String first_code2="";
String second_code2="";
 sqla="select * from document_first where main_kind_name='stock' and first_kind_name='gather'";
 rsa=stock_db.executeQuery(sqla) ;
if(rsa.next()){
   main_code1=rsa.getString("main_code");
   first_code1=rsa.getString("first_code");
   second_code1=rsa.getString("second_code");
}
    stock_gather_ID=main_code1+first_code1+second_code1+stock_gather_ID;
String sqlb="select * from document_first where main_kind_name='stock' and first_kind_name='pay'";
ResultSet rsb=stock_db.executeQuery(sqlb) ;
if(rsb.next()){
   main_code2=rsb.getString("main_code");
   first_code2=rsb.getString("first_code");
   second_code2=rsb.getString("second_code");
}
    stock_pay_ID=main_code2+first_code2+second_code2+stock_pay_ID;
	String sql = "insert into stock_transfer_gather(gather_ID,reason,reasonexact,register_time,remark,register,check_tag,excel_tag) values ('"+gather_ID+"','内部调入','"+reasonexact+"','"+register_time+"','"+remark+"','"+register+"','0','2')" ;
	stock_db.executeUpdate(sql) ;
double cost_price_sum=0.0d;
double demand_amount=0.0d;
for(int i=1;i<num;i++){
	String tem_product_name="product_name"+i;
	String tem_product_ID="product_ID"+i;
	String tem_amount="amount"+i;
	String tem_cost_price="cost_price"+i;
	String tem_product_describe="product_describe"+i;
	String tem_amount_unit="amount_unit"+i ;
String product_name=request.getParameter(tem_product_name) ;
String product_ID=request.getParameter(tem_product_ID) ;
String amount=request.getParameter(tem_amount) ;
String cost_price2=request.getParameter(tem_cost_price) ;
String product_describe=request.getParameter(tem_product_describe) ;
String amount_unit=request.getParameter(tem_amount_unit) ;
StringTokenizer tokenTO3 = new StringTokenizer(cost_price2,",");        
String cost_price="";
            while(tokenTO3.hasMoreTokens()) {
                String cost_price1 = tokenTO3.nextToken();
		cost_price +=cost_price1;
		}
	if(!amount.equals("")&&Double.parseDouble(amount)!=0){
	double subtotal=Double.parseDouble(cost_price)*Double.parseDouble(amount);
	cost_price_sum+=subtotal;
	demand_amount+=Double.parseDouble(amount);
	String sql1 = "insert into stock_transfer_gather_details(gather_ID,details_number,product_ID,product_name,product_describe,amount_unit,amount,cost_price,subtotal) values ('"+gather_ID+"','"+i+"','"+product_ID+"','"+product_name+"','"+product_describe+"','"+amount_unit+"','"+amount+"','"+cost_price+"','"+subtotal+"')" ;
	stock_db.executeUpdate(sql1) ;
	}
}
String nseer_sql="update stock_transfer_gather set cost_price_sum='"+cost_price_sum+"',demand_amount='"+demand_amount+"',check_tag='5' where gather_ID='"+gather_ID+"'";
		stock_db.executeUpdate(nseer_sql);
}
catch (Exception ex){
ex.printStackTrace();
}
response.sendRedirect("stock/transfer_gather/register_ok_c.jsp");
}else{
response.sendRedirect("stock/transfer_gather/register_ok_b.jsp");
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
