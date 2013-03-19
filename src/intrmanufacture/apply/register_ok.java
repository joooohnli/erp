/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package intrmanufacture.apply;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.* ;
import java.util.* ;
import java.io.*;
import include.nseer_cookie.exchange;
import include.nseer_db.*;
import include.nseer_cookie.counter;

public class register_ok extends HttpServlet{
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

if(intrmanufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))&&stock_db.conn((String)dbSession.getAttribute("unit_db_name"))){

counter count= new  counter(dbApplication);

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
int n=0;
for(int i=0;i<product_ID.length;i++){
	StringTokenizer tokenTO1 = new StringTokenizer(pay_ID_group[i],", ");        
	while(tokenTO1.hasMoreTokens()) {
        String sql5="select * from stock_pay where intrmanufacture_apply_tag='1' and pay_ID='"+tokenTO1.nextToken()+"'";
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
        String sql4="update stock_pay set intrmanufacture_apply_tag='1' where pay_ID='"+tokenTO.nextToken()+"'";
		stock_db.executeUpdate(sql4) ;
		}	
}
int apply_ID=count.read((String)dbSession.getAttribute("unit_db_name"),"intrmanufactureapplycount");
count.write((String)dbSession.getAttribute("unit_db_name"),"intrmanufactureapplycount",apply_ID);
try{
for(int i=0;i<product_ID.length;i++){
	String sql="insert into intrmanufacture_apply(apply_ID,product_ID,product_name,product_describe,amount,pay_ID_group,designer,remark,register,register_time) values('"+apply_ID+"','"+product_ID[i]+"','"+product_name[i]+"','"+product_describe[i]+"','"+amount[i]+"','"+pay_ID_group[i]+"','"+designer+"','"+remark+"','"+register+"','"+register_time+"')";
	intrmanufacture_db.executeUpdate(sql);
}
	
}
catch (Exception ex){
out.println("error"+ex);
}

response.sendRedirect("intrmanufacture/apply/register_ok_a.jsp");

}else{
for(int i=0;i<product_ID.length;i++){
	StringTokenizer tokenTO = new StringTokenizer(pay_ID_group[i],", ");        
	while(tokenTO.hasMoreTokens()) {
        String sql4="update stock_pay set intrmanufacture_apply_tag='1' where pay_ID='"+tokenTO.nextToken()+"'";
		stock_db.executeUpdate(sql4) ;
		}
}
int apply_ID=count.read((String)dbSession.getAttribute("unit_db_name"),"intrmanufactureapplycount");
count.write((String)dbSession.getAttribute("unit_db_name"),"intrmanufactureapplycount",apply_ID);
try{
for(int i=0;i<product_ID.length;i++){
	String sql="insert into intrmanufacture_apply(apply_ID,product_ID,product_name,product_describe,amount,pay_ID_group,designer,remark,register,register_time) values('"+apply_ID+"','"+product_ID[i]+"','"+product_name[i]+"','"+product_describe[i]+"','"+amount[i]+"','"+pay_ID_group[i]+"','"+designer+"','"+remark+"','"+register+"','"+register_time+"')";
	intrmanufacture_db.executeUpdate(sql);
}
	
}
catch (Exception ex){
out.println("error"+ex);
}	
response.sendRedirect("intrmanufacture/apply/register_ok_b.jsp");

}}else{
	
response.sendRedirect("intrmanufacture/apply/register_ok_c.jsp");
}
stock_db.commit();
intrmanufacture_db.commit();
stock_db.close();
	intrmanufacture_db.close();


}
else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}