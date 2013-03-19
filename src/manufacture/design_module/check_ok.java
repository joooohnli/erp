/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package manufacture.design_module;
 
 
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

import validata.ValidataTag;

public class check_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 manufacture_db = new nseer_db_backup1(dbApplication);
counter count=new counter(dbApplication);
ValidataTag vt=new ValidataTag();

try{
	if(manufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String config_id=request.getParameter("config_id") ;
String design_ID=request.getParameter("design_ID") ;
String bodyc = new String(request.getParameter("check_suggestion").getBytes("UTF-8"),"UTF-8");
String check_suggestion=exchange.toHtml(bodyc);
String check_time=request.getParameter("check_time") ;
String checker_ID=request.getParameter("checker_ID") ;
String checker=request.getParameter("checker") ;
String sql6="select id from manufacture_workflow where object_ID='"+design_ID+"' and type_id='02' and ((check_tag='0' and config_id<'"+config_id+"') or (check_tag='1' and config_id='"+config_id+"'))";
ResultSet rs6=manufacture_db.executeQuery(sql6);
if(!rs6.next()){
if(vt.validata((String)dbSession.getAttribute("unit_db_name"),"manufacture_design_procedure","design_ID",design_ID,"design_module_tag").equals("1")){

try{
	String sql = "update manufacture_design_procedure set check_time='"+check_time+"',checker='"+checker+"',check_suggestion='"+check_suggestion+"' where design_ID='"+design_ID+"'" ;
	manufacture_db.executeUpdate(sql) ;

	String sql2 = "update manufacture_workflow set checker='"+checker+"',checker_ID='"+checker_ID+"',check_time='"+check_time+"',check_tag='1' where object_ID='"+design_ID+"' and config_id='"+config_id+"' and type_id='02'" ;
	manufacture_db.executeUpdate(sql2);

	sql2="select id from manufacture_workflow where object_ID='"+design_ID+"' and check_tag='0' and type_id='02'";
	ResultSet rset=manufacture_db.executeQuery(sql2);

	if(!rset.next()){

    sql2="update manufacture_design_procedure set design_module_tag='2',design_module_change_tag='0' where design_ID='"+design_ID+"'";
		manufacture_db.executeUpdate(sql2) ;
     
	 
	 sql2="update manufacture_design_procedure_details set design_module_tag='1' where design_ID='"+design_ID+"'";
		manufacture_db.executeUpdate(sql2) ;
	}
}
catch (Exception ex){
ex.printStackTrace();
}
	response.sendRedirect("manufacture/design_module/check_ok.jsp?finished_tag=0");
}else{
	response.sendRedirect("manufacture/design_module/check_ok.jsp?finished_tag=1");
}
}else{
	response.sendRedirect("manufacture/design_module/check_ok.jsp?finished_tag=2");
}
  manufacture_db.commit();
  manufacture_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
} 