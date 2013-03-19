/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package purchase.apply;
 
 
import include.nseer_cookie.GetWorkflow;
import include.nseer_cookie.NseerId;
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

public class register_draft_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{
ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 purchase_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);

if(purchase_db.conn((String)dbSession.getAttribute("unit_db_name"))&&stock_db.conn((String)dbSession.getAttribute("unit_db_name"))){

counter count=new counter(dbApplication);
String apply_ID="";
String[] product_ID=request.getParameterValues("product_ID") ;
String[] product_name=request.getParameterValues("product_name") ;
String[] product_describe=request.getParameterValues("product_describe") ;
String[] amount=request.getParameterValues("amount") ;
String[] pay_ID_group=request.getParameterValues("pay_ID_group") ;
String designer=request.getParameter("designer") ;
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String bodyb = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyb);
double demand_amount=0.0d;
String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
time=formatter.format(now);


int n=0;
for(int i=0;i<product_ID.length;i++){
	StringTokenizer tokenTO1 = new StringTokenizer(pay_ID_group[i],", ");        
	while(tokenTO1.hasMoreTokens()) {
        String sql5="select * from stock_pay where purchase_apply_tag='1' and pay_ID='"+tokenTO1.nextToken()+"'";
		ResultSet rs5=stock_db.executeQuery(sql5) ;
		if(rs5.next()){
			n++;
		}
		}
	demand_amount+=Double.parseDouble(amount[i]);
}
if(n==0){
	if(demand_amount!=0){
for(int i=0;i<product_ID.length;i++){
	StringTokenizer tokenTO = new StringTokenizer(pay_ID_group[i],", ");        
	while(tokenTO.hasMoreTokens()) {
        String sql4="update stock_pay set purchase_apply_tag='1' where pay_ID='"+tokenTO.nextToken()+"'";
		stock_db.executeUpdate(sql4) ;
		}	
}
apply_ID=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));

for(int i=0;i<product_ID.length;i++){
	String sql="insert into purchase_apply(apply_ID,product_ID,product_name,product_describe,amount,pay_ID_group,designer,remark,register,register_time,check_tag) values('"+apply_ID+"','"+product_ID[i]+"','"+product_name[i]+"','"+product_describe[i]+"','"+amount[i]+"','"+pay_ID_group[i]+"','"+designer+"','"+remark+"','"+register+"','"+register_time+"','5')";
	purchase_db.executeUpdate(sql);
}
	
	response.sendRedirect("purchase/apply/register_draft_ok.jsp?finished_tag=0");
	}else{
for(int i=0;i<product_ID.length;i++){
	StringTokenizer tokenTO = new StringTokenizer(pay_ID_group[i],", ");        
	while(tokenTO.hasMoreTokens()) {
        String sql4="update stock_pay set purchase_apply_tag='1' where pay_ID='"+tokenTO.nextToken()+"'";
		stock_db.executeUpdate(sql4) ;
		}
}
String mod=request.getRequestURI();
int filenum=count.readTime((String)dbSession.getAttribute("unit_db_name"),mod);
count.writeTime((String)dbSession.getAttribute("unit_db_name"),mod);

mod=mod.substring(mod.lastIndexOf("/")+1);
StringTokenizer tokenTOO = new StringTokenizer(mod,"_");

String sqla="";
String main_kind1="";
String first_kind1="";
if (tokenTOO.hasMoreTokens()) {
			main_kind1 = tokenTOO.nextToken();
			first_kind1 = tokenTOO.nextToken();
			
	 }
		sqla="select * from document_first where main_kind_name='"+main_kind1+"' and first_kind_name='"+first_kind1+"' ";

String main_code="";
String first_code="";
String second_code="";
ResultSet rsa=purchase_db.executeQuery(sqla) ;
if(rsa.next()){
main_code=rsa.getString("main_code");
first_code=rsa.getString("first_code");
second_code=rsa.getString("second_code");
}
 apply_ID=main_code+first_code+second_code;

 apply_ID=apply_ID+time+filenum;
for(int i=0;i<product_ID.length;i++){
	String sql="insert into purchase_apply(apply_ID,product_ID,product_name,product_describe,amount,pay_ID_group,designer,remark,register,register_time,check_tag) values('"+apply_ID+"','"+product_ID[i]+"','"+product_name[i]+"','"+product_describe[i]+"','"+amount[i]+"','"+pay_ID_group[i]+"','"+designer+"','"+remark+"','"+register+"','"+register_time+"','5')";
	purchase_db.executeUpdate(sql);
}
	
response.sendRedirect("purchase/apply/register_draft_ok.jsp?finished_tag=1");
}

}else{
	
response.sendRedirect("purchase/apply/register_draft_ok.jsp?finished_tag=2");
}
    stock_db.commit();
	purchase_db.commit();
stock_db.close();
	purchase_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}

}
catch (Exception ex){
ex.printStackTrace();
}
}
} 