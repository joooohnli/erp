/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package ecommerce.config.workflow;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.util.* ;
import java.io.* ;
import include.nseer_db.*;

public class other_change_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

try{

ServletContext application;
HttpSession session=request.getSession();
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
nseer_db_backup1 ecommerce_db=new nseer_db_backup1(dbApplication);
nseer_db_backup1 ecommerce_db1=new nseer_db_backup1(dbApplication);
if(ecommerce_db.conn((String)dbSession.getAttribute("unit_db_name"))&&ecommerce_db1.conn((String)dbSession.getAttribute("unit_db_name"))){
String id=request.getParameter("id");
String type_id=request.getParameter("type_id");
String cols_number=request.getParameter("cols_number");
String[] chain_id_array=request.getParameterValues("chain_id");

if(chain_id_array==null){
  	response.sendRedirect("ecommerce/config/workflow/other_change_ok_a.jsp?id="+id+"&type_id="+type_id);
}else{
String describe1="";
String describe2="";
for(int j=0;j<chain_id_array.length;j++){
		if(!chain_id_array[j].equals("")){
				StringTokenizer token=new StringTokenizer(chain_id_array[j],"/");
					while(token.hasMoreTokens()){
						String human_ID=token.nextToken();
						String human_name=token.nextToken();
						describe1+=human_ID+", ";
						describe2+=human_name+", ";
					}
		}
	
}
String sql="select other_ID from ecommerce_other where check_tag='0'";
	ResultSet rs=ecommerce_db1.executeQuery(sql);
	while(rs.next()){
		sql="update ecommerce_workflow set check_tag='0' where object_ID='"+rs.getString("other_ID")+"' and type_id='01'";
		ecommerce_db.executeUpdate(sql);
	}
	String sql1="update ecommerce_config_workflow set describe1='"+describe1+"',describe2='"+describe2+"' where id='"+id+"'";
	ecommerce_db.executeUpdate(sql1);
	sql1="update ecommerce_workflow set describe1='"+describe1+"',describe2='"+describe2+"' where config_id='"+id+"' and check_tag='0' and type_id='01'";
	ecommerce_db.executeUpdate(sql1);	
response.sendRedirect("ecommerce/config/workflow/other_change_ok_b.jsp?id="+id+"&type_id="+type_id);
}
	ecommerce_db.commit();
	ecommerce_db1.commit();
	ecommerce_db1.close();
	ecommerce_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}
catch (Exception ex){
ex.printStackTrace();
}
}
}