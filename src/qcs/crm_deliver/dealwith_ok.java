/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package qcs.crm_deliver;

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



String stock_name =request.getParameter("stock_name");
String stock_id =request.getParameter("stock_id");
String qcs_id =request.getParameter("qcs_id");
String apply_id=request.getParameter("apply_id");
String dealwith_tag =request.getParameter("dealwith_tag");
String product_id =request.getParameter("product_id");
String qualified =request.getParameter("qualified");
String unqualified_amount = request.getParameter("unqualified");


String sql = "update qcs_crm_deliver set dealwith_tag='"+dealwith_tag+"' where qcs_id='"+qcs_id+"'";
qcs_db.executeUpdate(sql);

sql="select * from qcs_apply where apply_id='"+apply_id+"'";
ResultSet rs=qcs_db.executeQuery(sql);
if(rs.next()){
	String crmDeliver_id=rs.getString("crmDeliver_id");

String sql1="select * from stock_pre_paying where pay_id='"+rs.getString("crmDeliver_id")+"'and product_id='"+product_id+"' and stock_id='"+stock_id+"'";
ResultSet rs1=qcs_db.executeQuery(sql1);
if(rs1.next()){
Double qualified_amount_temp=Double.parseDouble(qualified)+rs1.getDouble("qualified_amount");
String sql2="update stock_pre_paying set qualified_amount='"+qualified_amount_temp+"' where pay_id='"+crmDeliver_id+"' and product_id='"+product_id+"' and stock_id='"+stock_id+"'";
qcs_db.executeUpdate(sql2);
sql="update qcs_apply_details set qcs_tag='0',demand_amount='"+unqualified_amount+"' where apply_id='"+apply_id+"'";
qcs_db.executeUpdate(sql);
}
		sql="update qcs_apply_details set qcs_tag='1' where apply_id='"+apply_id+"' and demand_amount='0'";
		qcs_db.executeUpdate(sql);
}
response.sendRedirect("qcs/crm_deliver/dealwith_ok.jsp?finished_tag=0");

qcs_db.commit();
qcs_db.close();
}else{
	response.sendRedirect("error_conn.htm");
}
}catch(Exception ex){
	ex.printStackTrace();
	}
}
}
