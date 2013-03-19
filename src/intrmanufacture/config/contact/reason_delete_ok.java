/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package intrmanufacture.config.contact;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;

public class reason_delete_ok extends HttpServlet{

ServletContext application;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


HttpSession session=request.getSession();
nseer_db_backup1 intrmanufacture_db = new nseer_db_backup1(dbApplication);

try{

if(intrmanufacture_db.conn((String)dbSession.getAttribute("unit_db_name"))){

int i;
int intRowCount;
String sqll = "select * from intrmanufacture_config_public_char where kind='\u8054\u7edc\u7406\u7531' order by type_ID" ;
ResultSet rs=intrmanufacture_db.executeQuery(sqll) ;
rs.next();
rs.last();
intRowCount=rs.getRow();
String[] del=new String[intRowCount];
del=(String[])session.getAttribute("del");
if(del!=null){
for(i=1;i<=intRowCount;i++){
try{
	if(del[i-1]!=null){
	String sql = "delete from intrmanufacture_config_public_char where id='"+del[i-1]+"'" ;
    intrmanufacture_db.executeUpdate(sql) ;
	}
	}
	catch (Exception ex) {
		ex.printStackTrace();
	}
	}
}
intrmanufacture_db.commit();

intrmanufacture_db.close();
response.sendRedirect("intrmanufacture/config/contact/reason.jsp");

}
else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}