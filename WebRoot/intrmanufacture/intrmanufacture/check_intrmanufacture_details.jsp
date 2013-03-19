<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*,include.nseer_cookie.*"%>
<%counter count=new counter(application);%>
<%nseer_db intrmanufacture_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
  <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","关闭窗口")%>" onClick="window.close()"></div>
 </td>
 </tr>
 </table>
<%
String intrmanufacture_ID=request.getParameter("intrmanufacture_ID") ;
String provider_ID=request.getParameter("provider_ID") ;
String sql6="select * from intrmanufacture_details where intrmanufacture_ID='"+intrmanufacture_ID+"' and provider_ID='"+provider_ID+"'";
ResultSet rs6=intrmanufacture_db.executeQuery(sql6);
while(rs6.next()){
%>
<table <%=TABLE_STYLE7%> class="TABLE_STYLE5" style="width:100%;">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","执行单编号")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%" colspan="3"><%=intrmanufacture_ID%></td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","委外厂商名称")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><%=exchange.toHtml(rs6.getString("provider_name"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","委外厂商编号")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><%=rs6.getString("provider_ID")%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","执行单制定人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><%=exchange.toHtml(rs6.getString("designer"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","电话")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><%=exchange.toHtml(rs6.getString("demand_contact_person_tel"))%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","加工单价")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("demand_price"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","加工数量")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerAmountPrecision")).format(rs6.getDouble("demand_amount"))%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","加工小计")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("demand_cost_price_sum"))%>&nbsp;</td>
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","要求供货时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><%=exchange.toHtml(rs6.getString("demand_gather_time"))%>&nbsp;</td> 
 </tr>
<%
String[] attachment_name1=DealWithString.divide(rs6.getString("attachment_name"),40);	
%>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","附件")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><a href="javascript:winopenm('query_attachment.jsp?id=<%=rs6.getString("id")%>&tablename=intrmanufacture_details&fieldname=attachment_name')">
<%=attachment_name1[1]%></a>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","备注")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="13%"><%=rs6.getString("remark")%>&nbsp;</td>
 </tr>
</table>
 </div>
<%
}
intrmanufacture_db.close();
%>