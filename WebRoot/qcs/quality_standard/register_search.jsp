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
String kind=request.getParameter("kind");
String keyword=request.getParameter("keyword");
if(kind.equals("质检值")){
String sql="select type_name from qcs_config_public_char where kind='"+kind+"' and (type_name like '%"+keyword+"%' or type_id like '%"+keyword+"%')";
ResultSet rs=qcs_db.executeQuery(sql);
while(rs.next()){
	search+=rs.getString("type_name")+"\n";
}
}
search=!search.equals("")?search.substring(0,search.length()-1):"179206725";
out.print(search);
qcs_db.close();
}catch(Exception ex){
	ex.printStackTrace();
	}
%>