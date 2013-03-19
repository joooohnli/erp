/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package qcs.manufacture_procedure;

import javax.servlet.http.*;
import javax.servlet.jsp.*;
import javax.servlet.*;
import java.sql.*;
import java.text.SimpleDateFormat;

import include.nseer_db.*;
import include.nseer_cookie.*;
import java.io.*;
import java.util.*;

import com.jspsmart.upload.*;


import include.nseer_cookie.counter;

public class dealwith_ok extends HttpServlet{

public synchronized void service(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
HttpSession dbSession=request.getSession();
JspFactory _jspxFactory=JspFactory.getDefaultFactory();
PageContext pageContext = _jspxFactory.getPageContext(this,request,response,"",true,8192,true);
ServletContext dbApplication=dbSession.getServletContext();


try{
//实例化

HttpSession session=request.getSession();
ServletContext context=session.getServletContext();
String path=context.getRealPath("/");
counter count=new counter(dbApplication);
nseer_db_backup1 qcs_db = new nseer_db_backup1(dbApplication);

if(qcs_db.conn((String)dbSession.getAttribute("unit_db_name"))){
try{
String procedure_name =request.getParameter("procedure_name");
String manufacture_id =request.getParameter("manufacture_id");
String dealwith_tag1 =request.getParameter("dealwith_tag");
String apply_id = request.getParameter("apply_id");
String sql="";
if(dealwith_tag1.equals("2")){
sql="update manufacture_procedure set qcs_tag='1' where manufacture_id='"+manufacture_id+"' and procedure_name='"+procedure_name+"'";
qcs_db.executeUpdate(sql);
sql="update qcs_manufacture_procedure set dealwith_tag='1' where manufacture_id='"+manufacture_id+"' and procedure_name='"+procedure_name+"'";
qcs_db.executeUpdate(sql);
}else{
sql="update qcs_manufacture_procedure set check_tag='9' where manufacture_id='"+manufacture_id+"' and procedure_name='"+procedure_name+"'";
qcs_db.executeUpdate(sql);
sql="update qcs_apply_details set qcs_tag='0' where apply_id='"+apply_id+"'";
qcs_db.executeUpdate(sql);
}
qcs_db.commit();
qcs_db.close();
response.sendRedirect("qcs/manufacture_procedure/dealwith_ok.jsp");
}catch(Exception ex){
	ex.printStackTrace();
}
}else{
	response.sendRedirect("error_conn.htm");
}

}catch(Exception ex){
	ex.printStackTrace();
	}
}
}
