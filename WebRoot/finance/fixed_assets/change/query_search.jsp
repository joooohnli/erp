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
String tag=request.getParameter("tag");
if(tag.equals("0")){
	 sql="select file_id from finance_fa_file where file_id like '"+keyword+"%'";
	 rs=finance_db.executeQuery(sql);
while(rs.next()){
	search+=rs.getString("file_id")+"\n";
}

}else{
sql="select * from finance_fa_change where changebill_id='"+keyword+"'";
	rs=finance_db.executeQuery(sql);
	if(rs.next()){
	String cb_lifecycle ="";
	String ca_lifecycle ="";
	if(!rs.getString("cb_lifecycle").equals("") && !rs.getString("ca_lifecycle").equals("")){
	cb_lifecycle =(int)Math.floor(Integer.parseInt(rs.getString("cb_lifecycle"))/12)+"年"+Integer.parseInt(rs.getString("cb_lifecycle"))%12+"月";
	ca_lifecycle =(int)Math.floor(Integer.parseInt(rs.getString("ca_lifecycle"))/12)+"年"+Integer.parseInt(rs.getString("ca_lifecycle"))%12+"月";
	}
	search=rs.getString("change_kind")+"⊙"+rs.getString("file_id")+"⊙"+rs.getString("file_name")+"⊙"+rs.getString("start_time")+"⊙"+rs.getString("type_name")+"⊙"+rs.getString("specification")+"⊙"+rs.getString("change_sub")+"⊙"+rs.getString("currency")+"⊙"+rs.getString("exchange_rate")+"⊙"+rs.getString("cremnant_value")+"⊙"+rs.getString("cremnant_value_rate")+"⊙"+rs.getString("cb_original_value")+"⊙"+rs.getString("ca_original_value")+"⊙"+rs.getString("cb_remnant_value")+"⊙"+rs.getString("cb_kind_id")+"⊙"+rs.getString("cb_kind_name")+"⊙"+rs.getString("ca_kind_id")+"⊙"+rs.getString("ca_kind_name")+"⊙"+rs.getString("cb_deposit_place")+"⊙"+rs.getString("ca_deposit_place")+"⊙"+rs.getString("change_reason")+"⊙"+rs.getString("change_time")+"⊙"+rs.getString("changer")+"⊙"+rs.getString("cb_status_id")+"⊙"+rs.getString("ca_status_id")+"⊙"+rs.getString("cb_caled_sum")+"⊙"+rs.getString("ca_caled_sum")+"⊙"+cb_lifecycle+"⊙"+ca_lifecycle+"⊙"+rs.getString("cb_work_total")+"⊙"+rs.getString("ca_work_total")+"⊙"+rs.getString("cb_net_value")+"⊙"+rs.getString("ca_remnant_value")+"⊙"+rs.getString("cb_remnant_value_rate")+"⊙"+rs.getString("ca_remnant_value_rate")+"⊙"+rs.getString("cb_type")+"⊙"+rs.getString("ca_type")+"⊙"+rs.getString("ca_net_value")+"⊙"+rs.getString("sum_presub")+"⊙"+rs.getString("sum_re_presub")+"⊙"+rs.getString("pre_sub")+"⊙"+rs.getString("re_pre_sub")+"⊙"+rs.getString("cb_calway")+"⊙"+rs.getString("ca_calway")+"⊙"+rs.getString("ca_work_sum")+"⊙"+rs.getString("ca_work_unit");
}
}
search=!search.equals("")?search:"179206725";
out.print(search);
finance_db.close();
}catch(Exception ex){
	ex.printStackTrace();
	}
%>