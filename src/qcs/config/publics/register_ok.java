/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package qcs.config.publics;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;

import include.nseer_db.*;

public class register_ok extends HttpServlet{

ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
nseer_db_backup1 qcs_db = new nseer_db_backup1(dbApplication);
PrintWriter out=response.getWriter();
try{
if(qcs_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String type_name=request.getParameter("type_name");
String type_id=request.getParameter("type_id");
String kind=request.getParameter("kind");
String kind_id=request.getParameter("kind_id");
String sqll="select id from qcs_config_public_char where kind_id='"+kind_id+"' and (type_name='"+type_name+"' or type_id='"+type_id+"')";
ResultSet rs=qcs_db.executeQuery(sqll);
if(rs.next()){
out.println("1");
}else{
      String sql = "insert into qcs_config_public_char(kind_id,kind,type_name,type_id) values('"+kind_id+"','"+kind+"','"+type_name+"','"+type_id+"')";
    	qcs_db.executeUpdate(sql);
out.println("2");
}
qcs_db.commit();
qcs_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
		ex.printStackTrace();
	}
}
}