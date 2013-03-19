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
import java.text.SimpleDateFormat;

import include.nseer_db.*;
import include.nseer_cookie.*;
import java.io.*;
import java.util.*;

import com.jspsmart.upload.*;


import include.nseer_cookie.counter;

public class dealwith_ok extends HttpServlet{

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
counter count=new counter(dbApplication);
nseer_db_backup1 qcs_db = new nseer_db_backup1(dbApplication);
if(qcs_db.conn((String)dbSession.getAttribute("unit_db_name"))){
try{
String qcs_id =request.getParameter("qcs_id");
String product_id =request.getParameter("product_id");
String product_name =request.getParameter("product_name");
String qualified =request.getParameter("qualified");
String unqualified =request.getParameter("unqualified");
String stock_id =request.getParameter("stock_id");
String stock_name =request.getParameter("stock_name");
String sql = "update qcs_stock set dealwith_tag='1' where qcs_id='"+qcs_id+"'";
qcs_db.executeUpdate(sql);
sql="update stock_balance_details set qualified_amount='"+qualified+"',unqualified_amount='"+unqualified+"',qcs_apply_tag='0' where product_id='"+product_id+"' and stock_id='"+stock_id+"'";
qcs_db.executeUpdate(sql);
sql="select qualified_amount,unqualified_amount from stock_balance_details where product_id='"+product_id+"' and qcs_apply_tag='0'";
ResultSet rs=qcs_db.executeQuery(sql);
double qualified_amount=0.0d;
double unqualified_amount=0.0d;
while(rs.next()){
	qualified_amount+=rs.getDouble("qualified_amount");
	unqualified_amount+=rs.getDouble("unqualified_amount");
}
sql="update stock_balance set qualified_amount='"+qualified_amount+"',unqualified_amount='"+unqualified_amount+"' where product_id='"+product_id+"'";
qcs_db.executeUpdate(sql);
sql="select id from stock_balance_details where product_id='"+product_id+"' and qcs_apply_tag='1'";
rs=qcs_db.executeQuery(sql);
if(!rs.next()){
	sql="update stock_balance set  qcs_apply_tag='0' where product_id='"+product_id+"'";
	qcs_db.executeUpdate(sql);
}


response.sendRedirect("qcs/stock/dealwith_ok.jsp?finished_tag=0");

qcs_db.commit();
qcs_db.close();

}catch(Exception ex){
	response.sendRedirect("qcs/stock/dealwith_ok.jsp?finished_tag=3");
}
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
	ex.printStackTrace();
	}
}
}
