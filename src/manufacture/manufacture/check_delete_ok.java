/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package manufacture.manufacture;
 
 
import include.nseer_cookie.counter;
import include.nseer_cookie.exchange;
import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.StringTokenizer;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import validata.ValidataNumber;
import validata.ValidataTag;

public class check_delete_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
try{
HttpSession dbSession=request.getSession();
ServletContext dbApplication=dbSession.getServletContext();
nseer_db_backup1 manufacture_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 manufacture_db1 = new nseer_db_backup1(dbApplication);
nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);
ValidataNumber validata=new ValidataNumber();
ValidataTag vt=new ValidataTag();
counter count=new counter(dbApplication);

if(manufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))&&manufacture_db1.conn((String)dbSession.getAttribute("unit_db_name"))&&stock_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String config_id=request.getParameter("config_id");
String manufacture_ID=request.getParameter("manufacture_ID");
String product_ID=request.getParameter("product_ID");
String choice=request.getParameter("choice");
String checker_ID=request.getParameter("checker_ID") ;
String checker=request.getParameter("checker") ;
String check_time=request.getParameter("check_time") ;
String designer=request.getParameter("designer") ;
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String bodyb = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyb);

String sql6="select id from manufacture_workflow where object_ID='"+manufacture_ID+"' and ((check_tag='0' and config_id<'"+config_id+"') or (check_tag='1' and config_id='"+config_id+"'))";
ResultSet rs6=manufacture_db.executeQuery(sql6);
if(!rs6.next()){
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"manufacture_manufacture","manufacture_ID",manufacture_ID,"check_tag").equals("0")){
if(choice!=null){
	if(choice.equals("")){
	String sql = "update manufacture_manufacture set designer='"+designer+"',register='"+register+"',register_time='"+register_time+"',remark='"+remark+"',checker='"+checker+"',check_time='"+check_time+"',check_tag='9' where manufacture_ID='"+manufacture_ID+"'" ;
	manufacture_db.executeUpdate(sql) ;
	
	String sql1="select * from manufacture_manufacture where manufacture_ID='"+manufacture_ID+"'";
	ResultSet rs1=manufacture_db.executeQuery(sql1);
	if(rs1.next()){
		StringTokenizer tokenTO = new StringTokenizer(rs1.getString("apply_id_group"),", ");        
	while(tokenTO.hasMoreTokens()) {
        String sql4="update manufacture_apply set manufacture_tag='0' where id='"+tokenTO.nextToken()+"'";
		manufacture_db.executeUpdate(sql4) ;
		}
	}

    sql = "delete from manufacture_workflow where object_ID='"+manufacture_ID+"'" ;
		manufacture_db.executeUpdate(sql) ;
	
	}else{

	sql6="select id from manufacture_workflow where object_ID='"+manufacture_ID+"' and config_id<'"+config_id+"' and config_id>='"+choice+"'";
	rs6=manufacture_db.executeQuery(sql6);
	while(rs6.next()){
		String sql = "update manufacture_workflow set check_tag='0' where id='"+rs6.getString("id")+"'" ;
		manufacture_db1.executeUpdate(sql) ;
	}
	}	
response.sendRedirect("manufacture/manufacture/check_delete_ok.jsp?finished_tag=0");
}else{
response.sendRedirect("manufacture/manufacture/check_delete_ok.jsp?finished_tag=1");
}
}else{
response.sendRedirect("manufacture/manufacture/check_delete_ok.jsp?finished_tag=3");
}
}else{
	response.sendRedirect("manufacture/manufacture/check_delete_ok.jsp?finished_tag=2");
}
manufacture_db.commit();
manufacture_db1.commit();
manufacture_db.close();
manufacture_db1.close();
stock_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}