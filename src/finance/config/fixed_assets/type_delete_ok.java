/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package finance.config.fixed_assets;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;

public class type_delete_ok extends HttpServlet{

ServletContext application;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


nseer_db_backup1 finance_db = new nseer_db_backup1(dbApplication);
HttpSession session=request.getSession();

try{

if(finance_db.conn((String)dbSession.getAttribute("unit_db_name"))){

int i;
int intRowCount;
String sqll = "select * from finance_config_public_char where kind='\u56fa\u5b9a\u8d44\u4ea7\u79cd\u7c7b'" ;
ResultSet rs=finance_db.executeQuery(sqll) ;
rs.next();
rs.last();
intRowCount=rs.getRow();
String[] del=new String[intRowCount];
del=(String[])session.getAttribute("del");
if(del!=null){
for(i=1;i<=intRowCount;i++){
try{
	String sql = "delete from finance_config_public_char where id='"+del[i-1]+"'" ;
    finance_db.executeUpdate(sql) ;
	}
	catch (Exception ex) {
		ex.printStackTrace();
	}
	}
}
finance_db.close();
response.sendRedirect("finance/config/fix_assets/type.jsp");
}else{
	response.sendRedirect("error_conn.htm");
}
}
	catch (Exception ex) {
		ex.printStackTrace();
	}
}
}