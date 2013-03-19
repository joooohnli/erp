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
<%nseer_db fund_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@ page import="include.anti_repeat_submit.Globals"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>

<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="../../javascript/calendar/calendar-win2k-cold-1.css">
<script type="text/javascript" src="../../javascript/calendar/cal.js"></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<script type="text/javascript" src="../../dwr/engine.js"></script>
<script type="text/javascript" src="../../dwr/util.js"></script>
<script type="text/javascript" src="../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../dwr/interface/validateV7.js"></script>

 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<%
try{
String fund_ID=request.getParameter("fund_ID");
String[] choice=request.getParameterValues("choice");
if(choice!=null){
String condition="";
String choice_group="";
String apply_ID_group="";
int i;
for(i=0;i<choice.length-1;i++){
	condition=condition+"id='"+choice[i]+"'"+" or ";
	choice_group=choice_group+choice[i]+", ";
}
condition=condition+"id='"+choice[i]+"'";
choice_group=choice_group+choice[i];
String sql = "select distinct chain_ID,chain_name,funder,funder_ID,currency_name,personal_unit,file_chain_ID,file_chain_name,executing_cost_price_sum from fund_fund where "+condition+"" ;
ResultSet rs = fund_db.executeQuery(sql) ;
rs.last();
int row=rs.getRow();
if(row==1){
	String chain_ID=rs.getString("chain_ID");
	String chain_name=rs.getString("chain_name");
	String funder=rs.getString("funder");
	String funder_ID=rs.getString("funder_ID");
	String currency_name=rs.getString("currency_name");
	String personal_unit=rs.getString("personal_unit");
	String file_chain_ID=rs.getString("file_chain_ID");
	String file_chain_name=rs.getString("file_chain_name");
	String executing_cost_price_sum=rs.getString("executing_cost_price_sum");
	double cost_price_sum1=0.0d;
	double cost_price_sum2=0.0d;
	String sql1="select sum(demand_cost_price_sum) from fund_fund where ("+condition+") and reason='付款'";
	ResultSet rs1 = fund_db.executeQuery(sql1) ;
	if(rs1.next()){
		cost_price_sum1=rs1.getDouble("sum(demand_cost_price_sum)");
	}
	String sql3="select sum(demand_cost_price_sum) from fund_fund where ("+condition+") and reason='收款'";
	ResultSet rs3 = fund_db.executeQuery(sql3) ;
	if(rs3.next()){
		cost_price_sum2=rs3.getDouble("sum(demand_cost_price_sum)");
	}
	double demand_cost_price_sum=cost_price_sum1-cost_price_sum2;
	%>

<form id="register1" method="POST" action="../../fund_fund_registerPay_ok" onSubmit="return doValidate('../../xml/fund/fund_fund.xml','register1')">
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确认")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></div></td> 
 </tr>
 </table>
<%
	String sql2="select * from fund_fund where "+condition+"";
	ResultSet rs2 = fund_db.executeQuery(sql2) ;
	while(rs2.next()){
		if(apply_ID_group.equals("")){
			apply_ID_group=rs2.getString("reasonexact");
		}else if(rs2.getString("reasonexact").indexOf(apply_ID_group)==-1){
			apply_ID_group=apply_ID_group+", "+rs2.getString("reasonexact");
		}
	}
String register=(String)session.getAttribute("realeditorc");
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
%>
<input name="chain_ID" type="hidden" value="<%=chain_ID%>">
<input name="chain_name" type="hidden" value="<%=exchange.toHtml(chain_name)%>">
<input name="file_chain_ID" type="hidden" value="<%=file_chain_ID%>">
<input name="file_chain_name" type="hidden" value="<%=exchange.toHtml(file_chain_name)%>">
<input name="funder" type="hidden" value="<%=exchange.toHtml(funder)%>">
<input name="funder_ID" type="hidden" value="<%=funder_ID%>">
<input name="choice_group" type="hidden" value="<%=exchange.toHtml(choice_group)%>">
<input name="apply_ID_group" type="hidden" value="<%=exchange.toHtml(apply_ID_group)%>">
<input name="executing_cost_price_sum" type="hidden" value="<%=exchange.toHtml(executing_cost_price_sum)%>">

<input type="hidden" name="fund_ID" value="<%=fund_ID%>">
<div id="nseerGround" class="nseerGround">
<%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","付款执行单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
 <table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","责任人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="designer" type="text"></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","付款理由")%>：</td>
<%
if(file_chain_name.indexOf("应收账款")!=-1){
%>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><a href="javascript:winopen('../../crm/order/query_order_ID_group.jsp?order_ID=<%=apply_ID_group%>')"><%=apply_ID_group%></td>
<%}else if(file_chain_name.indexOf("应付账款")!=-1){
	if(apply_ID_group.indexOf("T")==-1){
		if(apply_ID_group.substring(0,2).equals("05")){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><a href="javascript:winopen('../../purchase/purchase/query_purchase_ID_group.jsp?purchase_ID=<%=toUtf8String.utf8String(apply_ID_group)%>')"><%=exchange.toHtml(apply_ID_group)%></td>
	 <%}else if(apply_ID_group.substring(0,2).equals("06")){%>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><a href="javascript:winopen('../../intrmanufacture/intrmanufacture/query_intrmanufacture_ID_group.jsp?intrmanufacture_ID=<%=toUtf8String.utf8String(apply_ID_group)%>')"><%=exchange.toHtml(apply_ID_group)%></td>
	 <%} else{%>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><a href="javascript:winopen('../../logistics/logistics/query_logistics_ID_group.jsp?logistics_ID=<%=toUtf8String.utf8String(apply_ID_group)%>')"><%=exchange.toHtml(apply_ID_group)%></td>
	 <%}}else{%>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><a href="javascript:winopen('../../crm/order/query_order_ID_group.jsp?order_ID=<%=toUtf8String.utf8String(apply_ID_group)%>')"><%=exchange.toHtml(apply_ID_group)%></td>
<%}}else if(file_chain_name.indexOf("工资")!=-1){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(apply_ID_group)%></td>
<%}else{%>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><a href="javascript:winopen('../apply_pay_expenses/query_apply_pay_ID_group.jsp?apply_pay_ID=<%=toUtf8String.utf8String(apply_ID_group)%>')"><%=exchange.toHtml(apply_ID_group)%></td>
<%}%>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","收款人")%>&nbsp;&nbsp;：</td>
<%if(!funder.equals("")){
	if(file_chain_name.indexOf("应付账款")!=-1){
		if(apply_ID_group.substring(0,2).equals("05")){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><a href="javascript:winopen('../../purchase/file/query.jsp?provider_ID=<%=funder_ID%>')"><%=exchange.toHtml(funder)%></td>
	 <%}else if(apply_ID_group.substring(0,2).equals("06")){%>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><a href="javascript:winopen('../../intrmanufacture/file/query.jsp?provider_ID=<%=funder_ID%>')"><%=exchange.toHtml(funder)%></td>
	 <%}else{%>
		 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><a href="javascript:winopen('../../logistics/file/query.jsp?provider_ID=<%=funder_ID%>')"><%=exchange.toHtml(funder)%></td>
	<%
		}}else if(file_chain_name.indexOf("应收账款")!=-1){%>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><a href="javascript:winopen('../../crm/file/query.jsp?customer_ID=<%=funder_ID%>')"><%=exchange.toHtml(funder)%></td>
	 <%}else if(file_chain_name.indexOf("工资")!=-1){%>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(funder)%></td>
	 <%}else{%>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><a href="javascript:winopen('../../hr/file/query.jsp?human_ID=<%=funder_ID%>')"><%=exchange.toHtml(funder)%></td>
<%}}else if(funder.equals("")&&!chain_name.equals("")){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><a href="javascript:winopen('../../hr/config/file/kind_details.jsp?chain_ID=<%=chain_ID%>')"><%=exchange.toHtml(chain_name)%></td>
<%}%>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","金额")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="demand_cost_price_sum" type="hidden" value="<%=demand_cost_price_sum%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(demand_cost_price_sum)%>&nbsp;</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","币种")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="currency_name" type="hidden" value="<%=exchange.toHtml(currency_name)%>"><%=exchange.toHtml(currency_name)%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","单位")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="personal_unit" type="hidden" value="<%=exchange.toHtml(personal_unit)%>"><%=exchange.toHtml(personal_unit)%>&nbsp;</td>
	</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
 <TABLE <%=TABLE_STYLE5%> class="TABLE_STYLE5">
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td width="4%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","序号")%></td>
 <td width="30%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","科目")%></td>
 <td width="14%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","开户行")%></td>
	 <td width="15%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","账号")%></td>
 <td width="11%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","币种/单位")%></td>
	 <td width="11%" <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","付款金额")%></td>
 </tr>
