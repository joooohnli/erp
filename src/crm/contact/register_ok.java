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
import java.util.*;
import java.io.*; 
import include.nseer_db.*;
import java.text.*;
import include.nseer_cookie.*;
import include.auto_execute.ContactExpiry;

public class register_ok extends HttpServlet{
ServletContext application;
HttpSession session;
nseer_db_backup1 crm_db = null;

public synchronized void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
ContactExpiry contactExpiry= new ContactExpiry();

	try{
//实例化
String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
time=formatter.format(now);
nseer_db_backup1 crm_db = new nseer_db_backup1(dbApplication);
if(crm_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String customer_ID=request.getParameter("customer_ID");
String contact_ID=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));
String reason=request.getParameter("reason") ;
String reasonexact=request.getParameter("reasonexact") ;
String customer_name=exchange.unURL(request.getParameter("customer_name"));
String person_contacted=request.getParameter("person_contacted") ;
String person_contacted_tel=request.getParameter("person_contacted_tel");
String contact_person=request.getParameter("contact_person");
String contact_person_ID=request.getParameter("contact_person_ID");
String contact_time=request.getParameter("contact_time");
String contact_type=request.getParameter("contact_type") ;
String contact_content = new String(request.getParameter("contact_content").getBytes("UTF-8"),"UTF-8");
String sql1="select * from crm_file where customer_ID='"+customer_ID+"'";
ResultSet rs1=crm_db.executeQuery(sql1);
if(rs1.next()){
	String sql = "insert into crm_contact(contact_ID,reason,reasonexact,chain_ID,chain_name,customer_ID,customer_name,person_contacted,person_contacted_tel,contact_person,contact_person_ID,contact_time,contact_type,contact_content,check_tag,excel_tag,type) values ('"+contact_ID+"','"+reason+"','"+reasonexact+"','"+rs1.getString("chain_ID")+"','"+rs1.getString("chain_name")+"','"+customer_ID+"','"+customer_name+"','"+person_contacted+"','"+person_contacted_tel+"','"+contact_person+"','"+contact_person_ID+"','"+contact_time+"','"+contact_type+"','"+contact_content+"','0','2','"+rs1.getString("type")+"')" ;
	crm_db.executeUpdate(sql) ;
	List rsList = GetWorkflow.getList(crm_db, "crm_config_workflow", "03");
String[] elem=new String[3];
	if(rsList.size()==0){
		sql="update crm_contact set check_tag='1' where contact_ID='"+contact_ID+"'";
		crm_db.executeUpdate(sql) ;
		int contact_amount=0;
String sql3="select contact_amount from crm_file where customer_ID='"+customer_ID+"'";
ResultSet rs3=crm_db.executeQuery(sql3);
	if(rs3.next()){
		contact_amount=rs3.getInt("contact_amount")+1;
	}
	
	String sql4="update crm_file set contact_amount='"+contact_amount+"',lately_contact_time='"+contact_time+"',remind_contact_tag='0' where customer_ID='"+customer_ID+"'";
	crm_db.executeUpdate(sql4) ;
	
	contactExpiry.flow(dbApplication);
	}else{
		Iterator ite=rsList.iterator();
		while(ite.hasNext()){
		elem=(String[])ite.next();
		sql = "insert into crm_workflow(config_id,object_ID,describe1,describe2) values ('"+elem[0]+"','"+contact_ID+"','"+elem[1]+"','"+elem[2]+"')" ;
		crm_db.executeUpdate(sql) ;
		}
	}
}
crm_db.commit();
crm_db.close();
response.sendRedirect("crm/contact/register_ok_a.jsp");//用户时候登陆过
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}