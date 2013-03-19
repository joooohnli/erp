/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package crm.contact;


import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.io.*;
import include.nseer_db.*;
import include.auto_execute.ContactExpiry;
import validata.ValidataTag;

public class check_ok extends HttpServlet{
ServletContext application;
HttpSession session;
nseer_db_backup1 erp_db = null;
public synchronized void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


	try{
//实例化
nseer_db_backup1 crm_db = new nseer_db_backup1(dbApplication);
ContactExpiry contactExpiry= new ContactExpiry();
ValidataTag   vt= new ValidataTag();
if(crm_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String config_id=request.getParameter("config_id");
String contact_ID=request.getParameter("contact_ID") ;
String reason=request.getParameter("reason");
String reasonexact=request.getParameter("reasonexact") ;
String customer_ID=request.getParameter("customer_ID") ;
String customer_name=request.getParameter("customer_name") ;
String person_contacted=request.getParameter("person_contacted") ;
String person_contacted_tel=request.getParameter("person_contacted_tel") ;
String contact_person=request.getParameter("contact_person") ;
String contact_person_ID=request.getParameter("contact_person_ID") ;
String contact_time=request.getParameter("contact_time") ;
String contact_type=request.getParameter("contact_type") ;
String checker=request.getParameter("checker") ;
String checker_ID=request.getParameter("checker_ID") ;
String check_time=request.getParameter("check_time") ;
String contact_content = new String(request.getParameter("contact_content").getBytes("UTF-8"),"UTF-8");
String sql6="select id from crm_workflow where object_ID='"+contact_ID+"' and ((check_tag='0' and config_id<'"+config_id+"') or (check_tag='1' and config_id='"+config_id+"'))";
ResultSet rs6=crm_db.executeQuery(sql6);
if(!rs6.next()){
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"crm_contact","contact_ID",contact_ID,"check_tag").equals("0")){
try{
	String sql = "update crm_contact set contact_ID='"+contact_ID+"',reason='"+reason+"',reasonexact='"+reasonexact+"',customer_ID='"+customer_ID+"',customer_name='"+customer_name+"',person_contacted='"+person_contacted+"',person_contacted_tel='"+person_contacted_tel+"',contact_person='"+contact_person+"',contact_person_ID='"+contact_person_ID+"',contact_time='"+contact_time+"',contact_type='"+contact_type+"',contact_content='"+contact_content+"',checker='"+checker+"',checker_ID='"+checker_ID+"',check_time='"+check_time+"' where contact_ID='"+contact_ID+"' and check_tag='0'" ;
	crm_db.executeUpdate(sql) ;
sql = "update crm_workflow set checker='"+checker+"',checker_ID='"+checker_ID+"',check_time='"+check_time+"',check_tag='1' where object_ID='"+contact_ID+"' and config_id='"+config_id+"'" ;
	crm_db.executeUpdate(sql);
sql="select id from crm_workflow where object_ID='"+contact_ID+"' and check_tag='0'";
	ResultSet rset=crm_db.executeQuery(sql);
	if(!rset.next()){
		sql="update crm_contact set check_tag='1' where contact_ID='"+contact_ID+"'";
		crm_db.executeUpdate(sql);
int contact_amount=0;
String sql3="select contact_amount from crm_file where customer_ID='"+customer_ID+"'";
ResultSet rs3=crm_db.executeQuery(sql3);
	if(rs3.next()){
		contact_amount=rs3.getInt("contact_amount")+1;
	}
	
	String sql4="update crm_file set contact_amount='"+contact_amount+"',lately_contact_time='"+check_time+"',remind_contact_tag='0' where customer_ID='"+customer_ID+"'";
	crm_db.executeUpdate(sql4) ;
	
	contactExpiry.flow(dbApplication);
	}
}
catch (Exception ex){
ex.printStackTrace();

}
 response.sendRedirect("crm/contact/check_ok.jsp?finished_tag=0");//用户时候登陆过
}else{
	
	response.sendRedirect("crm/contact/check_ok.jsp?finished_tag=1");//用户时候登陆过
	}
}else{
response.sendRedirect("crm/contact/check_ok.jsp?finished_tag=2");
}
	crm_db.commit();
	crm_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
	}catch(Exception ex){
	ex.printStackTrace();
	}
}
}