/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package intrmanufacture.intrmanufacture;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.util.*;
import java.io.*;
import include.nseer_cookie.exchange;
import include.nseer_db.*;
import validata.ValidataTag;
public class check_delete_ok extends HttpServlet{

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

nseer_db_backup1 intrmanufacture_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 intrmanufacture_db1 = new nseer_db_backup1(dbApplication);
if(intrmanufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))&&intrmanufacture_db1.conn((String)dbSession.getAttribute("unit_db_name"))){

ValidataTag  vt= new  ValidataTag();
String config_id=request.getParameter("config_id");
String intrmanufacture_ID=request.getParameter("intrmanufacture_ID");
String checker=request.getParameter("checker") ;
String check_time=request.getParameter("check_time") ;
String choice=request.getParameter("choice");
String bodyb = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyb);
String sql6="select id from intrmanufacture_workflow where object_ID='"+intrmanufacture_ID+"' and ((check_tag='0' and config_id<'"+config_id+"') or (check_tag='1' and config_id='"+config_id+"'))";
ResultSet rs6=intrmanufacture_db.executeQuery(sql6);
if(!rs6.next()){
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"intrmanufacture_intrmanufacture","intrmanufacture_ID",intrmanufacture_ID,"check_tag").equals("1")){
	
if(choice!=null){
	if(choice.equals("")){
	String sql = "update intrmanufacture_intrmanufacture set remark='"+remark+"',checker='"+checker+"',check_time='"+check_time+"',check_tag='9' where intrmanufacture_ID='"+intrmanufacture_ID+"'";
	intrmanufacture_db.executeUpdate(sql) ;

	sql = "delete from intrmanufacture_workflow where object_ID='"+intrmanufacture_ID+"'" ;
	intrmanufacture_db.executeUpdate(sql) ;

	String sql1="select * from intrmanufacture_intrmanufacture where intrmanufacture_ID='"+intrmanufacture_ID+"'";
	ResultSet rs1=intrmanufacture_db.executeQuery(sql1);
	while(rs1.next()){
		StringTokenizer tokenTO = new StringTokenizer(rs1.getString("apply_id_group"),", ");        
	while(tokenTO.hasMoreTokens()) {
        String sql4="update manufacture_apply set manufacture_tag='0' where id='"+tokenTO.nextToken()+"'";
		intrmanufacture_db1.executeUpdate(sql4) ;
		}
	}
	}else{

	sql6="select id from intrmanufacture_workflow where object_ID='"+intrmanufacture_ID+"' and config_id<'"+config_id+"' and config_id>='"+choice+"'";
	rs6=intrmanufacture_db.executeQuery(sql6);
	while(rs6.next()){
		String sql = "update intrmanufacture_workflow set check_tag='0' where id='"+rs6.getString("id")+"'" ;
		intrmanufacture_db1.executeUpdate(sql) ;
	}
	}
	response.sendRedirect("intrmanufacture/intrmanufacture/check_delete_ok.jsp?finished_tag=3");
}else{
	response.sendRedirect("intrmanufacture/intrmanufacture/check_delete_ok.jsp?finished_tag=2");
}
}else{

	response.sendRedirect("intrmanufacture/intrmanufacture/check_delete_ok.jsp?finished_tag=0");
}
}else{
	response.sendRedirect("intrmanufacture/intrmanufacture/check_delete_ok.jsp?finished_tag=1");
}

	intrmanufacture_db.commit();
	intrmanufacture_db.close();
	intrmanufacture_db1.commit();
	intrmanufacture_db1.close();
}
else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
	ex.printStackTrace();
}
}
}