/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package manufacture.module_balance;
 
import include.nseer_cookie.counter;
import include.nseer_cookie.exchange;
import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

import validata.ValidataNumber;
import validata.ValidataRecord;

public class register_procedure_module_draft_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 manufacture_db = new nseer_db_backup1(dbApplication);


ValidataNumber validata=new ValidataNumber();
ValidataRecord vr=new ValidataRecord();
counter count=new counter(dbApplication);

try{
	if(manufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String manufacture_ID=request.getParameter("manufacture_ID") ;
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
 String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
time=formatter.format(now);
String procedure_name=request.getParameter("procedure_name") ;
String procedure_ID=request.getParameter("procedure_ID") ;
String register_time=request.getParameter("register_time") ;
String procedure_responsible_person=request.getParameter("procedure_responsible_person") ;
String register=request.getParameter("register") ;
String bodyc = new String(request.getParameter("reason").getBytes("UTF-8"),"UTF-8");
String reason=exchange.toHtml(bodyc);

int module_time=1;
String sql1="select module_time from manufacture_module_balance where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+procedure_name+"'";
ResultSet rs1=manufacture_db.executeQuery(sql1);
if(rs1.next()){
	module_time=rs1.getInt("module_time")+1;
}
	 sql1="select * from manufacture_manufacture where manufacture_ID='"+manufacture_ID+"'";
	 rs1=manufacture_db.executeQuery(sql1) ;
	if(rs1.next()){
	String sql = "insert into manufacture_module_balance(manufacture_ID,product_ID,product_name,procedure_ID,procedure_name,procedure_responsible_person,reason,module_time,register_time,register,check_tag,excel_tag) values ('"+manufacture_ID+"','"+rs1.getString("product_ID")+"','"+rs1.getString("product_name")+"','"+procedure_ID+"','"+procedure_name+"','"+procedure_responsible_person+"','"+reason+"','"+module_time+"','"+register_time+"','"+register+"','5','2')" ;
	manufacture_db.executeUpdate(sql) ;
	}
double cost_price_sum=0.0d;
for(int i=1;i<num;i++){
	String tem_product_name="product_name"+i;
	String tem_product_ID="product_ID"+i;
	String tem_product_describe="product_describe"+i;
	String tem_amount="amount"+i;
	String tem_amount_unit="amount_unit"+i;
	String tem_cost_price="cost_price"+i;
String product_name=request.getParameter(tem_product_name) ;
String product_ID=request.getParameter(tem_product_ID) ;
String product_describe=request.getParameter(tem_product_describe) ;
String amount=request.getParameter(tem_amount) ;
String amount_unit=request.getParameter(tem_amount_unit) ;
String cost_price2=request.getParameter(tem_cost_price) ;
StringTokenizer tokenTO3 = new StringTokenizer(cost_price2,",");
String cost_price="";
            while(tokenTO3.hasMoreTokens()) {
                String cost_price1 = tokenTO3.nextToken();
		cost_price +=cost_price1;
		}
	double subtotal=Double.parseDouble(cost_price)*Double.parseDouble(amount);
	cost_price_sum+=subtotal;
	String sql2 = "insert into manufacture_module_balance_details(manufacture_ID,procedure_name,details_number,product_ID,product_name,product_describe,amount,cost_price,amount_unit,subtotal,register_time,module_time) values ('"+manufacture_ID+"','"+procedure_name+"','"+i+"','"+product_ID+"','"+product_name+"','"+product_describe+"','"+amount+"','"+cost_price+"','"+amount_unit+"','"+subtotal+"','"+register_time+"','"+module_time+"')" ;
	manufacture_db.executeUpdate(sql2) ;
}
	String sql3 = "update manufacture_module_balance set module_cost_price_sum='"+cost_price_sum+"' where manufacture_ID='"+manufacture_ID+"' and module_time='"+module_time+"' and procedure_ID='"+procedure_ID+"'" ;
	manufacture_db.executeUpdate(sql3) ;

   
   response.sendRedirect("manufacture/module_balance/register_procedure_module_draft_ok.jsp?finished_tag=0");
	}else{
	
	response.sendRedirect("manufacture/module_balance/register_procedure_module_draft_ok.jsp?finished_tag=1");
	}
	manufacture_db.commit();
 
	manufacture_db.close();
	}else{
	response.sendRedirect("error_conn.htm");
}
	
}
catch (Exception ex){
ex.printStackTrace();
}
}
} 