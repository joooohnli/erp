<%/*
 *this file is part of nseer erp
 *Copyright (C)2006-2110 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
*/%><%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*,include.nseer_cookie.*,include.get_name_from_ID.*"%>
<%
String temp="";
String temp1="";
nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));
try{
String keyword=request.getParameter("keyword");
StringTokenizer tk=new StringTokenizer(keyword,"◎");
while(tk.hasMoreTokens()){
temp1=tk.nextToken();
	
String sql="select id from finance_config_file_kind where chain_id ='"+temp1.substring(0,temp1.indexOf(" "))+"' and chain_name='"+temp1.substring(temp1.indexOf(" ")+1)+"' and details_tag='0' order by file_id";
ResultSet rs=finance_db.executeQuery(sql);

if(rs.next()){	
	temp="1";
}else{
	temp="0";
	break;
}
}
out.print(temp);
finance_db.close();
}catch(Exception ex){
	ex.printStackTrace();
	}
%>
