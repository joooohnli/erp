/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package intrmanufacture.discussion;
 
 
import include.nseer_cookie.Data;
import include.nseer_cookie.GetWorkflow;
import include.nseer_cookie.NseerId;
import include.nseer_cookie.exchange;
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

public class dealwith_recommend_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
try{
String time1="";
java.util.Date now1 = new java.util.Date();
SimpleDateFormat formatter1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
time1=formatter1.format(now1);
ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 design_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 intrmanufacture_db = new nseer_db_backup1(dbApplication);
if(intrmanufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))&&design_db.conn((String)dbSession.getAttribute("unit_db_name"))){
ValidataTag vt=new ValidataTag();
String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
time=formatter.format(now);
String product_providers_recommend_ID="";
String discussion_ID=request.getParameter("discussion_ID") ;
String processer_ID=request.getParameter("processer_ID") ;
String processer=exchange.unURL(request.getParameter("processer")) ;
String product_ID=request.getParameter("product_ID") ;
String provider_ID=request.getParameter("provider_ID") ;
Data dt=new Data((String)dbSession.getAttribute("unit_db_name"),"design_file","product_ID",product_ID);
Data dt1=new Data((String)dbSession.getAttribute("unit_db_name"),"intrmanufacture_file","provider_ID",provider_ID);
String product_name=dt.getPara("product_name") ;
String chain_id=dt.getPara("chain_id");
String chain_name=dt.getPara("chain_name");
String register_time=time1 ;
String recommender=processer;
String register=processer ;
String recommend_describe="";  
String provider_name=dt1.getPara("provider_name") ;
String provider_class=dt1.getPara("provider_class") ;
String provider_web=dt1.getPara("provider_web") ;
String provider_tel1=dt1.getPara("provider_tel1") ;
String type=dt1.getPara("type") ;
String contact_person1=dt1.getPara("contact_person1") ;
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"design_file","product_ID",product_ID,"recommend_provider_tag").equals("0")){
try{
product_providers_recommend_ID=NseerId.getId("intrmanufacture/product_providers",(String)dbSession.getAttribute("unit_db_name"));
String sql3="update design_file set recommend_provider_tag='1' where product_ID='"+product_ID+"'";
design_db.executeUpdate(sql3) ;
	String sql = "insert into intrmanufacture_product_providers_recommend(product_providers_recommend_ID,chain_id,chain_name,product_ID,product_name,recommend_describe,register_time,recommender,register,check_tag,excel_tag) values ('"+product_providers_recommend_ID+"','"+chain_id+"','"+chain_name+"','"+product_ID+"','"+product_name+"','"+recommend_describe+"','"+register_time+"','"+recommender+"','"+register+"','0','2')" ;
	intrmanufacture_db.executeUpdate(sql) ;
	String sql1 = "insert into intrmanufacture_product_providers_recommend_details(product_providers_recommend_ID,details_number,provider_ID,provider_name,provider_class,provider_tel,provider_web,type,contact_person) values ('"+product_providers_recommend_ID+"','1','"+provider_ID+"','"+provider_name+"','"+provider_class+"','"+provider_tel1+"','"+provider_web+"','"+type+"','"+contact_person1+"')" ;
	intrmanufacture_db.executeUpdate(sql1) ;
	sql1 = "update intrmanufacture_discussion_details set dealwith_tag='1' where discussion_ID='"+discussion_ID+"' and product_ID='"+product_ID+"'" ;
	intrmanufacture_db.executeUpdate(sql1) ;

}
catch (Exception ex){
ex.printStackTrace();
}

List rsList = GetWorkflow.getList(intrmanufacture_db, "intrmanufacture_config_workflow", "03");
String sql="";
if(rsList.size()==0){
	sql="update intrmanufacture_product_providers_recommend set check_tag='1' where product_providers_recommend_ID='"+product_providers_recommend_ID+"'";
	intrmanufacture_db.executeUpdate(sql) ;
	String provider_group="";
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
String sql3="select * from design_file where product_ID='"+product_ID+"'";
ResultSet rs3=intrmanufacture_db.executeQuery(sql3);
if(rs3.next()){
String sql4="update design_file set provider_group='"+provider_group+"' where product_ID='"+product_ID+"'";
intrmanufacture_db.executeUpdate(sql4) ;
}
	}else{
	Iterator ite=rsList.iterator();
	while(ite.hasNext()){
		String[] elem=(String[])ite.next();
	sql = "insert into intrmanufacture_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+product_providers_recommend_ID+"','"+elem[1]+"','"+elem[2]+"')" ;
	intrmanufacture_db.executeUpdate(sql);
	}
}
	response.sendRedirect("intrmanufacture/discussion/dealwith.jsp?discussion_ID="+discussion_ID);

	}else{
String sqq="select * from intrmanufacture_product_providers_recommend where product_ID='"+product_ID+"' and (check_tag='1' or check_tag='0')";
ResultSet rs=intrmanufacture_db.executeQuery(sqq) ;
if(rs.next()){
	product_providers_recommend_ID=rs.getString("product_providers_recommend_id");
	sqq="select * from intrmanufacture_product_providers_recommend_details where product_providers_recommend_id='"+rs.getString("product_providers_recommend_id")+"' and provider_ID='"+provider_ID+"'";
	rs=intrmanufacture_db.executeQuery(sqq) ;
	if(rs.next()){
		String sql1 = "update intrmanufacture_discussion_details set dealwith_tag='1' where discussion_ID='"+discussion_ID+"' and product_ID='"+product_ID+"'" ;
	intrmanufacture_db.executeUpdate(sql1) ;


	}else{
		sqq="select * from intrmanufacture_product_providers_recommend_details where product_providers_recommend_id='"+product_providers_recommend_ID+"' order by details_number desc";
		rs=intrmanufacture_db.executeQuery(sqq) ;
		if(rs.next()){
			int details_number=rs.getInt("details_number")+1;
			String sql1 = "insert into intrmanufacture_product_providers_recommend_details(product_providers_recommend_ID,details_number,provider_ID,provider_name,provider_class,provider_tel,provider_web,type,contact_person) values ('"+product_providers_recommend_ID+"','"+details_number+"','"+provider_ID+"','"+provider_name+"','"+provider_class+"','"+provider_tel1+"','"+provider_web+"','"+type+"','"+contact_person1+"')" ;
			intrmanufacture_db.executeUpdate(sql1) ;
			sql1 = "update intrmanufacture_discussion_details set dealwith_tag='1' where discussion_ID='"+discussion_ID+"' and product_ID='"+product_ID+"'" ;
			intrmanufacture_db.executeUpdate(sql1) ;


		}
	}
	sqq = "update intrmanufacture_product_providers_recommend set change_time='"+time+"',changer='"+processer+"',recommender='"+recommender+"',check_tag='0',change_tag='1' where product_providers_recommend_ID='"+product_providers_recommend_ID+"'" ;
	intrmanufacture_db.executeUpdate(sqq) ;
}
String sql3="update design_file set recommend_provider_tag='1' where product_ID='"+product_ID+"'";
design_db.executeUpdate(sql3) ;

List rsList = GetWorkflow.getList(intrmanufacture_db, "intrmanufacture_config_workflow", "03");
String sql="";
String[] elem=new String[3];
if(rsList.size()==0){
	sql="update intrmanufacture_product_providers_recommend set check_tag='1' where product_providers_recommend_ID='"+product_providers_recommend_ID+"'";
	intrmanufacture_db.executeUpdate(sql);
}else{
    sql="delete from intrmanufacture_workflow where object_ID='"+product_providers_recommend_ID+"'";
	intrmanufacture_db.executeUpdate(sql) ;
	sql="update intrmanufacture_product_providers_recommend set check_tag='0' where product_providers_recommend_ID='"+product_providers_recommend_ID+"'";
	intrmanufacture_db.executeUpdate(sql) ;
	Iterator ite=rsList.iterator();
	while(ite.hasNext()){
	elem=(String[])ite.next();
	sql = "insert into intrmanufacture_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+product_providers_recommend_ID+"','"+elem[1]+"','"+elem[2]+"')" ;
	intrmanufacture_db.executeUpdate(sql) ;
	}
}
	response.sendRedirect("intrmanufacture/discussion/dealwith.jsp?discussion_ID="+discussion_ID);
	}
	intrmanufacture_db.commit();	
	design_db.commit();
	intrmanufacture_db.close();
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