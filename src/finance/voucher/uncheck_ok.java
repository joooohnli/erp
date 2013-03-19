/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package finance.voucher;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;
import validata.ValidataFinanceTag;

public class uncheck_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 finance_db = new nseer_db_backup1(dbApplication);
ValidataFinanceTag vt=new ValidataFinanceTag();

try{

if(finance_db.conn((String)dbSession.getAttribute("unit_db_name"))){

String voucher_id = request.getParameter("voucher_id") ;
String register_time=request.getParameter("register_time") ;

if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"finance_voucher","voucher_in_month_id",voucher_id,"register_time",register_time,"check_tag").equals("1")){
try{
	String sql2="update finance_voucher set check_tag='0',change_tag='0',check_time='1800-01-01',checker='',checker_id='' where voucher_in_month_id='"+voucher_id+"' and register_time='"+register_time+"'";
	finance_db.executeUpdate(sql2) ;
}
catch (Exception ex) {
		ex.printStackTrace();
	}
response.sendRedirect("finance/voucher/uncheck_list.jsp");
}else{
response.sendRedirect("finance/voucher/uncheck_ok_a.jsp");
}
finance_db.commit();
finance_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}