/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package manufacture.procedure;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.exchange;

public class check_delete_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();
nseer_db_backup1 manufacture_db = new nseer_db_backup1(dbApplication);

try{
	if(manufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String manufacture_ID=request.getParameter("manufacture_ID");
String designer=request.getParameter("designer") ;
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String checker=request.getParameter("checker") ;
String check_time=request.getParameter("check_time") ;
String bodyb = new String(request.getParameter("remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyb);
	String sql1="select * from manufacture_manufacture where manufacture_ID='"+manufacture_ID+"'";
	ResultSet rs1=manufacture_db.executeQuery(sql1);
	while(rs1.next()){
		StringTokenizer tokenTO = new StringTokenizer(rs1.getString("apply_id_group"),", ");        
	while(tokenTO.hasMoreTokens()) {
        String sql4="update manufacture_apply set manufacture_tag='0' where id='"+tokenTO.nextToken()+"'";
		manufacture_db.executeUpdate(sql4) ;
		}
	}
	String sql = "update manufacture_manufacture set designer='"+designer+"',register='"+register+"',register_time='"+register_time+"',remark='"+remark+"',checker='"+checker+"',check_time='"+check_time+"',check_tag='9' where manufacture_ID='"+manufacture_ID+"'" ;
	manufacture_db.executeUpdate(sql) ;
	manufacture_db.commit();
manufacture_db.close();
  	response.sendRedirect("manufacture/procedure/check_list.jsp");
	}else{
	response.sendRedirect("error_conn.htm");
}

}
catch (Exception ex){
ex.printStackTrace();
}
}
} 