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

public class stock_apply_ok extends HttpServlet{

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
String product_id = request.getParameter("product_id");
String sql6="select amount from stock_balance_details where product_id='"+product_id+"' and qcs_apply_tag='0' order by stock_ID";
ResultSet rs6=qcs_db1.executeQuery(sql6);
while(rs6.next()){
Double qualified_amount=rs6.getDouble("amount")-rs6.getDouble("unqualified_amount");
String sqla="update stock_balance_details set qualified_amount='"+qualified_amount+"' where product_id='"+product_id+"' and qcs_apply_tag='0'";
qcs_db.executeUpdate(sqla);
}
qcs_db.commit();
qcs_db.close();
}catch(Exception ex){
	response.sendRedirect("qcs/qcs/stock_register_ok.jsp?finished_tag=1");
}
}else{
	response.sendRedirect("error_conn.htm");
}

}catch(Exception ex){
	ex.printStackTrace();
	}
}
}
