/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package ecommerce.intrmanufacture;
 
 
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
try{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 design_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 design_db1 = new nseer_db_backup1(dbApplication);
ValidataNumber validata=new ValidataNumber();
ValidataTag vt=new ValidataTag();
counter count=new counter(dbApplication);
getInsertSql getInsertSql=new getInsertSql();

if(design_db.conn((String)dbSession.getAttribute("unit_db_name"))&&design_db1.conn((String)dbSession.getAttribute("unit_db_name"))){
String config_id=request.getParameter("config_id");
String product_ID=request.getParameter("product_ID");
String choice=request.getParameter("choice");
String bodyb = new String(request.getParameter("promotion3").getBytes("UTF-8"),"UTF-8");
String promotion=exchange.toHtml(bodyb);
String bodyd = new String(request.getParameter("opinion3").getBytes("UTF-8"),"UTF-8");
String opinion=exchange.toHtml(bodyd);
String checker_ID=request.getParameter("checker_ID") ;
String checker=request.getParameter("checker") ;
String check_time=request.getParameter("check_time") ;
String lately_change_time=request.getParameter("lately_change_time") ;
String file_change_amount=request.getParameter("file_change_amount") ;
int change_amount=Integer.parseInt(file_change_amount)+1;
String column_group=getInsertSql.sql((String)dbSession.getAttribute("unit_db_name"),"design_file");
String sql6="select * from ecommerce_workflow where object_ID='"+product_ID+"' and ((check_tag='0' and config_id<'"+config_id+"') or (check_tag='1' and config_id='"+config_id+"')) and type_id='04'";
ResultSet rs6=design_db.executeQuery(sql6);
if(!rs6.next()&&vt.validata((String)session.getAttribute("unit_db_name"),"design_file","product_ID",product_ID,"excel_tag3").equals("1")){
if(choice!=null){
	if(choice.equals("")){
	String sql = "update design_file set promotion='"+promotion+"',opinion='"+opinion+"',excel_tag3='9' where product_ID='"+product_ID+"'" ;
	design_db.executeUpdate(sql) ;
	sql = "update ecommerce_workflow set check_tag='9',checker_ID='"+checker_ID+"',checker='"+checker+"',check_time='"+check_time+"' where product_ID='"+product_ID+"' and config_id='"+config_id+"' and type_id='04'";
		design_db.executeUpdate(sql) ;
	}else{

	sql6="select * from ecommerce_workflow where object_ID='"+product_ID+"' and config_id<'"+config_id+"' and config_id>='"+choice+"' and type_id='04'";
	rs6=design_db.executeQuery(sql6);
	while(rs6.next()){
		String sql = "update ecommerce_workflow set check_tag='0' where id='"+rs6.getString("id")+"'" ;
		design_db1.executeUpdate(sql) ;
	}
	}	
response.sendRedirect("ecommerce/oem/check_delete_ok_a.jsp");
}else{
response.sendRedirect("ecommerce/oem/check_delete_ok_b.jsp?product_ID="+product_ID+"&config_id="+config_id+"");
}
}else{
response.sendRedirect("ecommerce/oem/check_delete_ok_c.jsp");
}
design_db.commit();
design_db1.commit();
design_db.close();
design_db1.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}