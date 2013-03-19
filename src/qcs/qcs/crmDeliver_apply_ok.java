/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */

package qcs.qcs;
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

public class crmDeliver_apply_ok extends HttpServlet{

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
SmartUpload mySmartUpload=new SmartUpload();
mySmartUpload.setCharset("UTF-8");
nseer_db_backup1 qcs_db = new nseer_db_backup1(dbApplication);
nseer_db_backup1 qcs_db1 = new nseer_db_backup1(dbApplication);
if(qcs_db.conn((String)dbSession.getAttribute("unit_db_name"))&qcs_db1.conn((String)dbSession.getAttribute("unit_db_name"))){
try{
String pay_id = request.getParameter("pay_id");
String sqla="update stock_pay set qcs_apply_tag='1' where pay_id='"+pay_id+"'";
qcs_db.executeUpdate(sqla);
sqla="select amount,id from stock_pre_paying where pay_id='"+pay_id+"' and qcs_apply_tag='0'";
ResultSet rs=qcs_db.executeQuery(sqla);
while(rs.next()){
	sqla="update stock_pre_paying set qualified_amount='"+rs.getString("amount")+"' where id='"+rs.getString("id")+"'";
	qcs_db1.executeUpdate(sqla);
}
qcs_db.commit();
qcs_db1.commit();
qcs_db.close();
qcs_db1.close();
}catch(Exception ex){
	response.sendRedirect("qcs/qcs/crmDeliver_register_ok.jsp?finished_tag=1");
}
}else{
	response.sendRedirect("error_conn.htm");
}

}catch(Exception ex){
	ex.printStackTrace();
	}
}
}
