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

import include.nseer_cookie.counter;
import include.nseer_cookie.exchange;
import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.sql.ResultSet;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

import validata.ValidataTag;

public class check_ok extends HttpServlet{

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
counter count=new counter(dbApplication);

try{

if(intrmanufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))&&design_db.conn((String)dbSession.getAttribute("unit_db_name"))){

String product_providers_recommend_ID=request.getParameter("product_providers_recommend_ID") ;
String recommender=request.getParameter("recommender") ;
String bodyc = new String(request.getParameter("recommend_describe").getBytes("UTF-8"),"UTF-8");
String recommend_describe=exchange.toHtml(bodyc);
String check_time=request.getParameter("check_time") ;
String checker=request.getParameter("checker") ;
String checker_ID=request.getParameter("checker_ID") ;
String product_name=request.getParameter("product_name") ;
String product_ID=request.getParameter("product_ID") ;
String config_id=request.getParameter("config_id") ;
String provider_amount=request.getParameter("provider_amount") ;

String sql6="select id from intrmanufacture_workflow where object_ID='"+product_providers_recommend_ID+"' and ((check_tag='0' and config_id<'"+config_id+"') or (check_tag='1' and config_id='"+config_id+"'))";
ResultSet rs6=intrmanufacture_db.executeQuery(sql6);
if(!rs6.next()){
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"intrmanufacture_product_providers_recommend","product_providers_recommend_ID",product_providers_recommend_ID,"check_tag").equals("0")){
try{
String sql = "update intrmanufacture_product_providers_recommend set check_time='"+check_time+"',checker='"+checker+"',recommender='"+recommender+"',recommend_describe='"+recommend_describe+"',change_tag='0' where product_providers_recommend_ID='"+product_providers_recommend_ID+"'" ;
	intrmanufacture_db.executeUpdate(sql) ;
	String provider_group="";
for(int i=1;i<=Integer.parseInt(provider_amount);i++){
String tem_provider_ID="provider_ID"+i;
String provider_ID=request.getParameter(tem_provider_ID);
String tem_provider_name="provider_name"+i;
String provider_name=request.getParameter(tem_provider_name);
String sql1="select * from intrmanufacture_file where provider_ID='"+provider_ID+"'";
ResultSet rs1=intrmanufacture_db.executeQuery(sql1);
if(rs1.next()){
	String recommend_products=rs1.getString("recommend_products");
	if(rs1.getString("recommend_products").indexOf(product_name)==-1){
		recommend_products+=product_name+", ";
	}
String sql2="update intrmanufacture_file set recommend_products='"+recommend_products+"' where provider_ID='"+provider_ID+"'";
intrmanufacture_db.executeUpdate(sql2) ;
}

provider_group=provider_group+provider_name+", ";
}
String sql3="select * from design_file where product_ID='"+product_ID+"'";
ResultSet rs3=design_db.executeQuery(sql3);
if(rs3.next()){
String sql4="update design_file set provider_group='"+provider_group+"' where product_ID='"+product_ID+"'";
design_db.executeUpdate(sql4) ;
}
	
String sql9 = "update intrmanufacture_workflow set checker='"+checker+"',checker_ID='"+checker_ID+"',check_time='"+check_time+"',check_tag='1' where object_ID='"+product_providers_recommend_ID+"' and config_id='"+config_id+"'" ;
	intrmanufacture_db.executeUpdate(sql9);
	sql9="select id from intrmanufacture_workflow where object_ID='"+product_providers_recommend_ID+"' and check_tag='0'";
	ResultSet rset=intrmanufacture_db.executeQuery(sql9);
	if(!rset.next()){
		sql9="update intrmanufacture_product_providers_recommend set recommender='"+recommender+"',check_tag='1' where product_providers_recommend_ID='"+product_providers_recommend_ID+"'";
		intrmanufacture_db.executeUpdate(sql9);
	}else{
		sql9="update intrmanufacture_product_providers_recommend set recommender='"+recommender+"' where product_providers_recommend_ID='"+product_providers_recommend_ID+"'";
		intrmanufacture_db.executeUpdate(sql9);
	}

}
catch (Exception ex){
ex.printStackTrace();
}
	response.sendRedirect("intrmanufacture/product_providers/check_ok_a.jsp");
	}else{
	response.sendRedirect("intrmanufacture/product_providers/check_ok_b.jsp");
}
}else{
	response.sendRedirect("intrmanufacture/product_providers/check_ok.jsp?finished_tag=2");
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