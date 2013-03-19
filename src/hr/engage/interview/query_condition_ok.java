/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package hr.engage.interview;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;  
import java.io.* ;
import include.nseer_cookie.exchange;
import include.nseer_db.*;

public class query_condition_ok extends HttpServlet{
//创建方法
ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{

nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);
 if(hr_db.conn((String)dbSession.getAttribute("unit_db_name"))){
HttpSession session=request.getSession();
PrintWriter out=response.getWriter();


String details_number=request.getParameter("details_number") ;
String bodyc = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyc);
try{
 
	String sql1="update hr_resume set interview_tag='4',remark='"+remark+"' where details_number='"+details_number+"'";
	hr_db.executeUpdate(sql1) ;
	hr_db.commit();
	hr_db.close();

	response.sendRedirect("hr/engage/interview/query_condition_ok_a.jsp");

}
catch (Exception ex){
out.println("error"+ex);
}

 }else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}