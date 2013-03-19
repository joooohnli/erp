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

public class purchase_register_ok extends HttpServlet{

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
if(qcs_db.conn((String)dbSession.getAttribute("unit_db_name"))){
try{
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
String time=formatter.format(now);

String apply_id=NseerId.getId(getClass().getResource("").toString(),(String)dbSession.getAttribute("unit_db_name"));

String purchase_id = request.getParameter("div_purchase_id");
String provider_id = request.getParameter("div_provider_id");
String provider_name = request.getParameter("div_provider_name");
String register = request.getParameter("div_register");
String register_id = request.getParameter("div_register_id");
String register_time = request.getParameter("div_register_time");
String bodyab = new String(request.getParameter("div_remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyab);
	String sqla = "insert into qcs_apply(apply_id,purchase_id,provider_id,provider_name,remark,register,register_id,register_time,reason) values ('"+apply_id+"','"+purchase_id+"','"+provider_id+"','"+provider_name+"','"+remark+"','"+register+"','"+register_id+"','"+register_time+"','1')" ;
	qcs_db.executeUpdate(sqla);	
String[] product_id = request.getParameterValues("div_product_id");
String[] product_name = request.getParameterValues("div_product_name");
String[] amount_unit = request.getParameterValues("div_amount_unit");
String[] demand_amount = request.getParameterValues("div_demand_amount");
String[] purchase_time = request.getParameterValues("div_purchase_time");
String[] label = request.getParameterValues("div_label");
for(int i=0;i<product_id.length;i++){
	sqla = "insert into qcs_apply_details(apply_id,product_id,product_name,amount_unit,demand_amount,purchase_time,label,reason) values ('"+apply_id+"','"+product_id[i]+"','"+product_name[i]+"','"+amount_unit[i]+"','"+demand_amount[i]+"','"+purchase_time[i]+"','"+label[i]+"','1')" ;
	qcs_db.executeUpdate(sqla);
}
sqla="update purchase_details set qcs_apply_tag='1' where purchase_id='"+purchase_id+"' and provider_id='"+provider_id+"'";
qcs_db.executeUpdate(sqla);

sqla="select qcs_apply_tag from purchase_details where purchase_id='"+purchase_id+"' and qcs_apply_tag='0'";
ResultSet rs=qcs_db.executeQuery(sqla);
if(rs.next()){
	response.sendRedirect("qcs/qcs/purchase_register.jsp?purchase_id="+purchase_id);
}else{
	sqla="update purchase_purchase set qcs_apply_tag='1' where purchase_id='"+purchase_id+"'";
	qcs_db.executeUpdate(sqla);
	response.sendRedirect("qcs/qcs/purchase_register_ok.jsp?finished_tag=0");
}
qcs_db.commit();
qcs_db.close();
}catch(Exception ex){
	ex.printStackTrace();
	response.sendRedirect("qcs/qcs/purchase_register_ok.jsp?finished_tag=1");
}
}else{
	response.sendRedirect("error_conn.htm");
}

}catch(Exception ex){
	ex.printStackTrace();
	}
}
}
