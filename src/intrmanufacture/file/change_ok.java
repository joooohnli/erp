/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package intrmanufacture.file;

import include.get_sql.getInsertSql;
import include.nseer_cookie.Divide1;
import include.nseer_cookie.counter;
import include.nseer_cookie.exchange;
import include.nseer_db.nseer_db_backup1;
import include.operateDB.CdefineUpdate;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
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
public class change_ok extends HttpServlet{
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

if(intrmanufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))){

counter count=new counter(dbApplication);
getInsertSql getInsertSql= new getInsertSql();
ValidataTag  vt= new ValidataTag();
ResultSet rset=null;
String id=request.getParameter("id");
String intrmanufacturer=request.getParameter("intrmanufacturer");
String intrmanufacturer_ID=request.getParameter("intrmanufacturer_ID");
String provider_ID=request.getParameter("provider_ID") ;
String provider_name=request.getParameter("provider_name") ;
String provider_address=request.getParameter("provider_address") ;
String type=request.getParameter("type") ;
String provider_class=request.getParameter("class") ;
String used_provider_name=request.getParameter("used_provider_name") ;
String provider_bank=request.getParameter("provider_bank") ;
String provider_account=request.getParameter("provider_account") ;
String provider_web=request.getParameter("provider_web") ;
String provider_tel1=request.getParameter("provider_tel1") ;
String provider_fax=request.getParameter("provider_fax") ;
String provider_postcode=request.getParameter("provider_postcode") ;
String contact_person1=request.getParameter("contact_person1") ;
String contact_person1_department=request.getParameter("contact_person1_department") ;
String contact_person1_duty=request.getParameter("contact_person1_duty") ;
String contact_person1_sex = request.getParameter("contact_person1_sex") ;
String contact_person1_office_tel=request.getParameter("contact_person1_office_tel") ;
String contact_person1_home_tel=request.getParameter("contact_person1_home_tel") ;
String contact_person1_mobile=request.getParameter("contact_person1_mobile") ;
String contact_person1_email=request.getParameter("contact_person1_email") ;
String contact_person2=request.getParameter("contact_person2") ;
String contact_person2_department=request.getParameter("contact_person2_department") ;
String contact_person2_duty=request.getParameter("contact_person2_duty") ;
String contact_person2_sex = request.getParameter("contact_person2_sex") ;
String contact_person2_office_tel=request.getParameter("contact_person2_office_tel") ;
String contact_person2_home_tel=request.getParameter("contact_person2_home_tel") ;
String contact_person2_mobile=request.getParameter("contact_person2_mobile") ;
String contact_person2_email=request.getParameter("contact_person2_email") ;
String changer_ID=request.getParameter("changer_ID") ;
String changer=request.getParameter("changer") ;
String change_time=request.getParameter("change_time") ;
String kind_chain=request.getParameter("kind_chain");
String chain_id=Divide1.getId(kind_chain);
String chain_name=Divide1.getName(kind_chain);
String lately_change_time=request.getParameter("lately_change_time") ;
String file_change_amount=request.getParameter("file_change_amount") ;
int change_amount=Integer.parseInt(file_change_amount)+1;
String bodyc = new String(request.getParameter("invoice_info").getBytes("UTF-8"),"UTF-8");
String invoice_info=exchange.toHtml(bodyc);
String bodya = new String(request.getParameter("demand_products").getBytes("UTF-8"),"UTF-8");
String demand_products=exchange.toHtml(bodya);
String bodyb = new String(request.getParameter("recommend_products").getBytes("UTF-8"),"UTF-8");
String recommend_products=exchange.toHtml(bodyb);
String column_group=getInsertSql.sql((String)dbSession.getAttribute("unit_db_name"),"intrmanufacture_file");
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"intrmanufacture_file","id",id,"check_tag").equals("1")){
try{
	String sqll="insert into intrmanufacture_file_dig("+column_group+") select "+column_group+" from intrmanufacture_file where id='"+id+"'";
	intrmanufacture_db.executeUpdate(sqll) ;
	String sql = "update intrmanufacture_file set chain_id='"+chain_id+"',chain_name='"+chain_name+"',provider_name='"+provider_name+"',provider_address='"+provider_address+"',provider_class='"+provider_class+"',type='"+type+"',provider_bank='"+provider_bank+"',provider_account='"+provider_account+"',provider_web='"+provider_web+"',provider_tel1='"+provider_tel1+"',provider_fax='"+provider_fax+"',provider_postcode='"+provider_postcode+"',used_provider_name='"+used_provider_name+"',contact_person1='"+contact_person1+"',contact_person1_department='"+contact_person1_department+"',contact_person1_duty='"+contact_person1_duty+"',contact_person1_sex='"+contact_person1_sex+"',contact_person1_office_tel='"+contact_person1_office_tel+"',contact_person1_home_tel='"+contact_person1_home_tel+"',contact_person1_mobile='"+contact_person1_mobile+"',contact_person1_email='"+contact_person1_email+"',contact_person2='"+contact_person2+"',contact_person2_department='"+contact_person2_department+"',contact_person2_duty='"+contact_person2_duty+"',contact_person2_sex='"+contact_person2_sex+"',contact_person2_office_tel='"+contact_person2_office_tel+"',contact_person2_home_tel='"+contact_person2_home_tel+"',contact_person2_mobile='"+contact_person2_mobile+"',contact_person2_email='"+contact_person2_email+"',changer_ID='"+changer_ID+"',changer='"+changer+"',invoice_info='"+invoice_info+"',demand_products='"+demand_products+"',recommend_products='"+recommend_products+"',change_time='"+change_time+"',lately_change_time='"+lately_change_time+"',file_change_amount='"+change_amount+"',intrmanufacturer='"+intrmanufacturer+"',intrmanufacturer_ID='"+intrmanufacturer_ID+"',check_tag='0' where provider_ID='"+provider_ID+"'" ;
	intrmanufacture_db.executeUpdate(sql) ;
	/*****************************************************/
		CdefineUpdate CdefineUpdate=new CdefineUpdate();
		sql=CdefineUpdate.update("intrmanufacture_file","provider_ID",provider_ID,request);
		intrmanufacture_db.executeUpdate(sql) ;
		/*****************************************************/
	sql="delete from intrmanufacture_workflow where object_id='"+provider_ID+"'";
	intrmanufacture_db.executeUpdate(sql) ;

	List rsList = (List)new java.util.ArrayList();
	String[] elem=new String[3];
	sql="select id,describe1,describe2 from intrmanufacture_config_workflow where type_id='01'";
	rset=intrmanufacture_db.executeQuery(sql);
	while(rset.next()){
		elem=new String[3];
		elem[0]=rset.getString("id");
		elem[1]=rset.getString("describe1");
		elem[2]=rset.getString("describe2");
		rsList.add(elem);
	}
	if(rsList.size()==0){
		sql="update intrmanufacture_file set check_tag='1' where provider_ID='"+provider_ID+"'";
		intrmanufacture_db.executeUpdate(sql) ;
	}else{
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		elem=(String[])ite.next();
		sql = "insert into intrmanufacture_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+provider_ID+"','"+elem[1]+"','"+elem[2]+"')" ;
		intrmanufacture_db.executeUpdate(sql) ;
		}
	}	
}
catch (Exception ex){
ex.printStackTrace();
}
	response.sendRedirect("intrmanufacture/file/change_choose_attachment.jsp?provider_ID="+provider_ID);
}else{

response.sendRedirect("intrmanufacture/file/change_ok_a.jsp");
}
intrmanufacture_db.commit();
intrmanufacture_db.close();


}
else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}




