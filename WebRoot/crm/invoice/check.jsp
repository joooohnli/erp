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
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<script type="text/javascript" src="../../dwr/engine.js"></script>
<script type="text/javascript" src="../../dwr/util.js"></script>
<script type="text/javascript" src="../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../dwr/interface/validateV7.js"></script>
<%
String reasonexact=request.getParameter("order_ID") ;
String config_id=request.getParameter("config_id");
String which_time=request.getParameter("which_time");
String checker=(String)session.getAttribute("realeditorc");
String checker_ID=(String)session.getAttribute("human_IDD");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String sql9="select * from crm_workflow where object_ID='"+reasonexact+"' and check_tag='0' and which_time='"+which_time+"' and config_id<'"+config_id+"'";
ResultSet rs9=crmdb.executeQuery(sql9);
if(!rs9.next()){
String sql8="select * from crm_ordering where reasonexact='"+reasonexact+"' and check_tag='0'";
ResultSet rs8=crm_db.executeQuery(sql8);
if(rs8.next()){
try{
String sql="select * from crm_ordering where reasonexact='"+reasonexact+"' and check_tag='0'";
ResultSet rs=crmdb.executeQuery(sql);
if(rs.next()){
	String invoice_group=rs.getString("invoice_group");
%>
<script language="javascript">
function TwoSubmit(form){
if (form.Ref[0].checked){
form.action = "check_delete_reconfirm.jsp?config_id=<%=config_id%>&order_ID=<%=rs.getString("reasonexact")%>&which_time=<%=which_time%>";
}else{
form.action = "../../crm_invoice_check_ok?config_id=<%=config_id%>&order_ID=<%=rs.getString("reasonexact")%>&which_time=<%=which_time%>";
}
}
</script>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<form id="mutiValidation" method="POST" onSubmit="return doValidate('../../xml/crm/crm_ordering.xml','mutiValidation')&&TwoSubmit(this)">
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=cop checked><%=demo.getLang("erp","未通过")%> <INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=Ind> 
 <%=demo.getLang("erp","通过")%> <input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确认")%>" name="B1"> <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></div></td>
 </tr>
 </table>
<input name="real_customer_mailing_address" type="hidden" value="<%=exchange.toHtml(rs.getString("real_customer_mailing_address"))%>">
<input name="real_contact_person" type="hidden" value="<%=exchange.toHtml(rs.getString("real_contact_person"))%>">
<input name="reason" type="hidden" value="订单销售">
<input name="real_contact_person_tel" type="hidden" value="<%=exchange.toHtml(rs.getString("real_contact_person_tel"))%>">
<input name="real_contact_person_fax" type="hidden" value="<%=exchange.toHtml(rs.getString("real_contact_person_fax"))%>">
<input name="register" type="hidden" value="<%=exchange.toHtml(rs.getString("register"))%>">
<input type="hidden" name="register_ID" value="<%=rs.getString("register_ID")%>">
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
<td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="customer_ID" type="hidden" width="100%" value="<%=rs.getString("customer_ID")%>"><input name="reasonexact" type="hidden" value="<%=rs.getString("reasonexact")%>"><%=rs.getString("reasonexact")%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","客户名称")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="customer_name" type="hidden" value="<%=exchange.toHtml(rs.getString("customer_name"))%>"><%=exchange.toHtml(rs.getString("customer_name"))%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","发票类型")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="real_invoice_type">
  <%
  String sql1 = "select * from crm_config_public_char where kind='发票类型'" ;
	 ResultSet rs1 = crm_db.executeQuery(sql1) ;
while(rs1.next()){
	if(rs1.getString("type_name").equals(rs.getString("real_invoice_type"))){%>
		<option value="<%=exchange.toHtml(rs1.getString("type_name"))%>" selected><%=exchange.toHtml(rs1.getString("type_name"))%></option>
<%}else{%>
		<option value="<%=exchange.toHtml(rs1.getString("type_name"))%>"><%=exchange.toHtml(rs1.getString("type_name"))%></option>
<%
	}
}
%>
 </select></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","开票时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="check_time" type="hidden" value="<%=exchange.toHtml(time)%>"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="real_invoice_time" onFocus="" id="date_start" value="<%=rs.getString("real_invoice_time")%>"></td>
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
String sql6="select * from crm_ordering where reasonexact='"+reasonexact+"' and check_tag='0' order by details_number";
ResultSet rs6=crmdb.executeQuery(sql6);
while(rs6.next()){
	double invoiced_subtotal=0.0d;
	String sql7="select * from crm_order_details where order_ID='"+reasonexact+"' and details_number='"+rs6.getString("details_number")+"'";
	ResultSet rs7=crm_db.executeQuery(sql7);
	if(rs7.next()){
		invoiced_subtotal=rs7.getDouble("invoiced_subtotal");
	}
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=i%>
 <input name="id<%=i%>" type="hidden"  value="<%=rs6.getString("id")%>">
 <input name="details_number<%=i%>" type="hidden"  value="<%=rs6.getString("details_number")%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">
 <input name="product_ID<%=i%>" type="hidden" width="100%" value="<%=rs6.getString("product_ID")%>"><%=rs6.getString("product_ID")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">
 <input name="product_name<%=i%>" type="hidden" width="100%" value="<%=exchange.toHtml(rs6.getString("product_name"))%>"><%=exchange.toHtml(rs6.getString("product_name"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">
 <input name="unit<%=i%>" type="hidden" width="100%" value="<%=exchange.toHtml(rs6.getString("unit"))%>">&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">
 <input name="subtotal<%=i%>" type="hidden" width="100%" value="<%=rs6.getString("subtotal")%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("subtotal"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">
 <input name="invoiced_subtotal<%=i%>" type="hidden" width="100%" value="<%=invoiced_subtotal%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(invoiced_subtotal)%>&nbsp;</td>
<%if(rs6.getDouble("subtotal")==invoiced_subtotal&&rs6.getDouble("subtotal")!=0){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
<%}else{%>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="invoice_sum<%=i%>" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("invoice_sum"))%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="remark<%=i%>" value="<%=rs6.getString("remark")%>"></td>
<%}%>
 </tr>
<%
	i++;
	}
%>
<input name="product_amount" type="hidden"  value="<%=i-1%>">
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<TABLE <%=TABLE_STYLE4%> class="TABLE_STYLE4">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","审核人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="checker" value="<%=exchange.toHtml(checker)%>"></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","审核时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input type="hidden" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="checker_ID" value="<%=checker_ID%>"><%=exchange.toHtml(time)%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","发票号码")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3" width="89%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="invoice_group" value="<%=exchange.toHtml(invoice_group)%>"></td> 
 </tr>
</table>
<%@include file="../include/paper_bottom.html"%>
</div>
 <input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form>
<%
	}
}
catch (Exception ex){
out.println("error"+ex);
}
}else{
%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="check_list.jsp"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","该记录已审核，请返回！")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
</table>
</div>
<%}}else{%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="check_list.jsp"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","前面尚有审核流程未完成，请返回")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
</table>
</div>
<%}
crm_db.close();
crmdb.close();
%>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>