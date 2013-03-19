/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package manufacture.apply;
 
 
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

public class register_draft_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 manufacture_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 crm_db = new nseer_db_backup1(dbApplication);
counter count=new counter(dbApplication);

try{
  if(manufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))&&stock_db.conn((String)dbSession.getAttribute("unit_db_name"))&&crm_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String[] product_ID=request.getParameterValues("product_ID");
String[] product_name=request.getParameterValues("product_name");
String[] product_describe=request.getParameterValues("product_describe");
String[] type=request.getParameterValues("type");
String[] amount=request.getParameterValues("amount");
String[] pay_ID_group=request.getParameterValues("pay_ID_group");
String designer=request.getParameter("designer");
String register=request.getParameter("register");
String register_time=request.getParameter("register_time") ;
String bodyb = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyb);

String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
time=formatter.format(now);


int n=0;
int m=0;
for(int i=0;i<product_ID.length;i++){
	StringTokenizer tokenTO1 = new StringTokenizer(pay_ID_group[i],", ");        
	while(tokenTO1.hasMoreTokens()) {
		
        String sql5="select * from stock_pay where manufacture_apply_tag='1' and pay_ID='"+tokenTO1.nextToken()+"'";
		ResultSet rs5=stock_db.executeQuery(sql5) ;
		if(rs5.next()){
			n++;
		}
		}

	if(Double.parseDouble(amount[i])!=0){
		m++;
	}
}
if(n==0){

if(m==0){
for(int i=0;i<product_ID.length;i++){
	StringTokenizer tokenTO = new StringTokenizer(pay_ID_group[i],", ");        
	while(tokenTO.hasMoreTokens()) {
		String sql2="select * from stock_pay where pay_ID='"+tokenTO.nextToken()+"'";
		ResultSet rs2=stock_db.executeQuery(sql2) ;
		if(rs2.next()){
			String sql3 = "update crm_order set manufacture_tag='2' where order_ID='"+rs2.getString("reasonexact")+"'" ;
			crm_db.executeUpdate(sql3) ;
        String sql4="update stock_pay set manufacture_apply_tag='1' where pay_ID='"+rs2.getString("pay_ID")+"'";
		stock_db.executeUpdate(sql4) ;
		}
	}
}
}else{
String apply_ID=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));
for(int i=0;i<product_ID.length;i++){
	if(Double.parseDouble(amount[i])!=0){
	StringTokenizer tokenTO = new StringTokenizer(pay_ID_group[i],", ");        
	while(tokenTO.hasMoreTokens()) {
		String sql2="select * from stock_pay where pay_ID='"+tokenTO.nextToken()+"'";
		ResultSet rs2=stock_db.executeQuery(sql2) ;
		if(rs2.next()){
			String sql3 = "update crm_order set manufacture_tag='2' where order_ID='"+rs2.getString("reasonexact")+"'" ;
			crm_db.executeUpdate(sql3) ;
		
        String sql4="update stock_pay set manufacture_apply_tag='1' where pay_ID='"+rs2.getString("pay_ID")+"'";
		stock_db.executeUpdate(sql4) ;
		}
		}
	}
}
stock_db.commit();

for(int i=0;i<product_ID.length;i++){
	if(Double.parseDouble(amount[i])!=0){
	String sql="insert into manufacture_apply(apply_ID,product_ID,product_name,product_describe,type,amount,pay_ID_group,designer,remark,register,register_time,check_tag) values('"+apply_ID+"','"+product_ID[i]+"','"+product_name[i]+"','"+product_describe[i]+"','"+type[i]+"','"+amount[i]+"','"+pay_ID_group[i]+"','"+designer+"','"+remark+"','"+register+"','"+register_time+"','5')";
	manufacture_db.executeUpdate(sql);
	}
}
}
String sql3 = "update manufacture_apply set check_tag='5' where product_ID='product_ID'" ;
manufacture_db.executeUpdate(sql3) ;
	
	response.sendRedirect("manufacture/apply/register_draft_ok.jsp?finished_tag=0");
}else{

	response.sendRedirect("manufacture/apply/register_draft_ok.jsp?finished_tag=1");
}
   
   manufacture_db.commit();
   crm_db.commit();

   crm_db.close();
   stock_db.close();
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