/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package design.config.file;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;

import include.nseer_cookie.Divide1;
import include.nseer_db.*;

public class responsiblePersonName_register_ok extends HttpServlet{

ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


nseer_db_backup1 design_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 hr_db = new nseer_db_backup1(dbApplication);

String fileKind_chain=request.getParameter("fileKind_chain");
String chain_id=Divide1.getId(fileKind_chain);
String chain_name=Divide1.getName(fileKind_chain);
String responsible_person_ID=request.getParameter("responsible_person_ID");
try{
	if(design_db.conn((String)dbSession.getAttribute("unit_db_name"))&&hr_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String sqll="select * from design_config_responsibleperson where chain_id='"+chain_id+"' and chain_name='"+chain_name+"' and responsible_person_ID='"+responsible_person_ID+"'";
ResultSet rs=design_db.executeQuery(sqll);

if(rs.next()){
	
response.sendRedirect("design/config/file/responsiblePersonName_register_ok_a.jsp");
}else{
      String sql2="select * from hr_file where human_ID='"+responsible_person_ID+"'";
	ResultSet rs2=hr_db.executeQuery(sql2);
	if(rs2.next()){
      String sql = "insert into design_config_responsibleperson(chain_id,chain_name,responsible_person_ID,responsible_person_name) values('"+chain_id+"','"+chain_name+"','"+responsible_person_ID+"','"+rs2.getString("human_name")+"')" ;
    	design_db.executeUpdate(sql) ;
		
response.sendRedirect("design/config/file/responsiblePersonName_register_ok_b.jsp");
}else{
response.sendRedirect("design/config/file/responsiblePersonName_register_ok_c.jsp");
}
}
design_db.commit();
hr_db.commit();
hr_db.close();
design_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
	catch (Exception ex) {
		ex.printStackTrace();
	}
}
}