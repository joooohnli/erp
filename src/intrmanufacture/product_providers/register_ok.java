/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package intrmanufacture.product_providers;
  
import include.nseer_cookie.NseerId;
import include.nseer_cookie.exchange;
import include.nseer_cookie.toUtf8String;
import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

import validata.ValidataTag;

public class register_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 intrmanufacture_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 design_db = new nseer_db_backup1(dbApplication);
ValidataTag vt=new ValidataTag();
try{
if(intrmanufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))&&design_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
time=formatter.format(now);
String product_ID=request.getParameter("product_ID") ;
String product_name=request.getParameter("product_name") ;
String chain_id=request.getParameter("chain_id") ;
String chain_name=request.getParameter("chain_name") ;
String register_time=request.getParameter("register_time") ;
String recommender=request.getParameter("recommender") ;
String register=request.getParameter("register") ;
String bodyc = new String(request.getParameter("recommend_describe").getBytes("UTF-8"),"UTF-8");
String recommend_describe=exchange.toHtml(bodyc);
String  product_providers_recommend_ID=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));
String[] provider_name=request.getParameterValues("provider_name") ;
String[] provider_ID=request.getParameterValues("provider_ID") ;
String[] provider_class=request.getParameterValues("provider_class") ;
String[] provider_web=request.getParameterValues("provider_web") ;
String[] provider_tel1=request.getParameterValues("provider_tel1") ;
String[] type=request.getParameterValues("type") ;
String[] contact_person1=request.getParameterValues("contact_person1") ;
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"design_file","product_ID",product_ID,"recommend_provider_tag").equals("0")){
if(provider_ID.length>1){
try{
int m=0;
String sql3="update design_file set recommend_provider_tag='1' where product_ID='"+product_ID+"'";
design_db.executeUpdate(sql3) ;
	String sql = "insert into intrmanufacture_product_providers_recommend(product_providers_recommend_ID,chain_id,chain_name,product_ID,product_name,recommend_describe,register_time,recommender,register,check_tag,excel_tag) values ('"+product_providers_recommend_ID+"','"+chain_id+"','"+chain_name+"','"+product_ID+"','"+product_name+"','"+recommend_describe+"','"+register_time+"','"+recommender+"','"+register+"','0','2')" ;
	intrmanufacture_db.executeUpdate(sql) ;
for(int i=1;i<provider_ID.length;i++){
	String sql1 = "insert into intrmanufacture_product_providers_recommend_details(product_providers_recommend_ID,details_number,provider_ID,provider_name,provider_class,provider_tel,provider_web,type,contact_person) values ('"+product_providers_recommend_ID+"','"+i+"','"+provider_ID[i]+"','"+provider_name[i]+"','"+provider_class[i]+"','"+provider_tel1[i]+"','"+provider_web[i]+"','"+type[i]+"','"+contact_person1[i]+"')";
	intrmanufacture_db.executeUpdate(sql1) ;
	m++;
	}
	List rsList = (List)new java.util.ArrayList();
	String[] elem=new String[3];
	sql="select id,describe1,describe2 from intrmanufacture_config_workflow where type_id='03'";
	ResultSet rset=intrmanufacture_db.executeQuery(sql);
	while(rset.next()){
		elem=new String[3];
		elem[0]=rset.getString("id");
		elem[1]=rset.getString("describe1");
		elem[2]=rset.getString("describe2");
		rsList.add(elem);
	}
	if(rsList.size()==0){
		sql="update intrmanufacture_product_providers_recommend set check_tag='1' where product_providers_recommend_ID='"+product_providers_recommend_ID+"'";
		intrmanufacture_db.executeUpdate(sql) ;
String provider_group="";
for(int i=1;i<=m-1;i++){
String tem_provider_ID="provider_ID"+i;
String provider_ID1=request.getParameter(tem_provider_ID);
String tem_provider_name="provider_name"+i;
String provider_name1=request.getParameter(tem_provider_name);
String sql1="select * from intrmanufacture_file where provider_ID='"+provider_ID1+"'";
ResultSet rs1=intrmanufacture_db.executeQuery(sql1);
if(rs1.next()){
	String recommend_products=rs1.getString("recommend_products");
	if(rs1.getString("recommend_products").indexOf(provider_name1)==-1){
		recommend_products+=provider_name1+", ";
	}
String sql2="update intrmanufacture_file set recommend_products='"+recommend_products+"' where provider_ID='"+provider_ID+"'";
intrmanufacture_db.executeUpdate(sql2) ;
}
provider_group=provider_group+provider_name1+", ";
}
	sql3="select * from design_file where product_ID='"+product_ID+"'";
ResultSet rs3=design_db.executeQuery(sql3);
if(rs3.next()){
String sql4="update design_file set provider_group='"+provider_group+"' where product_ID='"+product_ID+"'";
design_db.executeUpdate(sql4) ;
}
		}else{
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		elem=(String[])ite.next();
		sql = "insert into intrmanufacture_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+product_providers_recommend_ID+"','"+elem[1]+"','"+elem[2]+"')" ;
		intrmanufacture_db.executeUpdate(sql);
		}
	}
}
catch (Exception ex){
ex.printStackTrace();
}
	response.sendRedirect("intrmanufacture/product_providers/register_ok_a.jsp");
	}else{
	response.sendRedirect("intrmanufacture/product_providers/register_ok_b.jsp?product_ID="+product_ID+"&&product_name="+toUtf8String.utf8String(exchange.toURL(product_name))+"");
}
	}else{		
	response.sendRedirect("intrmanufacture/product_providers/register_ok_c.jsp");
	}
	design_db.commit();
	intrmanufacture_db.commit();
	design_db.close();
	intrmanufacture_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
} 