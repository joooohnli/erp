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

public class stock_register_ok extends HttpServlet{

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

String stock_id = request.getParameter("div_stock_id_hidden");
String stock_name = request.getParameter("div_stock_name");
String register = request.getParameter("div_register");
String register_id = request.getParameter("div_register_id");
String register_time = request.getParameter("div_register_time");
String bodyab = new String(request.getParameter("div_remark").getBytes("UTF-8"),"UTF-8");
String remark=exchange.toHtml(bodyab);
	String sqla = "insert into qcs_apply(apply_id,stock_id,stock_name,remark,register,register_id,register_time,reason) values ('"+apply_id+"','"+stock_id+"','"+stock_name+"','"+remark+"','"+register+"','"+register_id+"','"+register_time+"','7')" ;
	qcs_db.executeUpdate(sqla);	
	
String[] product_id = request.getParameterValues("div_product_id");
String[] product_name = request.getParameterValues("div_product_name");
String[] amount_unit = request.getParameterValues("div_amount_unit");
String[] demand_amount = request.getParameterValues("div_amount");
String[] nick_name = request.getParameterValues("div_nick_name");
String[] label = request.getParameterValues("div_label");
for(int i=0;i<product_id.length;i++){
	sqla = "insert into qcs_apply_details(apply_id,stock_id,stock_name,product_id,product_name,amount_unit,demand_amount,nick_name,label,reason) values ('"+apply_id+"','"+stock_id+"','"+stock_name+"','"+product_id[i]+"','"+product_name[i]+"','"+amount_unit[i]+"','"+demand_amount[i]+"','"+nick_name[i]+"','"+label[i]+"','7')";
	qcs_db.executeUpdate(sqla);
}
sqla="update stock_balance_details set qcs_apply_tag='1' where stock_name='"+stock_name+"' and stock_id='"+stock_id+"' and product_id='"+product_id[0]+"'";
qcs_db.executeUpdate(sqla);

sqla="select qcs_apply_tag from stock_balance_details where product_id='"+product_id[0]+"' and qcs_apply_tag='0'";
ResultSet rs=qcs_db.executeQuery(sqla);
if(rs.next()){
	response.sendRedirect("qcs/qcs/stock_register.jsp?product_id="+product_id[0]+"&&product_name="+product_name[0]);
}else{
	sqla="update stock_balance set qcs_apply_tag='1' where product_id='"+product_id[0]+"'";
	qcs_db.executeUpdate(sqla);
	response.sendRedirect("qcs/qcs/stock_register_ok.jsp?finished_tag=0");
}
qcs_db.commit();
qcs_db.close();
}catch(Exception ex){
	ex.printStackTrace();
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
