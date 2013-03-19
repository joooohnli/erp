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
if(search_tag.equals("0")){
String kind=request.getParameter("kind");
String sql="select type_name from qcs_config_public_char where kind='"+kind+"'";
ResultSet rs=qcs_db.executeQuery(sql);
while(rs.next()){
	search+=rs.getString("type_name")+"\n";
}
search=!search.equals("")?search.substring(0,search.length()-1):"179206725";
}else if(search_tag.equals("1")){
	String sql="select max from qcs_config_sample_code";
	ResultSet rs=qcs_db.executeQuery(sql);
	while(rs.next()){
	search+="⊙"+rs.getString("max");
	}
	search=!search.equals("")?search.substring(1):"179206725";
}else if(search_tag.equals("2")){
	String type_name=request.getParameter("type_name");
	String sql="select type_id from qcs_config_public_char where type_name='"+type_name+"'";
	ResultSet rs=qcs_db.executeQuery(sql);
	if(rs.next()){
	String column_name=rs.getString("type_id");
	String sql1="select "+column_name+" from qcs_config_sample_code";	
	ResultSet rs1=qcs_db.executeQuery(sql1);
	while(rs1.next()){
	search+="⊙"+rs1.getString(column_name);
	}
	}
	search=!search.equals("")?search.substring(1):"179206725";
}else if(search_tag.equals("3")){
	String type_name=request.getParameter("type_name");
	String aql=request.getParameter("aql");
	String sql="select type_id from qcs_config_public_char where type_name='"+type_name+"'";	
	ResultSet rs=qcs_db.executeQuery(sql);
	if(rs.next()){
	String aql_ac="aql"+aql.replace(".","p")+"_ac";
	String aql_re="aql"+aql.replace(".","p")+"_re";
	String group_id=rs.getString("type_id");
	String sql1="select "+aql_ac+","+aql_re+",type_name,sample_amount from qcs_config_mil_std where group_id='"+group_id+"'";	
	ResultSet rs1=qcs_db.executeQuery(sql1);
	while(rs1.next()){
	search+="◎"+rs1.getString("type_name")+"⊙"+rs1.getString("sample_amount")+"⊙"+rs1.getString(aql_ac)+"⊙"+rs1.getString(aql_re);
	}
	}
	search=!search.equals("")?search.substring(1):"179206725";
}
out.print(search);
qcs_db.close();
}catch(Exception ex){
	ex.printStackTrace();
	}
%>