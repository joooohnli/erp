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
<%@ page import="include.anti_repeat_submit.Globals"%>
<%counter count=new counter(application);%>
<%nseer_db manufacture_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db manufacture_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db design_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<script language=javascript src="../../javascript/winopen/winopen.js"></script>
<script type="text/javascript" src="../../javascript/include/draft_gar/divReconfirm.js"></script>
<%
String product_ID=request.getParameter("product_ID");
String product_name=request.getParameter("product_name");
String product_describe=request.getParameter("product_describe");
String amount=request.getParameter("amount");
String pay_ID_group=request.getParameter("pay_ID_group");
String choice_group=request.getParameter("choice_group");
String designer=request.getParameter("designer") ;
String register=request.getParameter("register") ;
String register_time=request.getParameter("register_time") ;
String remark=request.getParameter("remark");
int i=1;
int m=0;
String design_ID="";
String sql5="select * from manufacture_design_procedure where product_ID='"+product_ID+"' and check_tag='1' and design_module_tag='2'";
ResultSet rs5=manufacture_db.executeQuery(sql5);
if(rs5.next()){
	design_ID=rs5.getString("design_ID");
	String sql7="select * from manufacture_design_procedure_module_details where design_ID='"+design_ID+"'";
	ResultSet rs7=manufacture_db1.executeQuery(sql7);
	while(rs7.next()){
		String sql8="select * from design_file where product_ID='"+rs7.getString("product_ID")+"' and price_alarm_tag='1'";
		ResultSet rs8=design_db.executeQuery(sql8);
		if(rs8.next()){
			m++;
		}
	}
manufacture_db1.close();
design_db.close();
if(m==0){
%>
<form id="register1" method="POST" action="../../manufacture_manufacture_register_ok">
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></td> 
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
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","生产派工单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
 <table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","工单制定人")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="designer" type="text" value="<%=exchange.toHtml(designer)%>"></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","出库单编号")%>：</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="choice_group" type="hidden" value="<%=choice_group%>"><input name="pay_ID_group" type="hidden" value="<%=pay_ID_group%>"><%=pay_ID_group%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","产品编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="product_ID" type="hidden" value="<%=product_ID%>"><%=product_ID%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","产品名称")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="product_name" type="hidden" value="<%=exchange.toHtml(product_name)%>"><%=exchange.toHtml(product_name)%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","数量")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="amount" type="hidden" value="<%=amount%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerAmountPrecision")).format(Double.parseDouble(amount))%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","描述")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="product_describe" type="hidden" value="<%=product_describe%>"><%=product_describe%>&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<TABLE <%=TABLE_STYLE5%> class="TABLE_STYLE5">
	<tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","序号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","工序名称")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","工序编号")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","描述")%> </td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","工时数(小时)")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","单位工时成本（元）")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","工时成本小计（元）")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","查看物料")%> </td>
 </tr>
<%
String sql6="select * from manufacture_design_procedure_details where design_ID='"+design_ID+"' order by details_number";
ResultSet rs6=manufacture_db.executeQuery(sql6);
while(rs6.next()){
	double labour_hour_amount=rs6.getDouble("labour_hour_amount")*Double.parseDouble(amount);
	double subtotal=rs6.getDouble("cost_price")*labour_hour_amount;
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=i%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="procedure_name" type="hidden" value="<%=exchange.toHtml(rs6.getString("procedure_name"))%>"><%=exchange.toHtml(rs6.getString("procedure_name"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="procedure_ID" type="hidden" value="<%=rs6.getString("procedure_ID")%>"><%=rs6.getString("procedure_ID")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="procedure_describe" type="hidden" value="<%=exchange.toHtml(rs6.getString("procedure_describe"))%>"><input name="amount_unit" type="hidden" value="<%=exchange.toHtml(rs6.getString("amount_unit"))%>"><%=exchange.toHtml(rs6.getString("procedure_describe"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="labour_hour_amount" type="hidden" value="<%=labour_hour_amount%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerAmountPrecision")).format(labour_hour_amount)%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="cost_price" type="hidden" value="<%=rs6.getDouble("cost_price")%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("cost_price"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="subtotal" type="hidden" value="<%=subtotal%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(subtotal)%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><a href="javascript:winopen('register_module_details.jsp?design_ID=<%=rs6.getString("design_ID")%>&&procedure_name=<%=exchange.toURL(rs6.getString("procedure_name"))%>&&amount=<%=amount%>')"><%=demo.getLang("erp","查看物料")%></a></td>
 </tr>
<%
	i++;
	}
	manufacture_db.close();
%>
<input name="design_ID" type="hidden" value="<%=design_ID%>">
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","登记人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register" type="text" value="<%=exchange.toHtml(register)%>"></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="register_time" type="hidden" onfocus="setday(this)" value="<%=exchange.toHtml(register_time)%>"><%=exchange.toHtml(register_time)%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","备注")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" width="89%" colspan="3">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark"><%=remark%></textarea>
</td>
 </tr>
</table>
<%@include file="../include/paper_bottom.html"%>
</div>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
 </form>
 <%
}else{
	manufacture_db.close();
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"> <%=demo.getLang("erp","对不起，该产品的工序物料中有正在价格调整的，不能制定生产派工单，请返回。")%></td>
 </tr>
 </table>
</div>
<%
}
}else{
	manufacture_db.close();
	manufacture_db1.close();
design_db.close();
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"> <%=demo.getLang("erp","对不起，该产品的工序设计或工序物料设计尚未完成，不能制定生产派工单，请返回。")%></td>
 </tr>
 </table>
</div>
<%
}
%>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>
 