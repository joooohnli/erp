/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package logistics.config.file;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;

public class strategyClass_register_ok extends HttpServlet{

ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{
nseer_db_backup1 logistics_db = new nseer_db_backup1(dbApplication);

if(logistics_db.conn((String)dbSession.getAttribute("unit_db_name"))){



String type_name=request.getParameter("type_name");
String sqll="select * from logistics_config_public_char where kind='物流单位级别' and type_name='"+type_name+"'";
ResultSet rs=logistics_db.executeQuery(sqll);
if(rs.next()){
response.sendRedirect("logistics/config/file/strategyClass_register_ok_a.jsp");
}else{
      String sql = "insert into logistics_config_public_char(kind,type_name) values('物流单位级别','"+type_name+"')" ;
    	logistics_db.executeUpdate(sql) ;
response.sendRedirect("logistics/config/file/strategyClass_register_ok_b.jsp");
}
logistics_db.commit();
logistics_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}

}
catch (Exception ex) {
		ex.printStackTrace();
}
}
}