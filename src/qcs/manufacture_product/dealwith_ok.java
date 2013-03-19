/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package qcs.manufacture_product;

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
String product_id =request.getParameter("product_id");
String apply_id =request.getParameter("apply_id");
String qcs_amount =request.getParameter("qcs_amount");
String gather_id="";
String reasonexact="";
int details_number=0;
String sql="select manufactureproduct_id from qcs_apply where apply_id='"+apply_id+"'";
ResultSet rs=qcs_db.executeQuery(sql);
if(rs.next()){
	gather_id=rs.getString("manufactureproduct_id");
}
String dealwith_tag =request.getParameter("dealwith_tag");
if(dealwith_tag.equals("1")){
	sql="select reasonexact from stock_gather where gather_id='"+gather_id+"'";
		rs=qcs_db.executeQuery(sql);
	if(rs.next()){
		reasonexact=rs.getString("reasonexact");
	}
	sql="select details_number from manufacture_procedure where manufacture_ID='"+reasonexact+"' order by details_number desc";
	rs=qcs_db.executeQuery(sql);
	if(rs.next()){
		details_number=rs.getInt("details_number")+1;
	}
	sql="delete from stock_gather where gather_id='"+gather_id+"'";
		qcs_db.executeUpdate(sql);
	sql="delete from stock_gather_details where gather_id='"+gather_id+"'";
		qcs_db.executeUpdate(sql);
	sql="update manufacture_manufacture set manufacture_tag='0' where manufacture_id='"+reasonexact+"'";
		qcs_db.executeUpdate(sql);
	sql="insert into manufacture_procedure(manufacture_id,procedure_id,procedure_name,qcs_tag,demand_amount,details_number) values('"+reasonexact+"','04','返修','1','"+qcs_amount+"','"+details_number+"')";
		qcs_db.executeUpdate(sql);
	sql="update qcs_manufacture_product set dealwith_tag='1' where apply_id='"+apply_id+"'";
	qcs_db.executeUpdate(sql);
}else{
	sql="update qcs_manufacture_product set dealwith_tag='1' where apply_id='"+apply_id+"'";
		qcs_db.executeUpdate(sql);
	sql="update stock_gather set qcs_dealwith_tag='1' where gather_id='"+gather_id+"'";
		qcs_db.executeUpdate(sql);
}
qcs_db.commit();
qcs_db.close();
response.sendRedirect("qcs/manufacture_product/dealwith_ok.jsp");
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
