/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package ecommerce.config.website;


import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.* ;
import java.io.* ;
import include.nseer_db.*;

public class commonPage_delete_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


HttpSession session=request.getSession();

try{
	ServletContext context=session.getServletContext();
	String path=context.getRealPath("/");
	nseer_db_backup1 ecommerce_db = new nseer_db_backup1(dbApplication);
	
if(ecommerce_db.conn((String)dbSession.getAttribute("unit_db_name"))){
	String[] del=(String[])session.getAttribute("del");
	for(int p=0;p<del.length;p++){
	
		String sql3="select * from ecommerce_web_template_ii where id='"+del[p]+"'";
	ResultSet rs=ecommerce_db.executeQuery(sql3) ;
	if(rs.next()){
			File file=new File(path+"ecommerce/commonPage_template/"+rs.getString("attachment1"));
			file.delete();

    String sql = "delete from ecommerce_web_template_ii where id='"+del[p]+"'";
	ecommerce_db.executeUpdate(sql) ;
	}}
	
	ecommerce_db.commit();
	ecommerce_db.close();
	response.sendRedirect("ecommerce/config/website/commonPage.jsp");//文件跳转	
	}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
	ex.printStackTrace();
	}	
}
}