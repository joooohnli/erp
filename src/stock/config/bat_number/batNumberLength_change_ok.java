/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package stock.config.bat_number;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;
import validata.ValidataNumber;

public class batNumberLength_change_ok extends HttpServlet{

ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);
ValidataNumber validata=new ValidataNumber();

try{
if(stock_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String sql="select * from stock_balance_details_details where amount!='0'";
ResultSet rss=stock_db.executeQuery(sql);
if(!rss.next()){
      
String stock_name=request.getParameter("stock_name");
if(validata.validata(stock_name)&&Double.parseDouble(stock_name)>0){
String sqll="select * from stock_config_public_char where describe1='B/N长度'";
ResultSet rs=stock_db.executeQuery(sqll);
if(rs.next()){
	String sql2="update stock_config_public_char set stock_name='"+stock_name+"' where describe1='B/N长度'";
	stock_db.executeUpdate(sql2);
}else{
	String sql3="insert into stock_config_public_char(stock_name,describe1) values('"+stock_name+"','B/N长度')";
	stock_db.executeUpdate(sql3);
}
response.sendRedirect("stock/config/bat_number/batNumberLength_change_ok_a.jsp");
}else{
	response.sendRedirect("stock/config/bat_number/batNumberLength_change_ok_b.jsp");
}
}else{
	response.sendRedirect("stock/config/bat_number/batNumberLength_change_ok_c.jsp");
}
stock_db.commit();
stock_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
	catch (Exception ex) {
		ex.printStackTrace();
	}
}
}