/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package logistics.product_providers;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import java.text.*;
import include.nseer_cookie.*;
import validata.ValidataTag;

public class register_draft_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
try{
String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
time=formatter.format(now);
ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 logistics_db = new nseer_db_backup1(dbApplication);
if(logistics_db.conn((String)dbSession.getAttribute("unit_db_name"))){
ValidataTag vt=new ValidataTag();
String product_ID=request.getParameter("product_ID") ;
String product_name=exchange.unURL(request.getParameter("product_name")) ;
String chain_id=request.getParameter("chain_id") ;
String chain_name=request.getParameter("chain_name") ;
String register_time=request.getParameter("register_time") ;
String recommender=request.getParameter("recommender") ;
String register=request.getParameter("register") ;
String bodyc = new String(request.getParameter("recommend_describe").getBytes("UTF-8"),"UTF-8");
String recommend_describe=exchange.toHtml(bodyc);
String product_logistics_recommend_ID=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));
String[] provider_name=request.getParameterValues("provider_name") ;
String[] provider_ID=request.getParameterValues("provider_ID") ;
String[] provider_class=request.getParameterValues("provider_class") ;
String[] provider_web=request.getParameterValues("provider_web") ;
String[] provider_tel1=request.getParameterValues("provider_tel1") ;
String[] type=request.getParameterValues("type") ;
String[] contact_person1=request.getParameterValues("contact_person1") ;
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"design_file","product_ID",product_ID,"recommend_logistics_tag").equals("0")){
if(provider_ID.length>1){
try{
String sql3="update design_file set recommend_logistics_tag='1' where product_ID='"+product_ID+"'";
logistics_db.executeUpdate(sql3) ;
	String sql = "insert into logistics_product_providers_recommend(product_logistics_recommend_ID,chain_id,chain_name,product_ID,product_name,recommend_describe,register_time,recommender,register,check_tag,excel_tag) values ('"+product_logistics_recommend_ID+"','"+chain_id+"','"+chain_name+"','"+product_ID+"','"+product_name+"','"+recommend_describe+"','"+register_time+"','"+recommender+"','"+register+"','5','2')" ;
	logistics_db.executeUpdate(sql) ;
for(int i=1;i<provider_ID.length;i++){
	String sql1 = "insert into logistics_product_providers_recommend_details(product_logistics_recommend_ID,details_number,provider_ID,provider_name,provider_class,provider_tel,provider_web,type,contact_person) values ('"+product_logistics_recommend_ID+"','"+i+"','"+provider_ID[i]+"','"+provider_name[i]+"','"+provider_class[i]+"','"+provider_tel1[i]+"','"+provider_web[i]+"','"+type[i]+"','"+contact_person1[i]+"')" ;
	logistics_db.executeUpdate(sql1) ;
}
String provider_group="";
for(int i=1;i<provider_ID.length;i++){
String tem_provider_ID="provider_ID"+i;
String provider_ID1=request.getParameter(tem_provider_ID);
String tem_provider_name="provider_name"+i;
String provider_name1=request.getParameter(tem_provider_name);
String sql1="select * from logistics_file where provider_ID='"+provider_ID1+"'";
ResultSet rs1=logistics_db.executeQuery(sql1);
if(rs1.next()){
	String recommend_products=rs1.getString("recommend_products");
	if(rs1.getString("recommend_products").indexOf(product_name)==-1){
		recommend_products+=product_name+", ";
	}
String sql2="update logistics_file set recommend_products='"+recommend_products+"' where provider_ID='"+provider_ID1+"'";
logistics_db.executeUpdate(sql2) ;
}
provider_group=provider_group+provider_name1+", ";
}
 sql3="select * from design_file where product_ID='"+product_ID+"'";
ResultSet rs3=logistics_db.executeQuery(sql3);
if(rs3.next()){
String sql4="update design_file set provider_group='"+provider_group+"' where product_ID='"+product_ID+"'";
logistics_db.executeUpdate(sql4) ;
}	
}
catch (Exception ex){
ex.printStackTrace();
}
response.sendRedirect("logistics/product_providers/register_draft_ok.jsp?finished_tag=0");
}else{
response.sendRedirect("logistics/product_providers/register_draft_ok.jsp?finished_tag=1&&product_ID="+product_ID+"&&product_name="+toUtf8String.utf8String(exchange.toURL(product_name))+"");
	}
	}else{
	response.sendRedirect("logistics/product_providers/register_draft_ok.jsp?finished_tag=2");
	}
	logistics_db.commit();
	logistics_db.close();	
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
} 