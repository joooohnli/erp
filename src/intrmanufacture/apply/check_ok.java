/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package intrmanufacture.apply;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.io.* ;
import include.nseer_cookie.exchange;
import include.nseer_db.*;
import include.nseer_cookie.counter;


public class check_ok extends HttpServlet{
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

nseer_db_backup1 intrmanufacture_db = new nseer_db_backup1(dbApplication);

if(intrmanufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))){

counter  count= new  counter(dbApplication);

String apply_ID=request.getParameter("apply_ID");
String designer=request.getParameter("designer") ;
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String checker=request.getParameter("checker") ;
String check_time=request.getParameter("check_time") ;
String bodyb = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyb);
	String sql8 = "select * from intrmanufacture_apply where apply_ID='"+apply_ID+"' and check_tag='0'" ;
	ResultSet rs8 = intrmanufacture_db.executeQuery(sql8) ;
	if(rs8.next()){
try{
	String sql = "update intrmanufacture_apply set designer='"+designer+"',register='"+register+"',register_time='"+register_time+"',remark='"+remark+"',checker='"+checker+"',check_time='"+check_time+"',check_tag='1' where apply_ID='"+apply_ID+"'" ;
	intrmanufacture_db.executeUpdate(sql) ;
	
}
catch (Exception ex){
out.println("error"+ex);
}
response.sendRedirect("intrmanufacture/apply/check_ok_a.jsp");
}else{
response.sendRedirect("intrmanufacture/apply/check_ok_b.jsp");
}
intrmanufacture_db.commit();
	intrmanufacture_db.close();


}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}
