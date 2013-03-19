/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package qcs.config.publics;
 
 
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.*;
import java.io.* ;

import include.nseer_db.*;
import include.tree_index.businessComment;

public class delete_ok extends HttpServlet{

ServletContext application;
HttpSession session;

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();

businessComment demo=new businessComment();
demo.setPath(request);
nseer_db_backup1 qcs_db = new nseer_db_backup1(dbApplication);
PrintWriter out=response.getWriter();
try{
if(qcs_db.conn((String)dbSession.getAttribute("unit_db_name"))){

String ids_str=request.getParameter("ids_str");
String[] id_array=ids_str.split("◎");
String type_id_array="";
String sqll="";
int un_del=0;
int del=0;
ResultSet rs=null;
for(int i=0;i<id_array.length;i++){
	sqll="select type_id from qcs_config_public_char where id='"+id_array[i]+"' and used_tag='1'";
	rs=qcs_db.executeQuery(sqll);
	if(rs.next()){
		type_id_array+=","+rs.getString("type_id");
		un_del++;
	}else{
		sqll="delete from qcs_config_public_char where id='"+id_array[i]+"'";
		qcs_db.executeUpdate(sqll);
		del++;
	}
}
if(un_del==id_array.length){
	out.println(demo.getLang("erp", "全部正在应用，不能删除"));
}else if(del==id_array.length){
	out.println(demo.getLang("erp", "全部删除"));
}else{
	out.println(type_id_array.substring(1)+demo.getLang("erp", "正在应用，不能删除"));
}
qcs_db.commit();
qcs_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}	catch(Exception ex) {
		ex.printStackTrace();
	}
}
}