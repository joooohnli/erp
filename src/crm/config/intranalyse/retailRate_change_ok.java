/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package crm.config.intranalyse;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.io.*;
import include.nseer_db.*;
import validata.ValidataNumber;
import include.nseer_cookie.*;

public class retailRate_change_ok extends HttpServlet{
ServletContext application;
HttpSession session;
nseer_db_backup1 erp_db = null;

public synchronized void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{

	PrintWriter out=response.getWriter();
nseer_db_backup1 design_db = new nseer_db_backup1(dbApplication);
ValidataNumber validata= new  ValidataNumber();
if(design_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String product_ID=request.getParameter("product_ID");
String product_name=exchange.unURL(request.getParameter("product_name"));
String calculate_bonus_sn_tag=request.getParameter("calculate_bonus_sn_tag");
if(calculate_bonus_sn_tag==null) calculate_bonus_sn_tag="\u5426";
String retail_sale_bonus_rate=request.getParameter("retail_sale_bonus_rate");
String retail_profit_bonus_rate=request.getParameter("retail_profit_bonus_rate");

if(validata.validata(retail_sale_bonus_rate)&&validata.validata(retail_profit_bonus_rate)){

	String sql2="update design_file set retail_sale_bonus_rate='"+retail_sale_bonus_rate+"',calculate_bonus_sn_tag='"+calculate_bonus_sn_tag+"',retail_profit_bonus_rate='"+retail_profit_bonus_rate+"' where product_ID='"+product_ID+"'";
	design_db.executeUpdate(sql2);

response.sendRedirect("crm/config/intranalyse/retailRate_change_ok_a.jsp");

}else{
	
response.sendRedirect("crm/config/intranalyse/retailRate_change_ok_b.jsp");
}
design_db.commit();
design_db.close();	
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}