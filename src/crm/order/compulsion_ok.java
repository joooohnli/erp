
/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package crm.order;
  
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import java.text.SimpleDateFormat;

import javax.servlet.*;
import java.io.* ;

import include.nseer_db.*;

public class compulsion_ok extends HttpServlet{

ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
nseer_db_backup1 gar_db = new nseer_db_backup1(dbApplication);
PrintWriter out=response.getWriter();
try{
if(gar_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String tableName=request.getParameter("tableName");
String ids_str=request.getParameter("ids_str");
String[] value1=ids_str.split("⊙");
String order_id="";
String time="";
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
time=formatter.format(now);
for(int i=0;i<value1.length;i++){
	String id=value1[i];
	String sql="update "+tableName+" set check_tag='1',manufacture_tag='3',pay_tag='3',logistics_tag='3',receive_tag='3',gather_tag='3',invoice_tag='3',order_tag='2' where id='"+id+"'";
		gar_db.executeUpdate(sql);
	sql="select order_id from "+tableName+" where id='"+id+"'";
	ResultSet rs=gar_db.executeQuery(sql);
	if(rs.next()){
	order_id=rs.getString("order_id");
	}
	sql="update stock_pay set pay_tag='2',finish_time='"+time+"' where reasonexact='"+order_id+"'";
		gar_db.executeUpdate(sql);
	sql="select pay_id from stock_pay where reasonexact='"+order_id+"'";
	rs=gar_db.executeQuery(sql);
	if(rs.next()){
	sql="update manufacture_manufacture set manufacture_tag='1' where pay_id_group='"+rs.getString("pay_id")+"'";
	}
	sql="update logistics_logistics set receive_tag='1' where order_id='"+order_id+"'";
		gar_db.executeUpdate(sql);
	
	sql="update fund_fund set check_tag='1' where reasonexact='"+order_id+"'";
		gar_db.executeUpdate(sql);
	sql="update fund_fund set fund_tag='1',finish_time='"+time+"' where apply_id_group like '%"+order_id+"%'";
		gar_db.executeUpdate(sql);
}
out.println("1");
gar_db.commit();
gar_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
		ex.printStackTrace();
	}
}
}