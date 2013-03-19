<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="include.excel_export.Solid" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*,include.nseer_cookie.*"%>
<%nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<div width="100%" height="100%" style="position:absolute; left:0px; top:0px;">
<table id="Outer2" width="350" align="center" bgcolor=black cborder=0 cellspacing=0 cellpadding=0 align="center">
<tr height="23">
   <td></td>  
</tr>
<tr height="25">
   <td width="78" height="25" style="background-color: #F0F1DE; background-repeat: repeat; background-attachment: scroll; border-left: 1px solid #000000; border-right: 1px solid #000000; border-bottom: 1px solid #000000; background-position: 0% 50%"><p align="center">项目编码</p></td><td width="272" height="25" style="background-color: #F0F1DE; border-right: 1px solid #000000; border-bottom: 1px solid #000000"><p align="center">项目名称</p></td>  
</tr>
<%
String sql1="select * from finance_config_report_itemc";
ResultSet rs1 = finance_db.executeQuery(sql1);
int i=1;
while(rs1.next()){
%>
<tr><td width="78" height="25" style="background-color: #F0F1DE; background-repeat: repeat; background-attachment: scroll; border-left: 1px solid #000000; border-right: 1px solid #000000; border-bottom: 1px solid #000000; background-position: 0% 50%"><input type="text" id="aaaaaa<%=i%>" ondblclick="bbb(this.id)" width="100%" height="25px"  value="<%=rs1.getString("number_in_cash_table")%>" size="10"></td>
<td width="272" height="25px" style="background-color: #F0F1DE; background-repeat: repeat; background-attachment: scroll; border-right: 1px solid #000000; border-bottom: 1px solid #000000; background-position: 0% 50%"><input type="text" id="bbbbbb<%=i%>" value="<%=rs1.getString("first_kind_name")%>"  ondblclick="bbb(this.id)" width="100%" height="25" size="36"></td></tr>
<%
	i++;
}
finance_db.close();
%>
</table>
</div>
<script>
function bbb(obj){
var id=document.getElementById('aaaaaa'+obj.substring(6)).value;
var name=document.getElementById('bbbbbb'+obj.substring(6)).value;
window.parent.setvalue(id,name);
}
</script>