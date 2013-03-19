/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package ecommerce.engage;
 
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
nseer_db_backup1 ecommerce_db = new nseer_db_backup1(dbApplication);
ValidataNumber validata=new ValidataNumber();
ValidataTag vt=new ValidataTag();
counter count=new counter(dbApplication);
getInsertSql getInsertSql=new getInsertSql();

if(ecommerce_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String config_id=request.getParameter("config_id");
String release_id=request.getParameter("release_id");
String choice=request.getParameter("choice");
String bodya = new String(request.getParameter("remark1").getBytes("UTF-8"),"UTF-8");
String remark1=exchange.toHtml(bodya);
String bodyb = new String(request.getParameter("remark2").getBytes("UTF-8"),"UTF-8");
String remark2=exchange.toHtml(bodyb);
String bodyd = new String(request.getParameter("opinion").getBytes("UTF-8"),"UTF-8");
String opinion=exchange.toHtml(bodyd);
String checker_ID=request.getParameter("checker_ID") ;
String checker=request.getParameter("checker") ;
String check_time=request.getParameter("check_time") ;
String sql6="select * from ecommerce_workflow where object_id='"+release_id+"' and ((check_tag='0' and config_id<'"+config_id+"') or (check_tag='1' and config_id='"+config_id+"'))";
ResultSet rs6=ecommerce_db.executeQuery(sql6);
if(!rs6.next()&&vt.validata((String)session.getAttribute("unit_db_name"),"hr_major_release","release_id",release_id,"check_tag").equals("0")){
if(choice!=null){
	if(choice.equals("")){
	String sql = "update hr_major_release set remark1='"+remark1+"',remark2='"+remark2+"',opinion='"+opinion+"',check_tag='9' where release_id='"+release_id+"'" ;
	ecommerce_db.executeUpdate(sql) ;
	sql = "update ecommerce_workflow set check_tag='9',checker_ID='"+checker_ID+"',checker='"+checker+"',check_time='"+check_time+"' where object_id='"+release_id+"' and config_id='"+config_id+"'" ;
		ecommerce_db.executeUpdate(sql) ;
	}else{
		String sql = "update ecommerce_workflow set check_tag='0' where object_id='"+release_id+"' and config_id<'"+config_id+"' and config_id>='"+choice+"'" ;
		ecommerce_db.executeUpdate(sql) ;
	}	
response.sendRedirect("ecommerce/engage/check_delete_ok_a.jsp");
}else{
response.sendRedirect("ecommerce/engage/check_delete_ok_b.jsp?release_id="+release_id+"&config_id="+config_id+"");
}
}else{
response.sendRedirect("ecommerce/engage/check_delete_ok_c.jsp");
}
ecommerce_db.commit();
ecommerce_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}