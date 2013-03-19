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
String search_tag=request.getParameter("search_tag");
String sql="";
ResultSet rs=null;
switch(Integer.parseInt(search_tag)){
	case 0:
	{
		sql="select type_id,type_name from qcs_config_public_char where kind_id='13'";
		rs=qcs_db.executeQuery(sql);
		while(rs.next()){
			search+=rs.getString("type_id")+"/"+rs.getString("type_name")+"\n";
		}
		break;
	}	
}
search=!search.equals("")?search.substring(0,search.length()-1):"0";
out.print(search);
qcs_db.close();
}catch(Exception ex){
	ex.printStackTrace();
	}
%>