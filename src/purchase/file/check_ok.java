/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package purchase.file;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.*;
import validata.ValidataTag;
import include.operateDB.CdefineUpdate;

public class check_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
try{

ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 design_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 purchase_db = new nseer_db_backup1(dbApplication);

if(purchase_db.conn((String)dbSession.getAttribute("unit_db_name"))&&design_db.conn((String)dbSession.getAttribute("unit_db_name"))){

counter count=new counter(dbApplication);
ValidataTag vt=new ValidataTag();

String provider_ID=request.getParameter("provider_ID");
String config_id=request.getParameter("config_id");
String kind_chain=request.getParameter("fileKind_chain");
String chain_id=Divide1.getId(kind_chain);
String chain_name=Divide1.getName(kind_chain);
String purchaser=request.getParameter("purchaser");
String purchaser_ID=request.getParameter("purchaser_ID");
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
String checker=request.getParameter("checker") ;
String check_time=request.getParameter("check_time") ;
String checker_ID=request.getParameter("checker_ID") ;
String bodyc = new String(request.getParameter("invoice_info").getBytes("UTF-8"),"UTF-8");
String invoice_info=exchange.toHtml(bodyc);
String bodya = new String(request.getParameter("demand_products").getBytes("UTF-8"),"UTF-8");
String demand_products=exchange.toHtml(bodya);
String bodyb = new String(request.getParameter("recommend_products").getBytes("UTF-8"),"UTF-8");
String recommend_products=exchange.toHtml(bodyb);
if(!vt.validata((String)dbSession.getAttribute("unit_db_name"),"purchase_file","provider_ID",provider_ID,"check_tag").equals("1")){

if(provider_ID==null||provider_ID.equals("")){//为EXCEL导入作准备地
 provider_ID=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));
}
try{
	String sql = "update purchase_file set chain_id='"+chain_id+"',chain_name='"+chain_name+"',provider_ID='"+provider_ID+"',provider_name='"+provider_name+"',provider_address='"+provider_address+"',provider_class='"+provider_class+"',type='"+type+"',provider_bank='"+provider_bank+"',provider_account='"+provider_account+"',provider_web='"+provider_web+"',provider_tel1='"+provider_tel1+"',provider_fax='"+provider_fax+"',provider_postcode='"+provider_postcode+"',used_provider_name='"+used_provider_name+"',contact_person1='"+contact_person1+"',contact_person1_department='"+contact_person1_department+"',contact_person1_duty='"+contact_person1_duty+"',contact_person1_sex='"+contact_person1_sex+"',contact_person1_office_tel='"+contact_person1_office_tel+"',contact_person1_home_tel='"+contact_person1_home_tel+"',contact_person1_mobile='"+contact_person1_mobile+"',contact_person1_email='"+contact_person1_email+"',contact_person2='"+contact_person2+"',contact_person2_department='"+contact_person2_department+"',contact_person2_duty='"+contact_person2_duty+"',contact_person2_sex='"+contact_person2_sex+"',contact_person2_office_tel='"+contact_person2_office_tel+"',contact_person2_home_tel='"+contact_person2_home_tel+"',contact_person2_mobile='"+contact_person2_mobile+"',contact_person2_email='"+contact_person2_email+"',invoice_info='"+invoice_info+"',demand_products='"+demand_products+"',recommend_products='"+recommend_products+"',checker='"+checker+"',check_time='"+check_time+"',purchaser='"+purchaser+"',purchaser_ID='"+purchaser_ID+"' where provider_ID='"+provider_ID+"'";
	purchase_db.executeUpdate(sql) ;
	/*****************************************************/
	CdefineUpdate CdefineUpdate=new CdefineUpdate();
	sql=CdefineUpdate.update("purchase_file","provider_ID",provider_ID,request);
	purchase_db.executeUpdate(sql) ;
	/*****************************************************/

    sql = "update purchase_workflow set checker='"+checker+"',checker_ID='"+checker_ID+"',check_time='"+check_time+"',check_tag='1' where object_ID='"+provider_ID+"' and config_id='"+config_id+"'" ;
	purchase_db.executeUpdate(sql) ;

    sql="select id from purchase_workflow where object_ID='"+provider_ID+"' and check_tag='0'";
	ResultSet rset=purchase_db.executeQuery(sql) ;
	if(!rset.next()){
		sql="update purchase_file set check_tag='1' where provider_ID='"+provider_ID+"'";
		purchase_db.executeUpdate(sql) ;
	}

}catch (Exception ex){
ex.printStackTrace();
}
response.sendRedirect("purchase/file/check_choose_attachment.jsp?provider_ID="+provider_ID+"");
}else{
	response.sendRedirect("purchase/file/check_ok_a.jsp");
	}
	purchase_db.commit();	
	design_db.commit();	
	purchase_db.close();
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