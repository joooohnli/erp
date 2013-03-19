/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package purchase.apply;
 
 
import include.nseer_cookie.counter;
import include.nseer_cookie.exchange;
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

public class check_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();
counter count=new counter(dbApplication);
try{

nseer_db_backup1 purchase_db = new nseer_db_backup1(dbApplication);
if(purchase_db.conn((String)dbSession.getAttribute("unit_db_name"))){


String apply_ID=request.getParameter("apply_ID");
String config_ID=request.getParameter("config_ID");
String designer=request.getParameter("designer") ;
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String checker=request.getParameter("checker") ;
String checker_ID=request.getParameter("checker_ID") ;
String check_time=request.getParameter("check_time") ;
String bodyb = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyb);

String sql6="select id from purchase_workflow where object_ID='"+apply_ID+"' and ((check_tag='0' and config_ID<'"+config_ID+"') or (check_tag='1' and config_ID='"+config_ID+"'))";
	ResultSet rs6=purchase_db.executeQuery(sql6);
if(!rs6.next()){
	String sql8 = "select * from purchase_apply where apply_ID='"+apply_ID+"' and check_tag='0'" ;
	ResultSet rs8 = purchase_db.executeQuery(sql8) ;
	if(rs8.next()){
	String sql = "update purchase_apply set designer='"+designer+"',register='"+register+"',register_time='"+register_time+"',remark='"+remark+"',checker='"+checker+"',check_time='"+check_time+"' where apply_ID='"+apply_ID+"'" ;
	purchase_db.executeUpdate(sql) ;

    String sql9 = "update purchase_workflow set checker='"+checker+"',checker_ID='"+checker_ID+"',check_time='"+check_time+"',check_tag='1' where object_ID='"+apply_ID+"' and config_ID='"+config_ID+"'" ;
	purchase_db.executeUpdate(sql9);
	sql9="select id from purchase_workflow where object_ID='"+apply_ID+"' and check_tag='0'";
	ResultSet rset=purchase_db.executeQuery(sql9);
	if(!rset.next()){
		sql9="update purchase_apply set check_tag='1' where apply_ID='"+apply_ID+"'";
		purchase_db.executeUpdate(sql9);
	}

response.sendRedirect("purchase/apply/check_ok.jsp?finished_tag=0");
	}else{
response.sendRedirect("purchase/apply/check_ok.jsp?finished_tag=1");
}
}else{
response.sendRedirect("purchase/apply/check_ok.jsp?finished_tag=2");
}

	purchase_db.commit();
	purchase_db.close();

}else{
	response.sendRedirect("error_conn.htm");
}

}
catch (Exception ex){
ex.printStackTrace();
}
}
} 