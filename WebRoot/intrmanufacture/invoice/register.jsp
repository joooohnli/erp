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
<%nseer_db intrmanufacture_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db intrmanufacturedb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<script type="text/javascript" src="../../javascript/include/draft_gar/divReconfirm.js"></script>
<script type="text/javascript" src="../../dwr/engine.js"></script>
<script type="text/javascript" src="../../dwr/util.js"></script>
<script type="text/javascript" src="../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../dwr/interface/validateV7.js"></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<%
String intrmanufacture_ID=request.getParameter("intrmanufacture_ID");
String register=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String sql7="select * from intrmanufacture_intrmanufacture where intrmanufacture_ID='"+intrmanufacture_ID+"'";
ResultSet rs7=intrmanufacture_db.executeQuery(sql7);
if(rs7.next()){
	double demand_cost_price_sum=rs7.getDouble("demand_cost_price_sum");
	double invoiced_sum=rs7.getDouble("invoiced_sum");
%>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<form id="mutiValidation" method="POST" action="../../intrmanufacture_invoice_register_ok" onSubmit="return doValidate('../../xml/intrmanufacture/intrmanufacture_purchasing.xml','mutiValidation')">
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><%=DgButton.getDraft("'mutiValidation','../../intrmanufacture_invoice_register_draft_ok','../../xml/intrmanufacture/intrmanufacture_purchasing.xml'",request)%>&nbsp;<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","提交")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="register_list.jsp"></div></td> 
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
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","发票登记单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","执行单编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="87%" colspan="3"><input type="hidden" name="intrmanufacture_ID" value="<%=intrmanufacture_ID%>"><%=intrmanufacture_ID%></td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","产品编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input name="product_ID" type="hidden" value="<%=rs7.getString("product_ID")%>"><%=rs7.getString("product_ID")%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","产品名称")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input name="product_name" type="hidden" value="<%=exchange.toHtml(rs7.getString("product_name"))%>"><%=exchange.toHtml(rs7.getString("product_name"))%>&nbsp;</td>
 </tr>
</table>

<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>  
<table <%=TABLE_STYLE5%> class="TABLE_STYLE5">
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2"width="11%"><%=demo.getLang("erp","委外厂商名称")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"width="13%"><%=demo.getLang("erp","委外厂商编号")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"width="8%"><%=demo.getLang("erp","联系人")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"width="8%"><%=demo.getLang("erp","电话")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"width="11%"><%=demo.getLang("erp","应开票金额")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"width="13%"><%=demo.getLang("erp","已收到发票金额")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"width="11%"><%=demo.getLang("erp","本次收到金额")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"width="8%">&nbsp;</td>
 </tr>
<%
	int i=1;
String sql6="select * from intrmanufacture_details where intrmanufacture_ID='"+intrmanufacture_ID+"' order by details_number";
ResultSet rs6=intrmanufacturedb.executeQuery(sql6);
while(rs6.next()){
	if(rs6.getString("invoice_check_tag").equals("0")&&rs6.getString("invoice_tag").equals("0")){
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="provider_name" type="hidden" value="<%=exchange.toHtml(rs6.getString("provider_name"))%>"><%=exchange.toHtml(rs6.getString("provider_name"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="provider_ID" type="hidden" value="<%=rs6.getString("provider_ID")%>"><%=rs6.getString("provider_ID")%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="real_contact_person" value="<%=exchange.toHtml(rs6.getString("demand_contact_person"))%>"></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="real_contact_person_tel" type="text" value="<%=exchange.toHtml(rs6.getString("demand_contact_person_tel"))%>"></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="demand_cost_price_sum1" type="hidden" value="<%=exchange.toHtml(rs6.getString("demand_cost_price_sum"))%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("demand_cost_price_sum"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="invoiced_sum1" type="hidden" value="<%=exchange.toHtml(rs6.getString("invoiced_sum"))%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("invoiced_sum"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="invoicing_sum"></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"></td>
<input name="remark" type="hidden">
 </tr>
<%}else if(rs6.getString("invoice_check_tag").equals("1")&&rs6.getString("invoice_tag").equals("0")){
	String sql8="select * from intrmanufacture_purchasing where intrmanufacture_ID='"+intrmanufacture_ID+"' and provider_ID='"+rs6.getString("provider_ID")+"' and check_tag='0' and kind='发票'";
	ResultSet rs8=intrmanufacture_db.executeQuery(sql8);
 while(rs8.next()){
	%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs8.getString("provider_name"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs8.getString("provider_ID")%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs8.getString("real_contact_person"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs8.getString("real_contact_person_tel"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs8.getDouble("demand_cost_price_sum"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs8.getDouble("invoiced_sum"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs8.getDouble("invoicing_sum"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","等待审核")%></td>
 </tr>
<%
	}
}else{
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("provider_name"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("provider_ID")%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("demand_cost_price_sum"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("invoiced_sum"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","完成")%></td>
 </tr>
<%
}
i++;
	}
intrmanufacturedb.close();
	intrmanufacture_db.close();
%>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","应开票总额")%>：</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input name="demand_cost_price_sum" type="hidden" style="width: 50%; " value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(demand_cost_price_sum)%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(demand_cost_price_sum)%>&nbsp;</td>
	
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","已收到发票总额")%>：</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input name="real_invoiced_sum" type="hidden" style="width: 50%; " value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(invoiced_sum)%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(invoiced_sum)%>&nbsp;</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","登记人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register" value="<%=exchange.toHtml(register)%>"></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input name="register_time" type="hidden" style="width: 50%; " value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%>&nbsp;</td>
	</tr>
 </table>
<%@include file="../include/paper_bottom.html"%>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
 </form>
<%}%>
 </div>