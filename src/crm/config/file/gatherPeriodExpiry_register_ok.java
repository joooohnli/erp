/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package crm.config.file;



import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.util.*;
import java.io.*;
import include.nseer_db.*;


public class gatherPeriodExpiry_register_ok extends HttpServlet{
ServletContext application;
HttpSession session;
nseer_db_backup1 erp_db = null;

public synchronized void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{
PrintWriter out=response.getWriter();

nseer_db_backup1 crm_db = new nseer_db_backup1(dbApplication);
if(crm_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String type_value2=request.getParameter("type_value");
StringTokenizer tokenTO = new StringTokenizer(type_value2,",");        
int i = 0;
String type_value="";
String type_value1="";
while(tokenTO.hasMoreTokens()) {
type_value1 = tokenTO.nextToken();
type_value +=type_value1;
i++;
}
String sqll="select * from crm_config_public_double where kind='回款' and type_value='"+type_value+"'";
ResultSet rs=crm_db.executeQuery(sqll);
if(rs.next()){

	response.sendRedirect("crm/config/file/gatherPeriodExpiry_register_ok_a.jsp");


}else{
      String sql = "insert into crm_config_public_double(kind,type_value) values('回款','"+type_value+"')" ;
    	crm_db.executeUpdate(sql) ;

	response.sendRedirect("crm/config/file/gatherPeriodExpiry_register_ok_b.jsp");

	}
crm_db.commit();
crm_db.close();

}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){}
}
}
