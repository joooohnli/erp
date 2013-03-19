<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<%nseer_db db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<html>
<head>
<script language="javascript" src="../../javascript/edit/editTable.js"></script>
<script language="javascript">
//var tableEdit=winopener.document.getElementsByTagName("form")[0];
//var edit=tableEdit.getElementsByTagName("TABLE")[0];
var edit=window.opener.tableOnlineEdit;
var names=['product_name','product_ID','product_describe','amount','list_price','cost_price'];
function addGoodsItem(values) {
 if(checkRow(edit,values[0])) {
 addInstanceRow(edit,names,values);
 }
}
</script>
</head>
<%
String sql="select * from design_file";
ResultSet rs=db.executeQuery(sql);
while(rs.next()){
%>
<%=exchange.toHtml(rs.getString("product_name"))%>
<a href="javascript:addGoodsItem(['<%=rs.getString("product_name")%>','<%=rs.getString("product_ID")%>','<%=rs.getString("product_describe")%>','1','<%=rs.getString("list_price")%>','<%=rs.getString("cost_price")%>'])"><%=demo.getLang("erp","添加")%></a><br>
<%}
db.close();
%>
</html>