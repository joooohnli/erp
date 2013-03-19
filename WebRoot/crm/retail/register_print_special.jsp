<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseerdb.*,java.text.*"%>
<%nseer_db crm_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db crmdb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=demo.getLang("erp","无标题文档")%> </title>
<%@include file="../include/head.jsp"%>
</head>
<%
String order_ID=request.getParameter("order_ID") ;
try{
String sql="select * from crm_order where order_ID='"+order_ID+"'";
ResultSet rs=crmdb.executeQuery(sql);
while(rs.next()){
int pay_percent1=(int)(rs.getDouble("paid_amount_sum")/rs.getDouble("pay_amount_sum")*100);
String pay_percent=pay_percent1+"%";
int invoice_percent1=(int)(rs.getDouble("invoiced_sum")/rs.getDouble("sale_price_sum")*100);
String invoice_percent=invoice_percent1+"%";
int gather_percent1=(int)(rs.getDouble("gathered_sum")/rs.getDouble("sale_price_sum")*100);
String gather_percent=gather_percent1+"%";
int manufacture_percent1=(int)(rs.getDouble("manufactured_sum")/rs.getDouble("sale_price_sum")*100);
String manufacture_percent=manufacture_percent1+"%";
%>
<body>
<blockquote>
 &nbsp;
</blockquote>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td class="Noprint" height="30" width="675">
 <div align="center" class="style1"><OBJECT id=WebBrowser classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2 height=0 width=0></OBJECT><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","打印")%> onclick="javascript:window.print()">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","页面设置")%> onclick=document.all.WebBrowser.ExecWB(8,1)>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","打印预览")%> onclick=document.all.WebBrowser.ExecWB(7,1)></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="675" height="30">&nbsp;</td>
 </tr>
</table>
<table <%=TD_STYLE21%> class="TD_STYLE2" width="677">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="65" height="15">&nbsp;</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="91"><%=rs.getString("order_ID")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="90">&nbsp;</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="91"><%=exchange.toHtml(rs.getString("customer_name"))%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" colspan="2">&nbsp;</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="110"><%=rs.getString("customer_ID")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="80">&nbsp;</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="80"><%=exchange.toHtml(rs.getString("demand_contact_person_tel"))%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" height="30">&nbsp;</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=exchange.toHtml(rs.getString("sales_name"))%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=rs.getString("sales_ID")%></td>
<%
String accomplish_time="";
if(!rs.getString("accomplish_time").equals("1800-01-01 00:00:00.0")){
	accomplish_time=rs.getString("accomplish_time");
}
%>
 <td <%=TD_STYLE3%> class="TD_STYLE3" colspan="2">&nbsp;</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=exchange.toHtml(accomplish_time)%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=exchange.toHtml(rs.getString("type"))%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" height="60">&nbsp;</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" colspan="8"><%=rs.getString("remark")%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" height="15">&nbsp;</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div align="center"><span class="style2"> <%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("sale_price_sum"))%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" colspan="7">&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" height="30">&nbsp;</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="30">&nbsp;</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3" width="30">&nbsp;</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
<%
int i=1;
String sql6="select * from crm_order_details where order_ID='"+order_ID+"'";
ResultSet rs6=crm_db.executeQuery(sql6);
while(rs6.next()){
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3" height="15"><div align="center"><span class="style2"><%=i%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div align="center"><span class="style2"><%=exchange.toHtml(rs6.getString("product_name"))%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div align="center"><span class="style2"><%=rs6.getString("product_ID")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=rs6.getString("product_describe")%>&nbsp;</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div align="center"><span class="style2"><%=exchange.toHtml(rs6.getString("amount"))%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=exchange.toHtml(rs6.getString("amount_unit"))%>&nbsp;</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div align="center"><span class="style2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("list_price"))%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div align="center"><span class="style2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("subtotal"))%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div align="center"><span class="style2"><%=exchange.toHtml(rs6.getString("serial_number"))%>&nbsp;</td>
 </tr>
<%
	i++;
	}
	crm_db.close();
%>
</table>

<%
}
crmdb.close(); 
}
catch (Exception ex){
out.println("error"+ex);
}
%>