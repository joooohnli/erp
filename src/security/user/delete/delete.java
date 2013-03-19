/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package security.user.delete;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;

public class delete extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


ServletContext application;
HttpSession session=request.getSession();

nseer_db_backup1 security_db = new nseer_db_backup1(dbApplication);

try{

if(security_db.conn((String)dbSession.getAttribute("unit_db_name"))){

String human_ID=request.getParameter("human_ID");
	String sql1="update security_users set forbid_tag='1' where human_ID='"+human_ID+"'";
	security_db.executeUpdate(sql1);
	security_db.commit();
	security_db.close();	
  	response.sendRedirect("security/user/delete/delete_a.jsp?human_ID="+human_ID+"");
}else{

	response.sendRedirect("error_conn.htm");
	}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}