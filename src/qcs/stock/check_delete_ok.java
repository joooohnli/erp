/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package qcs.stock;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import include.nseer_db.*;
import java.io.*;

public class check_delete_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


try{
//实例化
HttpSession session=request.getSession();
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
nseer_db_backup1 qcs_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 qcs_db1 = new nseer_db_backup1(dbApplication);
if(qcs_db.conn((String)dbSession.getAttribute("unit_db_name"))&&qcs_db1.conn((String)dbSession.getAttribute("unit_db_name"))){
String check_time = request.getParameter("check_time");
String checker = request.getParameter("checker");
String checker_id = request.getParameter("checker_id");
String qcs_id = request.getParameter("qcs_id");
String config_id = request.getParameter("config_id");
String choice=request.getParameter("choice");
String sql6="select id from qcs_workflow where object_ID='"+qcs_id+"' and ((check_tag='0' and config_id<'"+config_id+"') or (check_tag='1' and config_id='"+config_id+"'))";
ResultSet rs6=qcs_db.executeQuery(sql6);
if(!rs6.next()){
String sql1="select id from qcs_stock where qcs_id='"+qcs_id+"' and check_tag='0'";
ResultSet rs=qcs_db.executeQuery(sql1);
if(!rs.next()){
	response.sendRedirect("qcs/stock/check_delete_ok.jsp?finished_tag=3");
}else{
	if(choice!=null){
	if(choice.equals("")){
	String sql = "update qcs_stock set checker='"+checker+"',checker_id='"+checker_id+"',check_time='"+check_time+"',check_tag='9' where qcs_id='"+qcs_id+"'";
	qcs_db.executeUpdate(sql) ;
	sql = "delete from qcs_workflow where object_ID='"+qcs_id+"'" ;
	qcs_db.executeUpdate(sql) ;
	}else{
	sql6="select id from qcs_workflow where object_ID='"+qcs_id+"' and config_id<'"+config_id+"' and config_id>='"+choice+"'";
	rs6=qcs_db.executeQuery(sql6);
	while(rs6.next()){
		String sql = "update qcs_workflow set check_tag='0' where id='"+rs6.getString("id")+"'" ;
		qcs_db1.executeUpdate(sql) ;
	}
	}
	response.sendRedirect("qcs/stock/check_delete_ok.jsp?finished_tag=0");
	}else{
	response.sendRedirect("qcs/stock/check_delete_ok.jsp?finished_tag=1");
	}	
}
}else{
response.sendRedirect("qcs/stock/check_delete_ok.jsp?finished_tag=2");
}
qcs_db.commit();
qcs_db1.commit();
qcs_db.close();
qcs_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}

}catch(Exception ex){ex.printStackTrace();}
}
}
