/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package purchase.config.file;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;

public class territory_register_ok extends HttpServlet{

ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
try{

nseer_db_backup1 purchase_db = new nseer_db_backup1(dbApplication);

if(purchase_db.conn((String)dbSession.getAttribute("unit_db_name"))){

String type_name=request.getParameter("type_name");
String sqll="select * from purchase_config_public_char where kind='\u533a\u57df' and type_name='"+type_name+"'";
ResultSet rs=purchase_db.executeQuery(sqll);
if(rs.next()){
response.sendRedirect("purchase/config/file/territory_register_ok_a.jsp");
}else{
      String sql = "insert into purchase_config_public_char(kind,type_name) values('\u533a\u57df','"+type_name+"')" ;
    	purchase_db.executeUpdate(sql) ;
response.sendRedirect("purchase/config/file/territory_register_ok_b.jsp");
}
	purchase_db.commit();
		purchase_db.close();

}else{
	response.sendRedirect("error_conn.htm");
}


}catch (Exception ex) {
		ex.printStackTrace();
}
}
}