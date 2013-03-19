/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package manufacture.module_balance;
 
 
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
String checker_ID=request.getParameter("checker_ID") ;
String config_id=request.getParameter("config_id");
String manufacture_ID=request.getParameter("manufacture_ID") ;
String module_time=request.getParameter("module_time");
String choice=request.getParameter("choice");
String procedure_ID=request.getParameter("procedure_ID") ;
String procedure_name=request.getParameter("procedure_name") ;
String register_time=request.getParameter("register_time") ;
String procedure_responsible_person=request.getParameter("procedure_responsible_person") ;
String checker=request.getParameter("checker") ;
String check_time=request.getParameter("check_time") ;
String bodyc = new String(request.getParameter("reason").getBytes("UTF-8"),"UTF-8");
String reason=exchange.toHtml(bodyc);

String sql6="select id from manufacture_workflow where object_ID='"+manufacture_ID+"' and module_time='"+module_time+"' and procedure_ID='"+procedure_ID+"' and ((check_tag='0' and config_id<'"+config_id+"') or (check_tag='1' and config_id='"+config_id+"'))";
ResultSet rs6=manufacture_db.executeQuery(sql6);
if(!rs6.next()){
String sql88="select * from manufacture_module_balance where manufacture_ID='"+manufacture_ID+"' and module_time='"+module_time+"' and procedure_ID='"+procedure_ID+"' and check_tag='0'";
ResultSet rs88=manufacture_db.executeQuery(sql88);
if(rs88.next()){
if(choice!=null){
	if(choice.equals("")){
		String sql = "update manufacture_module_balance set procedure_responsible_person='"+procedure_responsible_person+"',checker='"+checker+"',check_time='"+check_time+"',reason='"+reason+"',check_tag='9' where manufacture_ID='"+manufacture_ID+"' and register_time='"+register_time+"' and procedure_ID='"+procedure_ID+"' and module_time='"+module_time+"'";
		manufacture_db.executeUpdate(sql) ;
    sql = "delete from manufacture_workflow where object_ID='"+manufacture_ID+"' and procedure_ID='"+procedure_ID+"' and module_time='"+module_time+"'";
		manufacture_db.executeUpdate(sql) ;
	
	}else{

	sql6="select id from manufacture_workflow where object_ID='"+manufacture_ID+"' and module_time='"+module_time+"' and procedure_ID='"+procedure_ID+"' and config_id<'"+config_id+"' and config_id>='"+choice+"'";
	rs6=manufacture_db.executeQuery(sql6);
	while(rs6.next()){
		String sql = "update manufacture_workflow set check_tag='0' where id='"+rs6.getString("id")+"'" ;
		manufacture_db1.executeUpdate(sql) ;
	}
	}	
response.sendRedirect("manufacture/module_balance/check_delete_ok.jsp?finished_tag=0");
}else{
response.sendRedirect("manufacture/module_balance/check_delete_ok.jsp?finished_tag=1");
}
}else{
response.sendRedirect("manufacture/module_balance/check_delete_ok.jsp?finished_tag=3");
}
}else{
	response.sendRedirect("manufacture/module_balance/check_delete_ok.jsp?finished_tag=2");
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