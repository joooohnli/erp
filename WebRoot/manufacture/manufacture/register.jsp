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
String[] choice=request.getParameterValues("choice");
if(choice!=null){

String product_ID="";
String product_name="";
String product_describe="";
String type="";
double amount=0.0d;
String condition="";
String choice_group="";
String pay_ID_group="";
int i;
for(i=0;i<choice.length-1;i++){
	condition=condition+"id='"+choice[i]+"'"+" or ";
	choice_group=choice_group+choice[i]+", ";
}
condition=condition+"id='"+choice[i]+"'";
choice_group=choice_group+choice[i];
String sql = "select distinct product_ID from manufacture_apply where "+condition+"" ;
ResultSet rs = manufacture_db.executeQuery(sql) ;
rs.last();
int row=rs.getRow();
if(row==1){
		String sql1="select sum(amount) from manufacture_apply where "+condition+"";
	ResultSet rs1 = manufacture_db.executeQuery(sql1) ;
	if(rs1.next()){
		amount=rs1.getDouble("sum(amount)");
	}
	if(amount!=0){
	%>
<script type='text/javascript' src='../../dwr/engine.js'></script>
<script type='text/javascript' src='../../dwr/util.js'></script>
<script type='text/javascript' src='../../dwr/interface/multiLangValidate.js'></script>
<script type='text/javascript' src='../../dwr/interface/validateV7.js'></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<form id="mutiValidation" class="x-form" method="POST" action="register_reconfirm.jsp" onSubmit="return doValidate('../../xml/manufacture/manufacture_manufacture.xml','mutiValidation')">
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","预览")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></div></td> 
 </tr>
 </table>
<%
	String sql2="select * from manufacture_apply where "+condition+"";
	ResultSet rs2 = manufacture_db.executeQuery(sql2) ;
	while(rs2.next()){
		product_ID=rs2.getString("product_ID");
		product_name=rs2.getString("product_name");
		product_describe=rs2.getString("product_describe");
		type=rs2.getString("type");
		if(pay_ID_group.equals("")){
			pay_ID_group=rs2.getString("pay_ID_group");
		}else{
			pay_ID_group=pay_ID_group+", "+rs2.getString("pay_ID_group");
		}
	}
manufacture_db.close();
String register=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
%>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE1%> class="TABLE_STYLE1" id=theObjTable>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","工单制定人")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="37.4%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="designer" type="text" style="width: 35%; "></td>
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","出库单编号集合")%> </td>
	 <td <%=TD_STYLE21%> class="TD_STYLE2" width="37.4%"><input name="choice_group" type="hidden" style="width: 50%; " value="<%=choice_group%>"><input name="pay_ID_group" type="hidden" style="width: 50%; " value="<%=pay_ID_group%>"><%=pay_ID_group%>&nbsp;</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","登记人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="37.4%"><input <%=INPUT_STYLE1%> class="INPUT_STYLE1" name="register" type="text" style="width: 35%; " value="<%=exchange.toHtml(register)%>"></td>
<td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","登记时间")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="37.4%"><input name="register_time" type="hidden" style="width: 50%; " value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","产品编号")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="37.4%"><input name="product_ID" type="hidden" value="<%=product_ID%>"><%=product_ID%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","产品名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="37.4%"><input name="product_name" type="hidden" value="<%=exchange.toHtml(product_name)%>"><%=exchange.toHtml(product_name)%>&nbsp;</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","描述")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="37.4%"><input name="product_describe" type="hidden" value="<%=product_describe%>"><%=product_describe%>&nbsp;</td>
<td <%=TD_STYLE11%> class="TD_STYLE1" width="11%"><%=demo.getLang("erp","数量")%> </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="37.4%"><input name="amount" type="hidden" value="<%=amount%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerAmountPrecision")).format(amount)%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE7" width="11%" height="65"><%=demo.getLang("erp","备注")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="37.4%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark"></textarea>
</td>
<td <%=TD_STYLE11%> class="TD_STYLE7" width="11%" height="65">&nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="37.4%">&nbsp;</td>
 </tr>
</table>
</div>
</form>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
 
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
	 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></div>
 </td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","要派工生产的产品数量为0，不能生成派工单，请返回。")%></td>
 </tr>
 </table>
</div>
<%
}
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
	 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></div>
 </td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","请选择产品编号一致的生产计划明细记录，请返回。")%></td>
 </tr>
 </table>
</div>
<%
}	
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
	 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></div>
 </td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","您没有选择生产计划明细，请返回。")%></td>
 </tr>
 </table>
 </div>
<%}%>