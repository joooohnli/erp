/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package design.design;

import include.nseer_cookie.counter;
import include.nseer_cookie.exchange;
import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.sql.ResultSet;
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
import validata.ValidataTag;

public class check_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 design_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 manufacture_db = new nseer_db_backup1(dbApplication);
ValidataNumber validata=new ValidataNumber();
ValidataTag vt=new ValidataTag();
counter count=new counter(dbApplication);
try{
if(design_db.conn((String)dbSession.getAttribute("unit_db_name"))&&manufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))){

String id=request.getParameter("id") ;
String config_id=request.getParameter("config_id");
String product_amount=request.getParameter("product_amount") ;
int num=Integer.parseInt(product_amount);
String design_ID=request.getParameter("design_ID") ;
String product_IDa=request.getParameter("product_IDa") ;
String product_namea=request.getParameter("product_namea") ;
String designer=request.getParameter("designer") ;
String bodyc = new String(request.getParameter("module_describe").getBytes("UTF-8"),"UTF-8");
String module_describe=exchange.toHtml(bodyc);
String check_time=request.getParameter("check_time") ;
String checker=request.getParameter("checker") ;
String checker_ID=request.getParameter("checker_ID") ;
String sql11 = "select * from design_module_details where design_ID='"+design_ID+"'";
ResultSet rss = design_db.executeQuery(sql11) ;
if(rss.next()){
int n=0;
for(int i=1;i<=num;i++){
	String tem_amount="amount"+i;
String amount=request.getParameter(tem_amount) ;
		if(!validata.validata(amount)){
			n++;
		}
}
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"design_module","design_ID",design_ID,"check_tag").equals("0")){
if(n==0){
try{
	String sql = "update design_module set design_ID='"+design_ID+"',product_ID='"+product_IDa+"',product_name='"+product_namea+"',check_time='"+check_time+"',checker='"+checker+"',designer='"+designer+"',module_describe='"+module_describe+"' where design_ID='"+design_ID+"'" ;
	design_db.executeUpdate(sql) ;
double cost_price_sum=0.0d;
for(int i=1;i<=num;i++){
	String tem_product_name="product_name"+i;
	String tem_product_ID="product_ID"+i;
	String tem_type="type"+i;
	String tem_product_describe="product_describe"+i;
	String tem_amount="amount"+i;
	String tem_amount_unit="amount_unit"+i;
	String tem_cost_price="cost_price"+i;
String product_name=request.getParameter(tem_product_name) ;
String product_ID=request.getParameter(tem_product_ID) ;
String type=request.getParameter(tem_type) ;
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
	String sql1 = "update design_module_details set product_ID='"+product_ID+"',product_name='"+product_name+"',product_describe='"+product_describe+"',type='"+type+"',amount='"+amount+"',design_balance_amount='"+amount+"',cost_price='"+cost_price+"',amount_unit='"+amount_unit+"',subtotal='"+subtotal+"' where design_ID='"+design_ID+"' and details_number='"+i+"'" ;
	design_db.executeUpdate(sql1) ;
}

sql = "update design_workflow set checker='"+checker+"',checker_ID='"+checker_ID+"',check_time='"+check_time+"',check_tag='1' where object_ID='"+design_ID+"' and config_id='"+config_id+"' and type_id='03'" ;
	design_db.executeUpdate(sql);
	sql="select id from design_workflow where object_ID='"+design_ID+"' and check_tag='0' and type_id='03'";
	ResultSet rset=design_db.executeQuery(sql);
    
	if(!rset.next()){
    
String sql2="update design_module set cost_price_sum='"+cost_price_sum+"',check_tag='1',change_tag='0' where design_ID='"+design_ID+"'";
design_db.executeUpdate(sql2) ;
String procedure_design_ID="";
String sql3="select * from manufacture_design_procedure where product_ID='"+product_IDa+"' and check_tag='1' and excel_tag='2'";
ResultSet rs3=manufacture_db.executeQuery(sql3);
if(rs3.next()){
	procedure_design_ID=rs3.getString("design_ID");
}
String sql4="update manufacture_design_procedure set design_module_tag='0' where product_ID='"+product_IDa+"' and check_tag='1' and excel_tag='2'";
manufacture_db.executeUpdate(sql4);
String sql5="update manufacture_design_procedure_details set design_module_tag='0' where design_ID='"+procedure_design_ID+"'";
manufacture_db.executeUpdate(sql5) ;
String sql6="delete from manufacture_design_procedure_module_details where design_ID='"+procedure_design_ID+"'";
manufacture_db.executeUpdate(sql6);
sql6="delete from manufacture_workflow where object_id='"+procedure_design_ID+"' and type_id='02'";
manufacture_db.executeUpdate(sql6);
	}else{
String sql2="update design_module set cost_price_sum='"+cost_price_sum+"' where design_ID='"+design_ID+"'";


}
}
catch (Exception ex){
ex.printStackTrace();
}
response.sendRedirect("design/design/check_ok_a.jsp");
}else{
	
	response.sendRedirect("design/design/check_ok_b.jsp?design_ID="+design_ID);
	}
}else{
	
response.sendRedirect("design/design/check_ok_c.jsp");
}
}else{
	
response.sendRedirect("design/design/check_ok_d.jsp?design_ID="+design_ID);
}
design_db.commit();
manufacture_db.commit();
manufacture_db.close();
design_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}