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
nseer_db oa_db = new nseer_db((String)session.getAttribute("unit_db_name"));
try{
String chain_id=request.getParameter("chain_id");
String sql="";
ResultSet rs=null;
		if(chain_id.equals("")){
			sql="select human_id,human_name from hr_file where chain_id!='' and check_tag='1'";
		}else{
		sql="select human_id,human_name from hr_file where chain_id='"+chain_id+"' and check_tag='1'";
		}
		rs=oa_db.executeQuery(sql);
		while(rs.next()){
			search+=rs.getString("human_id")+"/"+rs.getString("human_name")+"\n";
		}
search=!search.equals("")?search.substring(0,search.length()-1):"123";
out.print(search);
oa_db.close();
}catch(Exception ex){
	ex.printStackTrace();
}
%>