<%/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
*/%><%@page contentType="text/html; charset=UTF-8" language="java" import="include.excel_export.Solid" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%><%
try{
nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));
String id=request.getParameter("id");

 String sql = "select * from finance_config_public_char where id="+id;
 ResultSet rs = finance_db.executeQuery(sql) ;
 if(rs.next()){
 String value=rs.getString("type_name")+"⊙"+rs.getString("describe1")+"⊙"+rs.getString("describe2");
 out.println(value);
 }
finance_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>