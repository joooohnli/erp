<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,java.text.*"%>
<%nseer_db oa_db=new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db oa_db1=new nseer_db((String)session.getAttribute("unit_db_name"));%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=demo.getLang("erp","恩信科技开源ERP")%></title>
<style type="text/css">
<!--
body {
	background-color: #FFFFFF;
}
a:link {
	color: #000000;
}
a:visited {
	color: #000000;
}
a:hover {
	color: #0066CC;
}
a:active {
	color: #000000;
}
body,td,th {
	font-size: 12px;
	color: #000000;
}
.style2 {color: #000000}
-->
</style></head>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <font color="#1A98F1"><%=demo.getLang("erp","我的任务")%></td>
 </tr>
</table>
<table>
<%
String human_ID=(String)session.getAttribute("human_IDD");
String sql="select * from oa_check_table order by id";
ResultSet rs=oa_db.executeQuery(sql);
while(rs.next()){
	String sql1="select * from "+rs.getString("main_kind_name")+"_allright where human_ID='"+human_ID+"' and main='"+rs.getString("first_kind_ID")+"' and secondary='"+rs.getString("second_kind_ID")+"'";
	ResultSet rs1=oa_db1.executeQuery(sql1);
	if(rs1.next()){
		
%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td colspan="5"><a href="<%=rs.getString("init_file")%>" target="_blank"><%=rs.getString("first_kind_ID")%>--<%=rs.getString("second_kind_ID")%></a></td>
</tr>
<%}}
oa_db.close();
oa_db1.close();
%>
</table>






