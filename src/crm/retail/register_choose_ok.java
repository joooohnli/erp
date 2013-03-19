/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package crm.retail;
 

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;

public class register_choose_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 stock_db = new nseer_db_backup1(dbApplication);

try{
if(stock_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String stock_ID=request.getParameter("stock_ID");
String product_ID=request.getParameter("product_ID");
String order_ID=request.getParameter("order_ID");
String[] serial_number_group=request.getParameterValues("serial_number");
String serial_number="";
if(serial_number_group!=null){
for(int i=0;i<serial_number_group.length;i++){
	serial_number+=serial_number_group[i]+", ";
}
String sql="delete from stock_paying_temp where pay_ID='"+order_ID+"' and product_ID='"+product_ID+"' and stock_ID='"+stock_ID+"'";
stock_db.executeUpdate(sql);

String sql1="insert into stock_paying_temp(pay_ID,product_ID,stock_ID,serial_number,amount) values('"+order_ID+"','"+product_ID+"','"+stock_ID+"','"+serial_number+"','"+serial_number_group.length+"')";
stock_db.executeUpdate(sql1);

response.sendRedirect("crm/retail/register_reconfirm.jsp?order_ID="+order_ID+"");
}else{

response.sendRedirect("crm/retail/register_choose_ok_c.jsp?product_ID="+product_ID+"&&stock_ID="+stock_ID+"&&order_ID="+order_ID+"");
}
stock_db.commit();
stock_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}