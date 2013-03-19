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
nseer_db qcs_db = new nseer_db((String)session.getAttribute("unit_db_name"));
try{
String standard_id=request.getParameter("standard_id");
standard_id=standard_id.substring(0,standard_id.indexOf("/"));
String sql="select item,analyse_method,default_basis,ready_basis,quality_method,standard_value,standard_max,standard_min from qcs_quality_standard_details where standard_id='"+standard_id+"'";
ResultSet rs=qcs_db.executeQuery(sql);
while(rs.next()){
	search+="⊙"+rs.getString("item")+"◎"+rs.getString("analyse_method")+"◎"+rs.getString("default_basis")+"◎"+rs.getString("ready_basis")+"◎"+rs.getString("quality_method")+"◎"+rs.getString("standard_value")+"◎"+rs.getString("standard_max")+"◎"+rs.getString("standard_min");
}
search=!search.equals("")?search.substring(1):"179206725";
out.print(search);
qcs_db.close();
}catch(Exception ex){
	ex.printStackTrace();
	}
%>