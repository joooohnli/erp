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
String sql="";
ResultSet rs=null;
nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));
try{
String keyword=request.getParameter("keyword");
String change_time=request.getParameter("change_time");
String tag=request.getParameter("tag");
String lifecycle ="";
if(tag.equals("0")){
	 sql="select file_id from finance_fa_file where file_id like '"+keyword+"%'";
	 rs=finance_db.executeQuery(sql);
while(rs.next()){
	search+=rs.getString("file_id")+"\n";
}
}else{

if(tag.equals("1")){
	sql="select * from finance_fa_file where file_id='"+keyword+"'";
	rs=finance_db.executeQuery(sql);
	if(rs.next()){
	
	if(!rs.getString("lifecycle").equals("")){
		lifecycle =(int)Math.floor(Integer.parseInt(rs.getString("lifecycle"))/12)+"年"+Integer.parseInt(rs.getString("lifecycle"))%12+"月";
	}
	search=rs.getString("type_id")+"⊙"+rs.getString("type_name")+"⊙"+rs.getString("file_id")+"⊙"+rs.getString("file_name")+"⊙"+rs.getString("addway_id")+"⊙"+rs.getString("addway_name")+"⊙"+rs.getString("department_id")+"⊙"+rs.getString("department_name")+"⊙"+rs.getString("specification")+"⊙"+rs.getString("deposit_place")+"⊙"+rs.getString("status_id")+"⊙"+rs.getString("start_time")+"⊙"+rs.getString("calway_id")+"⊙"+lifecycle+"⊙"+rs.getString("currency")+"⊙"+rs.getString("original_value")+"⊙"+rs.getString("remnant_value_rate")+"⊙"+rs.getString("remnant_value")+"⊙"+rs.getString("caled_month")+"⊙"+rs.getString("caled_sum")+"⊙"+rs.getString("cal_subtotal")+"⊙"+rs.getString("cal_subtotal_rate")+"⊙"+rs.getString("net_value")+"⊙"+rs.getString("cal_file_id")+"⊙"+rs.getString("cal_file_name")+"⊙"+rs.getString("work_total")+"⊙"+rs.getString("work_sum")+"⊙"+rs.getString("work_unit")+"⊙"+rs.getString("unit_cal")+"⊙"+rs.getString("change_time");
}
	sql="select count(*) from finance_fa_file_dig where file_id='"+keyword+"'";
	rs=finance_db.executeQuery(sql);
	if(rs.next()){
	search=search+"⊙"+rs.getString("count(*)");
	}
	}else{
		change_time=change_time.substring(0,change_time.length()-2);
		sql="select * from finance_fa_file_dig where file_id='"+keyword+"' and lately_change_time='"+change_time+"'";
		rs=finance_db.executeQuery(sql);
		if(rs.next()){
			if(!rs.getString("lifecycle").equals("")){
		lifecycle =(int)Math.floor(Integer.parseInt(rs.getString("lifecycle"))/12)+"年"+Integer.parseInt(rs.getString("lifecycle"))%12+"月";
	}
		search=rs.getString("type_id")+"⊙"+rs.getString("type_name")+"⊙"+rs.getString("file_id")+"⊙"+rs.getString("file_name")+"⊙"+rs.getString("addway_id")+"⊙"+rs.getString("addway_name")+"⊙"+rs.getString("department_id")+"⊙"+rs.getString("department_name")+"⊙"+rs.getString("specification")+"⊙"+rs.getString("deposit_place")+"⊙"+rs.getString("status_id")+"⊙"+rs.getString("start_time")+"⊙"+rs.getString("calway_id")+"⊙"+lifecycle+"⊙"+rs.getString("currency")+"⊙"+rs.getString("original_value")+"⊙"+rs.getString("remnant_value_rate")+"⊙"+rs.getString("remnant_value")+"⊙"+rs.getString("caled_month")+"⊙"+rs.getString("caled_sum")+"⊙"+rs.getString("cal_subtotal")+"⊙"+rs.getString("cal_subtotal_rate")+"⊙"+rs.getString("net_value")+"⊙"+rs.getString("cal_file_id")+"⊙"+rs.getString("cal_file_name")+"⊙"+rs.getString("work_total")+"⊙"+rs.getString("work_sum")+"⊙"+rs.getString("work_unit")+"⊙"+rs.getString("unit_cal")+"⊙"+rs.getString("change_time");
		}
	}
}

search=!search.equals("")?search:"179206725";
out.print(search);
finance_db.close();
}catch(Exception ex){
	ex.printStackTrace();
	}
%>