<%
i=1;
String sql6="select * from fund_config_fund_kind where currency_name='"+currency_name+"' and details_tag='0' and parent_category_id!='-1' order by file_id";
ResultSet rs6=fund_db.executeQuery(sql6);
while(rs6.next()){
%>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=i%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="fund_kind" type="hidden" value="<%=rs6.getString("file_ID")%>/<%=exchange.toHtml(rs6.getString("chain_name"))%>"><%=rs6.getString("file_ID")%>/<%=exchange.toHtml(rs6.getString("chain_name"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="account_bank" type="hidden" value="<%=exchange.toHtml(rs6.getString("account_bank"))%>"><%=exchange.toHtml(rs6.getString("account_bank"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="account_ID" type="hidden" value="<%=rs6.getString("account_ID")%>"><%=rs6.getString("account_ID")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="currency" type="hidden" value="<%=exchange.toHtml(rs6.getString("currency_name"))%>/<%=exchange.toHtml(rs6.getString("personal_unit"))%>"><%=exchange.toHtml(rs6.getString("currency_name"))%>/<%=exchange.toHtml(rs6.getString("personal_unit"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="cost_price_subtotal" type="text"></td>
 </tr>
<%
	i++;
	}
	fund_db.close();
%>
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
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="register_time" type="hidden" style="width: 50%; " value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","备注")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
<td colspan="3" <%=TD_STYLE2%> class="TD_STYLE2" width="89%">
<textarea <%=TEXTAREA_STYLE1%> class="TEXTAREA_STYLE1" name="remark"></textarea>
</td>
 </tr>
  </table>
 <%@include file="../include/paper_bottom.html"%>
</div>
<input type="hidden" name="<%=Globals.TOKEN_KEY%>" value="<%=session.getAttribute(Globals.TOKEN_KEY)%>">
</form>
<%
}else{
	fund_db.close();
%>
<div id="nseerGround" class="nseerGround">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","返回")%> onClick="history.back()"></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","请选择收款人分类、收款人编号、科目、币种一致的收付款计划单，请返回。")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
 </table>
</div>
<%
}	
}else{
	fund_db.close();
	%>
<div id="nseerGround" class="nseerGround">
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","返回")%> onClick="history.back()"></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","您没有选择收付款计划单，请返回。")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
 </table>
</div>
<%}
}catch(Exception ex){
	ex.printStackTrace();
}%>
<script type="text/javascript">
Calendar.setup ({inputField : "date_start", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_start", singleClick : true, step : 1});
Calendar.setup ({inputField : "date_end", ifFormat : "%Y-%m-%d", showsTime : false, button : "date_end", singleClick : true, step : 1});
</script>