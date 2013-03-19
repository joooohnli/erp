/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package ecommerce.website;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.util.*;
import java.io.*;
import include.nseer_db.*;
import include.query.getRecordCount;


public class guide_ok extends HttpServlet{
ServletContext application;
HttpSession session;
nseer_db_backup1 erp_db = null;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
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
String[] cols=request.getParameterValues("col");
String[] cols2=request.getParameterValues("col2");
   if(cols==null||cols2==null){

response.sendRedirect("ecommerce/website/guide_ok_a.jsp");

}else{
	String sql="delete from ecommerce_cols_top where unit_id='"+unit_id+"'";
	ecommerce_db.executeUpdate(sql) ;
	String first_kind_ID="";
	String first_kind_name="";
	for(int i=0;i<cols.length;i++){
		StringTokenizer tokenTO = new StringTokenizer(cols[i],"~");
		while(tokenTO.hasMoreTokens()) {
			first_kind_ID = tokenTO.nextToken();
			first_kind_name = tokenTO.nextToken();
		}
		sql = "insert into ecommerce_cols_top(unit_id,first_kind_ID,first_kind_name) values('"+unit_id+"','"+first_kind_ID+"','"+first_kind_name+"')" ;
    	ecommerce_db.executeUpdate(sql) ;
	}
	
	sql="delete from ecommerce_cols_bottom where unit_id='"+unit_id+"'";
	ecommerce_db.executeUpdate(sql) ;
	for(int i=0;i<cols2.length;i++){
		StringTokenizer tokenTO = new StringTokenizer(cols2[i],"~");
		while(tokenTO.hasMoreTokens()) {
			first_kind_ID = tokenTO.nextToken();
			first_kind_name = tokenTO.nextToken();
		}
		sql = "insert into ecommerce_cols_bottom(unit_id,first_kind_ID,first_kind_name) values('"+unit_id+"','"+first_kind_ID+"','"+first_kind_name+"')" ;
    	ecommerce_db.executeUpdate(sql) ;
	}
	 
	
	response.sendRedirect("ecommerce/website/guide_ok_b.jsp");
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