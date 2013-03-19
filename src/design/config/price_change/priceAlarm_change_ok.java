/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package design.config.price_change;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;
import validata.ValidataNumber;

public class priceAlarm_change_ok extends HttpServlet{

ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


nseer_db_backup1 design_db = new nseer_db_backup1(dbApplication);
ValidataNumber validata=new ValidataNumber();

String type_name=request.getParameter("type_name").replaceAll(",", "");
if(validata.validata(type_name)&&Double.parseDouble(type_name)>0){
try{

	if(design_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String sqll="select * from design_config_public_char where kind='priceAlarm'";
ResultSet rs=design_db.executeQuery(sqll);

if(rs.next()){
	String sql2="update design_config_public_char set type_name='"+type_name+"' where kind='priceAlarm'";
	design_db.executeUpdate(sql2);
}else{
	String sql3="insert into design_config_public_char(type_name,kind) values('"+type_name+"','priceAlarm')";
	design_db.executeUpdate(sql3);
}
design_db.commit();
design_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
	catch (Exception ex) {
		ex.printStackTrace();
	}
	

response.sendRedirect("design/config/price_change/priceAlarm_change_ok_a.jsp");
}else{
response.sendRedirect("design/config/price_change/priceAlarm_change_ok_b.jsp");
}
}
}