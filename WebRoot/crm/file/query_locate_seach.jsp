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
String fileKind_chain=request.getParameter("fileKind_chain");
fileKind_chain=fileKind_chain.split(" ")[0];
String sql="";
String value="⊙";
if(fileKind_chain.equals("")){
sql = "select customer_name from crm_file";
}else{
sql = "select customer_name from crm_file where filekind_chian like '"+fileKind_chain+"%'";
}
 ResultSet rs = finance_db.executeQuery(sql) ; 
while(rs.next()){
 value+=rs.getString("customer_name")+"⊙";
 }
 value=value.substring(1,value.length()-1);
  out.println(value);
finance_db.close();
}catch(Exception ex){ex.printStackTrace();}
%>