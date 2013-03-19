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
<%@ page import="include.anti_repeat_submit.Globals"%>
<%counter count=new counter(application);%>
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
String design_ID=request.getParameter("design_ID") ;
String product_ID=request.getParameter("product_ID") ;
String procedure_name=exchange.unURL(request.getParameter("procedure_name")) ;
%>
<form id="change" method="POST" action="change_module_list.jsp">
<input name="design_ID" type="hidden" value="<%=design_ID%>">
<input name="procedure_name" type="hidden" value="<%=exchange.toHtml(procedure_name)%>">
<input name="product_ID" type="hidden" value="<%=product_ID%>">
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确认")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></div></td>
 </tr>
</table>
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE2%> class="TD_STYLE2"><font color="red"><%=demo.getLang("erp","变更前将清除本工序物料设计，变更后需要对其他工序进行物料设计，您确认进行变更吗？")%></td>
</tr>
</table>

<div id="nseerGround" class="nseerGround">
<%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","工序物料设计单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","设计单编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=design_ID%></td>
<td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","工序名称")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(procedure_name)%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<%
try{
	String sql="select * from manufacture_design_procedure_module_details where design_ID='"+design_ID+"' and procedure_name='"+procedure_name+"'";
	ResultSet rs=manufacture_db.executeQuery(sql);
	if(rs.next()){
%>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","登记人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("register"))%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("register_time"))%>&nbsp;</td>
<%}else{%>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","登记人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%">&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%">&nbsp;</td>
	<%}%>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE5%> class="TABLE_STYLE5" id=theObjTable>
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="5%"><%=demo.getLang("erp","序号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","物料名称")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","物料编号")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","描述")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","本工序数量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="8%"><%=demo.getLang("erp","单位")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","单价(元)")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","小计(元)")%></td>	 
 </tr>
<%
	String sql1="select * from manufacture_design_procedure_module_details where design_ID='"+design_ID+"' and procedure_name='"+procedure_name+"' order by details_number";
	ResultSet rs1=manufacture_db.executeQuery(sql1);
	while(rs1.next()){
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs1.getString("details_number")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs1.getString("product_name"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs1.getString("product_ID")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs1.getString("product_describe")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerAmountPrecision")).format(rs1.getDouble("amount"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs1.getString("amount_unit"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs1.getDouble("cost_price"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs1.getDouble("subtotal"))%></td>
 </tr>
<%
	}
manufacture_db.close();
}
catch (Exception ex){
out.println("error"+ex);
}
%>
</table>
<%@include file="../include/paper_bottom.html"%>
</div>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>