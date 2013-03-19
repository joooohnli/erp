/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package ecommerce.website.link;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.io.* ;
import include.nseer_db.*;
import include.nseer_cookie.*;
import validata.ValidataNumber;
import validata.ValidataTag;
import include.get_sql.getInsertSql;

public class delete_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
try{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();
ServletContext application;
HttpSession session=request.getSession();
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
nseer_db_backup1 ecommerce_db = new nseer_db_backup1(dbApplication);
ValidataNumber validata=new ValidataNumber();
ValidataTag vt=new ValidataTag();
counter count=new counter(dbApplication);
getInsertSql getInsertSql=new getInsertSql();
getAttachmentLength getAttachmentLength=new getAttachmentLength();
getAttachmentType getAttachmentType=new getAttachmentType();
if(ecommerce_db.conn((String)dbSession.getAttribute("unit_db_name"))){
String link_ID=request.getParameter("link_ID");
String sql1="delete from ecommerce_link where link_ID='"+link_ID+"'";
ecommerce_db.executeUpdate(sql1);
sql1="delete from ecommerce_link_file where link_ID='"+link_ID+"'";
ecommerce_db.executeUpdate(sql1);
ecommerce_db.commit();
ecommerce_db.close();
response.sendRedirect("ecommerce/website/link/delete_list.jsp");
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}