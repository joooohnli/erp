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
<%nseer_db manufacture_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>


<%
String manufacture_ID=request.getParameter("manufacture_ID");
try{
	String sql = "select * from manufacture_manufacture where manufacture_ID='"+manufacture_ID+"'" ;
	ResultSet rs = manufacture_db.executeQuery(sql) ;
	if(rs.next()){
%>
<form id="register1" method="POST" action="register_ok.jsp">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2" width="100%">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></div></td> 
 </tr>
 </table>
 <table <%=TABLE_STYLE1%> class="TABLE_STYLE1" width="100%" id=theObjTable>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","工单制定人")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37.4%" colspan="3"><%=exchange.toHtml(rs.getString("designer"))%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","出库单编号集合")%> </td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37.4%" colspan="3"><%=rs.getString("pay_ID_group")%>&nbsp;</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","登记人")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=exchange.toHtml(rs.getString("register"))%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","登记时间")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=exchange.toHtml(rs.getString("register_time"))%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","审核人")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=exchange.toHtml(rs.getString("checker"))%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","审核时间")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=exchange.toHtml(rs.getString("check_time"))%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","产品编号")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37.4%" colspan="3"><%=rs.getString("product_ID")%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","产品名称")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37.4%" colspan="3"><%=exchange.toHtml(rs.getString("product_name"))%>&nbsp;</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","描述")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37.4%" colspan="3"><%=rs.getString("product_describe")%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","数量")%> </td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37.4%" colspan="3"><%=rs.getString("amount")%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%" height="65"><%=demo.getLang("erp","备注")%> &nbsp; </td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="86.5%" colspan="7"><%=rs.getString("remark")%>&nbsp;</textarea>
</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","设计工时总成本")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37.4%" colspan="3"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("labour_cost_price_sum"))%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","设计物料总成本")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37.4%" colspan="3"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("module_cost_price_sum"))%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","实际工时总成本")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37.4%" colspan="3"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("real_labour_cost_price_sum"))%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","实际物料总成本")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37.4%" colspan="3"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("real_module_cost_price_sum"))%>&nbsp;</td>
 </tr>
</table>
<%}%>
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" width="100%" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="5%"><%=demo.getLang("erp","序号")%></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","工序名称")%> </td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="9%"><%=demo.getLang("erp","设计工时数")%> </td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="9%"><%=demo.getLang("erp","实际工时数")%> </td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="14%"><%=demo.getLang("erp","设计工时成本（元）")%> </td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="14%"><%=demo.getLang("erp","实际工时成本（元）")%> </td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="14%"><%=demo.getLang("erp","设计物料成本（元）")%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE1" width="14%"><%=demo.getLang("erp","实际物料成本（元）")%></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE1" width="7%"><%=demo.getLang("erp","登记")%></td>
 </tr>
<%
int i=1;
String sql6="select * from manufacture_procedure where manufacture_ID='"+manufacture_ID+"' order by details_number";
ResultSet rs6=manufacture_db.executeQuery(sql6);
while(rs6.next()){
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=i%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("procedure_name"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("labour_hour_amount")%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("real_labour_hour_amount")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("subtotal"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><a href="query_module_details.jsp?manufacture_ID=<%=rs6.getString("manufacture_ID")%>&&procedure_name=<%=toUtf8String.utf8String(exchange.toURL(rs6.getString("procedure_name")))%>" target="_blank"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("real_subtotal"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("module_subtotal"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><a href="query_module_details.jsp?manufacture_ID=<%=rs6.getString("manufacture_ID")%>&&procedure_name=<%=toUtf8String.utf8String(exchange.toURL(rs6.getString("procedure_name")))%>" target="_blank"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("real_module_subtotal"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><a href="register_procedure_list.jsp?manufacture_ID=<%=rs6.getString("manufacture_ID")%>&&procedure_name=<%=toUtf8String.utf8String(exchange.toURL(rs6.getString("procedure_name")))%>" target="_blank"><%=demo.getLang("erp","登记")%></a>&nbsp;</td>
 </tr>
<%
	i++;
	}
%>
</table>
 </form>
<%
	manufacture_db.close();
}
catch (Exception ex){
out.println("error"+ex);
}
%>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>
 