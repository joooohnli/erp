/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package intrmanufacture.invoice;

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
nseer_db_backup1 intrmanufacture_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 intrmanufacture_db1 = new nseer_db_backup1(dbApplication);
ValidataTag vt=new  ValidataTag();
if(intrmanufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))&&intrmanufacture_db1.conn((String)dbSession.getAttribute("unit_db_name"))){
String config_ID=request.getParameter("config_ID");
String intrmanufacture_ID=request.getParameter("intrmanufacture_ID");
String choice=request.getParameter("choice");
String check_time=request.getParameter("check_time") ;
String checker=request.getParameter("checker") ;
String checker_ID=request.getParameter("checker_ID") ;
String invoice_time=request.getParameter("invoice_time");
if(choice!=null){
String sql6="select id from intrmanufacture_workflow where object_ID='"+intrmanufacture_ID+"' and invoice_time='"+invoice_time+"' and ((check_tag='0' and config_id<'"+config_ID+"') or (check_tag='1' and config_id='"+config_ID+"'))";
ResultSet rs6=intrmanufacture_db.executeQuery(sql6);
if(!rs6.next()){
String sql8="select id from intrmanufacture_purchasing where intrmanufacture_ID='"+intrmanufacture_ID+"' and check_tag='0' and invoice_time='"+invoice_time+"'";
ResultSet rs8=intrmanufacture_db.executeQuery(sql8);
if(rs8.next()){
try{
	if(choice.equals("")){
	String sql2="update intrmanufacture_intrmanufacture set invoice_check_tag='9' where intrmanufacture_ID='"+intrmanufacture_ID+"'";
	intrmanufacture_db.executeUpdate(sql2) ;
	sql2 = "delete from intrmanufacture_workflow where object_ID='"+intrmanufacture_ID+"' and invoice_time='"+invoice_time+"'" ;
	intrmanufacture_db.executeUpdate(sql2) ;
	}else{

	sql6="select id from intrmanufacture_workflow where object_ID='"+intrmanufacture_ID+"' and config_id<'"+config_ID+"' and config_id>='"+choice+"' and invoice_time='"+invoice_time+"'";
	rs6=intrmanufacture_db.executeQuery(sql6);
	while(rs6.next()){
		String sql = "update intrmanufacture_workflow set check_tag='0' where id='"+rs6.getString("id")+"'" ;
		intrmanufacture_db1.executeUpdate(sql) ;
	}
	}
}
catch (Exception ex) {
		ex.printStackTrace();
	}	
  	response.sendRedirect("intrmanufacture/invoice/check_delete_ok.jsp?finished_tag=0");
}else{
	
response.sendRedirect("intrmanufacture/invoice/check_delete_ok.jsp?finished_tag=3");

}
}else{
	response.sendRedirect("intrmanufacture/invoice/check_delete_ok.jsp?finished_tag=2");
}
}else{
	response.sendRedirect("intrmanufacture/invoice/check_delete_ok.jsp?finished_tag=1");
}
intrmanufacture_db.commit();
intrmanufacture_db1.commit();
intrmanufacture_db.close();
intrmanufacture_db1.close();

}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
	ex.printStackTrace();
}
}
}