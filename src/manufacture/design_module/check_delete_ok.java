/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package manufacture.design_module;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.exchange;
import include.nseer_cookie.counter;
import validata.ValidataNumber;
import validata.ValidataTag;
import include.get_sql.getInsertSql;

public class check_delete_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
ServletContext dbApplication=dbSession.getServletContext();
nseer_db_backup1 manufacture_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 manufacture_db1 = new nseer_db_backup1(dbApplication);
ValidataNumber validata=new ValidataNumber();
ValidataTag vt=new ValidataTag();
counter count=new counter(dbApplication);
try{

if(manufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))&&manufacture_db1.conn((String)dbSession.getAttribute("unit_db_name"))){
String config_id=request.getParameter("config_id");
String design_ID=request.getParameter("design_ID") ;
String product_ID=request.getParameter("product_ID") ;
String bodyc = new String(request.getParameter("check_suggestion").getBytes("UTF-8"),"UTF-8");
String choice=request.getParameter("choice");
String check_suggestion=exchange.toHtml(bodyc);
String check_time=request.getParameter("check_time") ;
String checker=request.getParameter("checker") ;

String sql6="select id from manufacture_workflow where object_ID='"+design_ID+"' and type_id='02' and ((check_tag='0' and config_id<'"+config_id+"') or (check_tag='1' and config_id='"+config_id+"'))";
ResultSet rs6=manufacture_db.executeQuery(sql6);
if(!rs6.next()){
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"manufacture_design_procedure","design_ID",design_ID,"design_module_tag").equals("1")){
if(choice!=null){
	if(choice.equals("")){
	String sql ="delete from manufacture_workflow where object_ID='"+design_ID+"'" ;
		manufacture_db.executeUpdate(sql) ;

	 sql = "update manufacture_design_procedure set check_time='"+check_time+"',checker='"+checker+"',check_suggestion='"+check_suggestion+"',design_module_tag='9' where design_ID='"+design_ID+"'" ;
	manufacture_db.executeUpdate(sql) ;
	String sql4="select * from manufacture_design_procedure where design_ID='"+design_ID+"'";
	ResultSet rs4=manufacture_db.executeQuery(sql4) ;
	if(rs4.next()){
		String sql5="update manufacture_design_procedure_details set design_module_change_tag='1',module_subtotal='0',design_module_tag='0' where design_ID='"+rs4.getString("design_ID")+"'";
		
		  sql6="delete from manufacture_design_procedure_module_details where design_ID='"+rs4.getString("design_ID")+"'";
		manufacture_db.executeUpdate(sql5) ;
		manufacture_db.executeUpdate(sql6) ;
	}
	
	String design_ID1="";
	String sql1="select * from design_module where product_ID='"+product_ID+"' and check_tag='1'";
	ResultSet rs1=manufacture_db1.executeQuery(sql1) ;
	if(rs1.next()){
	design_ID1=rs1.getString("design_ID");
	}
	String sql2="select * from design_module_details where design_ID='"+design_ID1+"'";
	ResultSet rs2=manufacture_db1.executeQuery(sql2) ;
	while(rs2.next()){
	String sql3="update design_module_details set design_balance_amount='"+rs2.getString("amount")+"' where id='"+rs2.getString("id")+"'";
	manufacture_db.executeUpdate(sql3) ;
	}
	
	}else{

	sql6="select id from manufacture_workflow where object_ID='"+design_ID+"' and config_id<'"+config_id+"' and config_id>='"+choice+"'";
	rs6=manufacture_db.executeQuery(sql6);
	while(rs6.next()){
		String sql = "update manufacture_workflow set check_tag='0' where id='"+rs6.getString("id")+"'" ;
		manufacture_db1.executeUpdate(sql) ;
	}
	}	
response.sendRedirect("manufacture/design_module/check_delete_ok.jsp?finished_tag=0");
}else{
response.sendRedirect("manufacture/design_module/check_delete_ok.jsp?finished_tag=1");
}
}else{
response.sendRedirect("manufacture/design_module/check_delete_ok.jsp?finished_tag=3");
}
}else{
	response.sendRedirect("manufacture/design_module/check_delete_ok.jsp?finished_tag=2");
}
manufacture_db.commit();
manufacture_db1.commit();
manufacture_db.close();
manufacture_db1.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}