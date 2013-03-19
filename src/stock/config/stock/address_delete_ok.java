/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package stock.config.stock;
 
 
import include.nseer_db.nseer_db_backup1;

import java.io.IOException;
import java.sql.ResultSet;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

public class address_delete_ok extends HttpServlet{

ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);

try{
if(stock_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String stock_ID=request.getParameter("stock_ID");
	String sql1="select stock_ID from stock_cell_details where stock_ID='"+stock_ID+"'";
	ResultSet rs1=stock_db.executeQuery(sql1) ;
	if(rs1.next()){
response.sendRedirect("stock/config/stock/address_delete_ok_a.jsp");
}else{
      String sql = "delete from stock_config_public_char where stock_ID='"+stock_ID+"'" ;
    stock_db.executeUpdate(sql) ;
response.sendRedirect("stock/config/stock/address.jsp");
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