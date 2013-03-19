<%/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
*/%><%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*,include.nseer_cookie.*,include.get_name_from_ID.*"%><%
String sql="";
nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));
try{
String file_id=request.getParameter("file_id");
String lifecycle=request.getParameter("lifecycle");
String remnant_value_rate=request.getParameter("remnant_value_rate");
String depositing_subject=request.getParameter("depositing_subject");
if(depositing_subject==null){
	 sql="update finance_config_assets_kind set lifecycle='"+lifecycle+"',remnant_value_rate='"+remnant_value_rate+"' where file_id='"+file_id+"'";
	 }else{
	 sql="update finance_config_assets_fluctuationway set depositing_subject='"+depositing_subject+"' where file_id='"+file_id+"'";
	 }
	 finance_db.executeUpdate(sql);
finance_db.close();
}catch(Exception ex){
	ex.printStackTrace();
	}
%>