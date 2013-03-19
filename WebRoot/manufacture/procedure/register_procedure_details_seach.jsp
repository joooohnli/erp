<%/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */%><%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseerdb.*,java.text.*"%><%
nseer_db manufacture_db = new nseer_db((String)session.getAttribute("unit_db_name"));
String manufacture_ID=request.getParameter("manufacture_ID");
String procedure_name=request.getParameter("procedure_name");
try{
	String sql = "select qcs_tag from manufacture_procedure where manufacture_ID='"+manufacture_ID+"' and procedure_name='"+procedure_name+"'";
	ResultSet rs = manufacture_db.executeQuery(sql) ;
	if(rs.next()){
		out.print(rs.getString("qcs_tag"));
	}else{
		out.print("0");
	}
	finance_db.close();
}catch(Exception ex){
	ex.printStackTrace();
	}
%>