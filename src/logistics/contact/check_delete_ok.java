/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package logistics.contact;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.io.*;
import java.sql.*;
import include.nseer_db.*;
import validata.ValidataTag;

public class check_delete_ok extends HttpServlet{

ServletContext application;
HttpSession session;
nseer_db_backup1 erp_db = null;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

 
try{HttpSession session=request.getSession();
PrintWriter out=response.getWriter();
nseer_db_backup1 logistics_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 logistics_db1 = new nseer_db_backup1(dbApplication);
ValidataTag vt=new ValidataTag();
if(logistics_db.conn((String)dbSession.getAttribute("unit_db_name"))&&logistics_db1.conn((String)dbSession.getAttribute("unit_db_name"))){
String config_id=request.getParameter("config_id");
String contact_ID=request.getParameter("contact_ID");
String choice=request.getParameter("choice");
String check_time=request.getParameter("check_time") ;
String checker=request.getParameter("checker") ;
if(choice!=null){
String sql6="select id from logistics_workflow where object_ID='"+contact_ID+"' and ((check_tag='0' and config_id<'"+config_id+"') or (check_tag='1' and config_id='"+config_id+"'))";
ResultSet rs6=logistics_db.executeQuery(sql6);
if(!rs6.next()){
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"logistics_contact","contact_ID",contact_ID,"check_tag").equals("0")){
try{
	if(choice.equals("")){
	String sql2="update logistics_contact set check_tag='9',check_time='"+check_time+"',checker='"+checker+"' where contact_ID='"+contact_ID+"' and check_tag='0'";
	logistics_db.executeUpdate(sql2) ;
	sql2 = "delete from logistics_workflow where object_ID='"+contact_ID+"'" ;
	logistics_db.executeUpdate(sql2) ;
	}else{

	sql6="select id from logistics_workflow where object_ID='"+contact_ID+"' and config_id<'"+config_id+"' and config_id>='"+choice+"'";
	rs6=logistics_db.executeQuery(sql6);
	while(rs6.next()){
		String sql = "update logistics_workflow set check_tag='0' where id='"+rs6.getString("id")+"'" ;
		logistics_db1.executeUpdate(sql) ;
	}
	}
}
catch (Exception ex) {
		out.println("error"+ex);
	}	
  	response.sendRedirect("logistics/contact/check_delete_ok.jsp?finished_tag=0");
}else{	
	response.sendRedirect("logistics/contact/check_delete_ok.jsp?finished_tag=3");
}
}else{
	response.sendRedirect("logistics/contact/check_delete_ok.jsp?finished_tag=2");
}
}else{
	response.sendRedirect("logistics/contact/check_delete_ok.jsp?finished_tag=1");
}
logistics_db.commit();
logistics_db1.commit();
logistics_db.close();
logistics_db1.close();

}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
	ex.printStackTrace();
}
}
}