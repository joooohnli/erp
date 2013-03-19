<%/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
*/%><%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*,include.nseer_cookie.*,include.get_name_from_ID.*"%><%
String search="";
nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));
try{
String keyword=request.getParameter("keyword");
String lifecycle ="";
	String sql="select * from finance_fa_caled where id='"+keyword+"'";
	ResultSet rs=finance_db.executeQuery(sql);
	if(rs.next()){
		lifecycle =(int)Math.floor(Integer.parseInt(rs.getString("lifecycle"))/12)+"年"+Integer.parseInt(rs.getString("lifecycle"))%12+"月";
		search=rs.getString("file_id")+"⊙"+rs.getString("file_name")+"⊙"+rs.getString("type_id")+"⊙"+rs.getString("type_name")+"⊙"+rs.getString("department_id")+"⊙"+rs.getString("department_name")+"⊙"+rs.getString("start_time")+"⊙"+lifecycle+"⊙"+rs.getString("caled_time")+"⊙"+rs.getString("original_value")+"⊙"+rs.getString("caled_sum")+"⊙"+rs.getString("work_total")+"⊙"+rs.getString("work_sum")+"⊙"+rs.getString("work_unit")+"⊙"+rs.getString("work_month")+"⊙"+rs.getString("cal_subtotal_month");
	}
	search=!search.equals("")?search:"⊙";
out.print(search);
finance_db.close();
}catch(Exception ex){
	ex.printStackTrace();
	}
%>