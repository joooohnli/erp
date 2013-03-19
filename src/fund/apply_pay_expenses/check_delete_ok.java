/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package fund.apply_pay_expenses;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.io.* ;
import java.sql.* ;
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

nseer_db_backup1 fund_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 fund_db1 = new nseer_db_backup1(dbApplication);

if(fund_db.conn((String)dbSession.getAttribute("unit_db_name"))&&fund_db1.conn((String)dbSession.getAttribute("unit_db_name"))){
ValidataTag  vt= new  ValidataTag();
String apply_pay_ID=request.getParameter("apply_pay_ID") ;
String config_id=request.getParameter("config_id");
String choice=request.getParameter("choice");
String check_time=request.getParameter("check_time") ;
String checker=request.getParameter("checker") ;
String checker_ID=request.getParameter("checker_ID") ;
String bodyc = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyc);
if(choice!=null){
String sql6="select id from fund_workflow where object_ID='"+apply_pay_ID+"' and ((check_tag='0' and config_id<'"+config_id+"') or (check_tag='1' and config_id='"+config_id+"'))";
ResultSet rs6=fund_db.executeQuery(sql6);
if(!rs6.next()){
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"fund_apply_pay","apply_pay_ID",apply_pay_ID,"check_tag").equals("0")){

try{
	if(choice.equals("")){
	String sql2="update fund_apply_pay set check_tag='9',check_time='"+check_time+"',checker='"+checker+"',remark='"+remark+"' where apply_pay_ID='"+apply_pay_ID+"'";
	fund_db.executeUpdate(sql2);
	sql2 = "delete from fund_workflow where object_ID='"+apply_pay_ID+"'" ;
	fund_db.executeUpdate(sql2) ;
	}else{
		sql6="select id from fund_workflow where object_ID='"+apply_pay_ID+"' and config_id<'"+config_id+"' and config_id>='"+choice+"'";
	rs6=fund_db.executeQuery(sql6);
	while(rs6.next()){
		String sql = "update fund_workflow set check_tag='0' where id='"+rs6.getString("id")+"'" ;
		fund_db1.executeUpdate(sql) ;
	}
	}
}
catch (Exception ex) {
		ex.printStackTrace();
	}	
  	response.sendRedirect("fund/apply_pay_expenses/check_list.jsp");
}else{
	response.sendRedirect("fund/apply_pay_expenses/check_delete_ok.jsp?finished_tag=0");
}
}else{
	response.sendRedirect("fund/apply_pay_expenses/check_delete_ok.jsp?finished_tag=2");
}
}else{
	response.sendRedirect("fund/apply_pay_expenses/check_delete_ok.jsp?finished_tag=1");
}
fund_db.commit();
fund_db1.commit();
fund_db.close();
fund_db1.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch(Exception ex){
	ex.printStackTrace();
	}
}
}
