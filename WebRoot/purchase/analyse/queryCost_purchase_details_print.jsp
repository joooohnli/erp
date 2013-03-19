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
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<%nseer_db purchase_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<style media=print> 
.Noprint{display:none;} 
.PageNext{page-break-after: always;} 
</style> 

<%
String purchase_ID=request.getParameter("purchase_ID") ;
String provider_ID=request.getParameter("provider_ID") ;
String sql6="select * from purchase_details where purchase_ID='"+purchase_ID+"' and provider_ID='"+provider_ID+"'";
ResultSet rs6=purchase_db.executeQuery(sql6);
while(rs6.next()){
%>

<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td class="Noprint">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><OBJECT id=WebBrowser classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2 height=0 width=0></OBJECT><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","打印")%> onclick="javascript:window.print()">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","页面设置")%> onclick=document.all.WebBrowser.ExecWB(8,1)>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","打印预览")%> onclick=document.all.WebBrowser.ExecWB(7,1)></div>
 </td>
 </tr>
</table>
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","执行单编号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="86.5%" colspan="7"><%=purchase_ID%></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","供应商名称")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=exchange.toHtml(rs6.getString("provider_name"))%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","供应商编号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=rs6.getString("provider_ID")%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","执行单制定人")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=exchange.toHtml(rs6.getString("designer"))%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","电话")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=exchange.toHtml(rs6.getString("demand_contact_person_tel"))%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","单价")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("demand_price"))%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","采购数量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=exchange.toHtml(rs6.getString("demand_amount"))%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","小计")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("demand_cost_price_sum"))%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","要求供货时间")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=exchange.toHtml(rs6.getString("demand_gather_time"))%>&nbsp;</td> 
 </tr>
<%
String attachment_name1="";
String attachment_name2="";
StringTokenizer tokenTO = new StringTokenizer(rs6.getString("attachment_name"),"_"); 
 while(tokenTO.hasMoreTokens()) {
  attachment_name1 = tokenTO.nextToken();
				attachment_name2=tokenTO.nextToken();
		}	
%>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","附件")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="86.5%" colspan="7"><a href="javascript:winopen('query_attachment.jsp?id=<%=rs6.getString("id")%>&tablename=purchase_details&fieldname=attachment_name')">
<%=attachment_name2%></a>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","备注")%> &nbsp; </td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="86.5%" colspan="7"><%=rs6.getString("remark")%>&nbsp;</td>
 </tr>
</table>

<%
	}
	 purchase_db.close();
%>