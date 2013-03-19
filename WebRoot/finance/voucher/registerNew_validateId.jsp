<%/*
 *this file is part of nseer erp
 *Copyright (C)2006-2110 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
*/%><%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*,include.nseer_cookie.*,include.get_name_from_ID.*"%>
<%
String search="";
nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));
try{
String obj_value=request.getParameter("obj_value");
String start_time=request.getParameter("start_time");
String end_time=request.getParameter("end_time");
String sql="select voucher_in_month_id from finance_voucher where voucher_in_month_id ='"+obj_value+"' and  register_time>='"+start_time+"' and register_time<='"+end_time+"'";
ResultSet rs=finance_db.executeQuery(sql);
if(rs.next()){
	sql="select voucher_in_month_id from finance_voucher where register_time>='"+start_time+"' and register_time<='"+end_time+"' order by voucher_in_month_id desc";
	rs=finance_db.executeQuery(sql);
	if(rs.next()){
		String id_temp="1"+rs.getString("voucher_in_month_id");
        id_temp=((Integer.parseInt(id_temp)+1)+"").substring(1);
		out.print(id_temp);
	}
}else{
out.print("0");
}
finance_db.close();
}catch(Exception ex){
	ex.printStackTrace();
	}
%>
