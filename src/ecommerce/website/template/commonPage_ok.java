/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package ecommerce.website.template;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.io.*;
import include.nseer_db.*;
import include.query.getRecordCount;


public class commonPage_ok extends HttpServlet{
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

nseer_db_backup1 ecommerce_db = new nseer_db_backup1(dbApplication);
if(ecommerce_db.conn((String)dbSession.getAttribute("unit_db_name"))){
getRecordCount  query= new getRecordCount();


String unit_id=request.getParameter("unit_id");
String cols=request.getParameter("col");

   if(cols==null){

response.sendRedirect("ecommerce/website/template/commonPage_ok_a.jsp");

}else{
		String sql = "update ecommerce_web_base set common_page='"+cols+"' where unit_id='"+unit_id+"'" ;
    	ecommerce_db.executeUpdate(sql) ;
	response.sendRedirect("ecommerce/website/template/commonPage_ok_b.jsp");
	}
ecommerce_db.commit();
ecommerce_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
	ex.printStackTrace();
}
}
}

