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
<%nseer_db crm_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db crmdb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<script type="text/javascript" src="../../javascript/include/draft_gar/divReconfirm.js"></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<script type="text/javascript" src="../../dwr/engine.js"></script>
<script type="text/javascript" src="../../dwr/util.js"></script>
<script type="text/javascript" src="../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../dwr/interface/validateV7.js"></script>
<%
String order_ID=request.getParameter("order_ID") ;
String register=(String)session.getAttribute("realeditorc");
String register_ID=(String)session.getAttribute("human_IDD");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
try{
String sql="select * from crm_order where order_ID='"+order_ID+"'";
ResultSet rs=crmdb.executeQuery(sql);
if(rs.next()){
%>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<form id="mutiValidation" method="POST" action="../../crm_invoice_register_ok?id=<%=rs.getString("id")%>" onSubmit="return doValidate('../../xml/crm/crm_ordering.xml','mutiValidation')">
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><%=DgButton.getDraft("'mutiValidation','../../crm_invoice_register_draft_ok?reasonexact="+order_ID+"&&id="+rs.getString("id")+"','../../xml/crm/crm_ordering.xml'",request)%>&nbsp;<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确认")%>"> <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></div></td>
 </tr>
 </table>
 <input name="register_time" type="hidden" value="<%=time%>">
<input name="real_customer_mailing_address" type="hidden" value="<%=exchange.toHtml(rs.getString("demand_customer_mailing_address"))%>">
<input name="real_contact_person" type="hidden" value="<%=exchange.toHtml(rs.getString("demand_contact_person"))%>">
<input name="reason" type="hidden" value="订单销售">
<input name="real_contact_person_tel" type="hidden" value="<%=exchange.toHtml(rs.getString("demand_contact_person_tel"))%>">
<input name="real_contact_person_fax" type="hidden" value="<%=exchange.toHtml(rs.getString("demand_contact_person_fax"))%>">
 <div id="nseerGround" class="nseerGround">
<%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<TABLE <%=TABLE_STYLE4%> class="TABLE_STYLE4">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","订单编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="reasonexact" type="hidden" value="<%=rs.getString("order_ID")%>"><%=rs.getString("order_ID")%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","客户名称")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="customer_name" type="hidden" value="<%=exchange.toHtml(rs.getString("customer_name"))%>"><input name="customer_ID" type="hidden" value="<%=exchange.toHtml(rs.getString("customer_ID"))%>"><%=exchange.toHtml(rs.getString("customer_name"))%>&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","发票类型")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="real_invoice_type">
  <%
  String sql1 = "select * from crm_config_public_char where kind='发票类型'" ;
	 ResultSet rs1 = crm_db.executeQuery(sql1) ;
while(rs1.next()){
	if(rs1.getString("type_name").equals(rs.getString("demand_invoice_type"))){%>
		<option value="<%=exchange.toHtml(rs1.getString("type_name"))%>" selected><%=exchange.toHtml(rs1.getString("type_name"))%></option>
<%}else{%>
		<option value="<%=exchange.toHtml(rs1.getString("type_name"))%>"><%=exchange.toHtml(rs1.getString("type_name"))%></option>
<%
	}
}
%>
  </select></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","开票时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="real_invoice_time" onFocus="" id="date_start"></td>
 </tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<TABLE <%=TABLE_STYLE5%> class="TABLE_STYLE5">  
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="4%"><%=demo.getLang("erp","序号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","商品编号")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","商品名称")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","单位")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","应开票额度")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","已开票额度")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","本次开票额度")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","备注")%></td>
 </tr>
<%
int i=1;
String sql6="select * from crm_order_details where order_ID='"+rs.getString("order_ID")+"' order by details_number";
ResultSet rs6=crm_db.executeQuery(sql6);
while(rs6.next()){
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("details_number")%><input name="details_number<%=i%>" type="hidden"  value="<%=rs6.getString("details_number")%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="product_ID<%=i%>" type="hidden" width="100%" value="<%=rs6.getString("product_ID")%>"><%=rs6.getString("product_ID")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="product_name<%=i%>" type="hidden" width="100%" value="<%=exchange.toHtml(rs6.getString("product_name"))%>"><%=exchange.toHtml(rs6.getString("product_name"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="amount_unit<%=i%>" type="hidden" width="100%" value="<%=exchange.toHtml(rs6.getString("amount_unit"))%>">&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="subtotal<%=i%>" type="hidden" width="100%" value="<%=rs6.getString("subtotal")%>"><%=rs6.getDouble("subtotal")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="invoiced_subtotal<%=i%>" type="hidden" width="100%" value="<%=rs6.getString("invoiced_subtotal")%>"><%=rs6.getDouble("invoiced_subtotal")%>&nbsp;</td>
<%if(rs6.getString("subtotal").equals(rs6.getString("invoiced_subtotal"))){%>
	 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
<%}else{%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="invoice_sum<%=i%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="remark<%=i%>"></td>
<%}%>
 </tr>
<%
	i++;
	}
	crm_db.close();
%>
<input name="product_amount" type="hidden" style="width: 100%" value="<%=i-1%>">
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<TABLE <%=TABLE_STYLE4%> class="TABLE_STYLE4"> 
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","开票人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register" value="<%=exchange.toHtml(register)%>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","开票人编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register_ID" value="<%=register_ID%>"></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","发票号码")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3" width="89%">
 <input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="invoice_group"></td> 
 </tr>
</table>
<%@include file="../include/paper_bottom.html"%>
</div>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form>
<%
}
crmdb.close();
}
catch (Exception ex){
out.println("error"+ex);
}
%>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>