<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseerdb.*,include.nseer_cookie.exchange,java.text.*"%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db intrmanufacture_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db intrmanufacturedb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String intrmanufacture_ID=request.getParameter("intrmanufacture_ID");
String checker=(String)session.getAttribute("realeditorc");
String checker_ID=(String)session.getAttribute("human_IDD");
String config_ID=request.getParameter("config_ID") ;
String invoice_time=request.getParameter("invoice_time");
String sql9="select * from intrmanufacture_workflow where object_ID='"+intrmanufacture_ID+"' and check_tag='0' and invoice_time='"+invoice_time+"' and config_ID<'"+config_ID+"'";
ResultSet rs9=intrmanufacturedb.executeQuery(sql9);
if(!rs9.next()){
String sql8="select * from intrmanufacture_purchasing where intrmanufacture_ID='"+intrmanufacture_ID+"' and check_tag='0' and kind='发票' order by id";
ResultSet rs8=intrmanufacture_db.executeQuery(sql8);
if(rs8.next()){
	try{
		String sql = "select * from intrmanufacture_intrmanufacture where intrmanufacture_ID='"+intrmanufacture_ID+"'" ;
		ResultSet rs7 = intrmanufacture_db.executeQuery(sql) ;
		if(rs7.next()){
		double demand_cost_price_sum=rs7.getDouble("demand_cost_price_sum");
		double invoiced_sum=rs7.getDouble("invoiced_sum");
%>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<script type="text/javascript" src="../../dwr/engine.js"></script>
<script type="text/javascript" src="../../dwr/util.js"></script>
<script type="text/javascript" src="../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../dwr/interface/validateV7.js"></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<script language="javascript">
function TwoSubmit(form){
if (form.Ref[0].checked){
form.action = "check_delete_reconfirm.jsp?intrmanufacture_ID=<%=rs7.getString("intrmanufacture_ID")%>&config_ID=<%=config_ID%>&invoice_time=<%=rs7.getString("invoice_time")%>";
}else{
form.action = "../../intrmanufacture_invoice_check_ok?intrmanufacture_ID=<%=rs7.getString("intrmanufacture_ID")%>&config_ID=<%=config_ID%>&invoice_time=<%=rs7.getString("invoice_time")%>";
}
}
</script>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<form id="mutiValidation" method="POST" onSubmit="return doValidate('../../xml/intrmanufacture/intrmanufacture_purchasing.xml','mutiValidation')&&TwoSubmit(this)">
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8"><INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=cop checked> <%=demo.getLang("erp","未通过")%> <INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=Ind> <%=demo.getLang("erp","通过")%> 
 <input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确认")%>" name="B1"> <input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></td>
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
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="5%"><%=demo.getLang("erp","序号")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","委外厂商名称")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","委外厂商编号")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="8%"><%=demo.getLang("erp","联系人")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="8%"><%=demo.getLang("erp","电话")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","应开票金额")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","已收到发票金额")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","本次收到金额")%></td>
 </tr>
<%
	int i=1;
String sql6="select * from intrmanufacture_purchasing where intrmanufacture_ID='"+intrmanufacture_ID+"' and check_tag='0' and kind='发票' order by provider_ID,id";
ResultSet rs6=intrmanufacture_db.executeQuery(sql6);
while(rs6.next()){
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=i%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="id" type="hidden" value="<%=rs6.getString("id")%>"><input name="provider_name" type="hidden" value="<%=exchange.toHtml(rs6.getString("provider_name"))%>"><%=exchange.toHtml(rs6.getString("provider_name"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="provider_ID" type="hidden" value="<%=rs6.getString("provider_ID")%>"><%=rs6.getString("provider_ID")%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="real_contact_person" value="<%=exchange.toHtml(rs6.getString("real_contact_person"))%>"></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="real_contact_person_tel" value="<%=exchange.toHtml(rs6.getString("real_contact_person_tel"))%>"></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="demand_cost_price_sum" type="hidden" value="<%=exchange.toHtml(rs6.getString("demand_cost_price_sum"))%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("demand_cost_price_sum"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="invoiced_sum" type="hidden" value="<%=exchange.toHtml(rs6.getString("invoiced_sum"))%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("invoiced_sum"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input type="text" <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="invoicing_sum" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("invoicing_sum"))%>"></td>
<input name="remark" type="hidden" value="<%=rs6.getString("remark")%>">
 </tr>
<%
	i++;
	}
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
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input name="demand_cost_price_sum_all" type="hidden" value="<%=demand_cost_price_sum%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(demand_cost_price_sum)%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","已收到发票总额")%>：</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input name="real_invoiced_sum" type="hidden" value="<%=invoiced_sum%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(invoiced_sum)%>&nbsp;</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","审核人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input type="text" <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="checker" value="<%=exchange.toHtml(checker)%>"><input type="hidden" name="checker_ID" value="<%=exchange.toHtml(checker_ID)%>"></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","审核时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input name="check_time" type="hidden" style="width: 50%; " value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%>&nbsp;</td>
	</tr>
 </table>
<%@include file="../include/paper_bottom.html"%>
 </div>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
 </form>
<%
	}
	intrmanufacture_db.close();
	}
catch (Exception ex){
out.println("error"+ex);
}
}else{
	intrmanufacture_db.close();
	intrmanufacturedb.close();
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
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="check_list.jsp"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","该记录已审核，请返回！")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
</table>
</div>
<%}}else{
intrmanufacture_db.close();
intrmanufacturedb.close();
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
<%}%>