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
<%nseer_db fund_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db fund_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db funddb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
	 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<%
String fund_ID=request.getParameter("fund_ID") ;
String config_id=request.getParameter("config_id");
String gather_time=request.getParameter("gather_time");
String checker=(String)session.getAttribute("realeditorc");
String checker_ID=(String)session.getAttribute("human_IDD");
String sql9="select * from fund_workflow where object_ID='"+fund_ID+"' and check_tag='0' and gather_time='"+gather_time+"' and config_id<'"+config_id+"'";
ResultSet rs9=funddb.executeQuery(sql9);
if(!rs9.next()){
String sql8="select * from fund_executing where fund_ID='"+fund_ID+"' and check_tag='0' order by details_number";
	ResultSet rs8=fund_db.executeQuery(sql8);
	if(rs8.next()){
String register_ID="";
String fund_chain_ID="";
try{
String sql3="select * from fund_config_fund_kind where responsible_person_ID like '%"+register_ID+"%'";
ResultSet rs3=fund_db.executeQuery(sql3);
while(rs3.next()){
	fund_chain_ID+=rs3.getString("file_ID")+",";
}
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String sql="select * from fund_fund where fund_ID='"+fund_ID+"'";
ResultSet rs=fund_db1.executeQuery(sql);
if(rs.next()){
%>
<script type="text/javascript" src="../../dwr/engine.js"></script>
<script type="text/javascript" src="../../dwr/util.js"></script>
<script type="text/javascript" src="../../dwr/interface/multiLangValidate.js"></script>
<script type="text/javascript" src="../../dwr/interface/validateV7.js"></script>
<script type="text/javascript" src="../../dwr/interface/Multi.js"></script>
<script type="text/javascript" src="../../javascript/include/validate/validation-framework.js"></script>
<script language="javascript">
function TwoSubmit(form){
if (form.Ref[0].checked){
form.action = "check_delete_reconfirm.jsp?config_id=<%=config_id%>&fund_ID=<%=rs.getString("fund_ID")%>&gather_time=<%=rs.getString("gather_time")%>";
}else{
form.action = "../../fund_gather_check_ok?config_id=<%=config_id%>&fund_ID=<%=rs.getString("fund_ID")%>&gather_time=<%=rs.getString("gather_time")%>";
}
}
</script>
<form id="mutiValidation" method="POST" onSubmit="return doValidate('../../xml/fund/fund_fund.xml','mutiValidation')&&TwoSubmit(this)">
 <table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=cop checked><%=demo.getLang("erp","未通过")%> <INPUT name="Ref" type="radio" <%=RADIO_STYLE1%> class="RADIO_STYLE1" value=Ind> 
 <%=demo.getLang("erp","通过")%>&nbsp;<input type="submit" <%=SUBMIT_STYLE1%> class="SUBMIT_STYLE1" value="<%=demo.getLang("erp","确认")%>" name="B1">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></div></td> 
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
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","收款单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
 <table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","执行单编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3" width="89%"><input name="fund_ID" type="hidden" value="<%=rs.getString("fund_ID")%>"><%=fund_ID%></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","责任人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("designer"))%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","理由")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("apply_ID_group"))%>&nbsp;</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","付款人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="funder" type="hidden" value="<%=exchange.toHtml(rs.getString("funder"))%>"><%=exchange.toHtml(rs.getString("funder"))%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","币种")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="currency_name" type="hidden" value="<%=exchange.toHtml(rs.getString("currency_name"))%>"><%=exchange.toHtml(rs.getString("currency_name"))%>&nbsp;</td>
	</tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
 <TABLE <%=TABLE_STYLE5%> class="TABLE_STYLE5">
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="5%"><%=demo.getLang("erp","序号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="20%"><%=demo.getLang("erp","账户")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","账号")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","未收金额")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","本次收款方式")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","票据号码")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","本次收款金额")%></td>
 </tr>
<%
int i=1;
String design_ID="";
String sql6="select * from fund_executing where fund_ID='"+fund_ID+"' and check_tag='0' order by details_number";
	ResultSet rs6=fund_db.executeQuery(sql6);
	while(rs6.next()){
		if(fund_chain_ID.indexOf(rs6.getString("fund_chain_ID"))!= -1){
%>
<input name="fund_chain_ID" type="hidden" value="<%=rs6.getString("fund_chain_ID")%>">
<input name="fund_chain_name" type="hidden" value="<%=exchange.toHtml(rs6.getString("fund_chain_name"))%>">
<input name="account_bank" type="hidden" value="<%=exchange.toHtml(rs6.getString("account_bank"))%>">
<input name="account_ID" type="hidden" value="<%=rs6.getString("account_ID")%>">
<input name="cost_price_subtotal" type="hidden" value="<%=exchange.toHtml(rs6.getString("cost_price_subtotal"))%>">
<input name="executed_cost_price_subtotal" type="hidden" value="<%=exchange.toHtml(rs6.getString("executed_cost_price_subtotal"))%>">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=i%><input name="details_number" type="hidden" style="width: 100%;background-color:#C9E7DC" value="<%=rs6.getString("details_number")%>"><input name="id" type="hidden" style="width: 100%;background-color:#C9E7DC" value="<%=rs6.getString("id")%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("fund_chain_ID")%>/<%=exchange.toHtml(rs6.getString("fund_chain_name"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("account_ID")%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("cost_price_subtotal")-rs6.getDouble("executed_cost_price_subtotal"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><select <%=SELECT_STYLE1%> class="SELECT_STYLE1" name="execute_method">
  <%
  String sql4 = "select * from fund_config_public_char where kind='收付款方式'" ;
	 ResultSet rs4 = funddb.executeQuery(sql4) ;
while(rs4.next()){
	if(rs4.getString("type_name").equals(rs6.getString("execute_method"))){%>
		<option value="<%=exchange.toHtml(rs4.getString("type_name"))%>" selected><%=exchange.toHtml(rs4.getString("type_name"))%></option>
<%}else{%>
		<option value="<%=exchange.toHtml(rs4.getString("type_name"))%>"><%=exchange.toHtml(rs4.getString("type_name"))%></option>
<%
	}
}
%>
  </select></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="bill_ID" type="text" value="<%=rs6.getString("bill_ID")%>"></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="subtotal" type="text" value="<%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("subtotal"))%>"></td>
 </tr>
<%
	i++;
		}
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
	<td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","金额")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="demand_cost_price_sum" type="hidden" value="<%=rs.getString("demand_cost_price_sum")%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("demand_cost_price_sum"))%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","已收金额")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="personal_unit" type="hidden" value="<%=rs.getString("personal_unit")%>"><input name="executed_cost_price_sum" type="hidden" value="<%=rs.getString("executed_cost_price_sum")%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("executed_cost_price_sum"))%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","审核人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="checker" type="text" value="<%=exchange.toHtml(checker)%>"><input name="checker_ID" type="hidden" value="<%=checker_ID%>"></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","审核时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="check_time" type="hidden" value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%>&nbsp;</td>
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
<%}}else{%>
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
fund_db.close();
funddb.close();
fund_db1.close();
%>