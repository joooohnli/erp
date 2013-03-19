/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package intrmanufacture.contact;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.io.*;

import include.nseer_db.*;
import validata.ValidataTag;


public class check_ok extends HttpServlet{
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

ValidataTag  vt=new  ValidataTag();

nseer_db_backup1 intrmanufacture_db = new nseer_db_backup1(dbApplication);

if(intrmanufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String config_id=request.getParameter("config_id");
String id=request.getParameter("id");
String contact_ID=request.getParameter("contact_ID") ;
String reason=request.getParameter("reason") ;
String reasonexact=request.getParameter("reasonexact") ;
String provider_ID=request.getParameter("provider_ID") ;
String provider_name=request.getParameter("provider_name") ;
String person_contacted=request.getParameter("person_contacted") ;
String person_contacted_tel=request.getParameter("person_contacted_tel") ;
String contact_person=request.getParameter("contact_person") ;
String contact_person_id=request.getParameter("contact_person_id") ;
String contact_time=request.getParameter("contact_time") ;
String contact_type=request.getParameter("contact_type") ;
String checker=request.getParameter("checker") ;
String checker_id=request.getParameter("checker_id") ;
String check_time=request.getParameter("check_time") ;

String contact_content = new String(request.getParameter("contact_content").getBytes("UTF-8"),"UTF-8");
String sql6="select id from intrmanufacture_workflow where object_ID='"+contact_ID+"' and ((check_tag='0' and config_id<'"+config_id+"') or (check_tag='1' and config_id='"+config_id+"'))";
ResultSet rs6=intrmanufacture_db.executeQuery(sql6);
if(!rs6.next()){
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"intrmanufacture_contact","contact_ID",contact_ID,"check_tag").equals("0")){

	String sql = "update intrmanufacture_contact set contact_ID='"+contact_ID+"',reason='"+reason+"',reasonexact='"+reasonexact+"',provider_ID='"+provider_ID+"',provider_name='"+provider_name+"',person_contacted='"+person_contacted+"',person_contacted_tel='"+person_contacted_tel+"',contact_person='"+contact_person+"',contact_person_id='"+contact_person_id+"',contact_time='"+contact_time+"',contact_type='"+contact_type+"',contact_content='"+contact_content+"',checker='"+checker+"',checker_id='"+checker_id+"',check_time='"+check_time+"' where contact_ID='"+contact_ID+"'" ;
	intrmanufacture_db.executeUpdate(sql) ;

sql = "update intrmanufacture_workflow set checker='"+checker+"',checker_ID='"+checker_id+"',check_time='"+check_time+"',check_tag='1' where object_ID='"+contact_ID+"' and config_id='"+config_id+"'" ;
	intrmanufacture_db.executeUpdate(sql);

sql="select id from intrmanufacture_workflow where object_ID='"+contact_ID+"' and check_tag='0'";
	ResultSet rset=intrmanufacture_db.executeQuery(sql);
	if(!rset.next()){
		sql="update intrmanufacture_contact set check_tag='1' where contact_ID='"+contact_ID+"'";
		intrmanufacture_db.executeUpdate(sql);
int contact_amount=0;
String sql3="select * from intrmanufacture_file where provider_ID='"+provider_ID+"'";
ResultSet rs3=intrmanufacture_db.executeQuery(sql3);
	if(rs3.next()){
		contact_amount=rs3.getInt("contact_amount")+1;
	}
	
	String sql4="update intrmanufacture_file set contact_amount='"+contact_amount+"',lately_contact_time='"+check_time+"',remind_contact_tag='0' where provider_ID='"+provider_ID+"'";
	intrmanufacture_db.executeUpdate(sql4) ;
	}
response.sendRedirect("intrmanufacture/contact/check_ok_a.jsp");

}else{

response.sendRedirect("intrmanufacture/contact/check_ok_b.jsp");
}
}else{
response.sendRedirect("intrmanufacture/contact/check_ok.jsp?finished_tag=2");
}
intrmanufacture_db.commit();
	intrmanufacture_db.close();

}else{
	response.sendRedirect("error_conn.htm");
}

}catch(Exception ex){ex.printStackTrace();}
}
}