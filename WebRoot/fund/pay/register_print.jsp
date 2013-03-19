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
<%nseer_db funddb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<%
String fund_ID=request.getParameter("fund_ID") ;
String register=(String)session.getAttribute("realeditorc");
String register_ID=(String)session.getAttribute("human_IDD");
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
ResultSet rs=funddb.executeQuery(sql);
if(rs.next()){
%>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><OBJECT id=WebBrowser classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2 height=0 width=0></OBJECT><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","打印")%> onclick="javascript:window.print()">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","页面设置")%> onclick=document.all.WebBrowser.ExecWB(8,1)>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","打印预览")%> onclick=document.all.WebBrowser.ExecWB(7,1)></div></td>
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
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","付款单")%></b></font></td>
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
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="89%" colspan="3"><input name="fund_ID" type="hidden" value="<%=rs.getString("fund_ID")%>"><%=fund_ID%></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","责任人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("designer"))%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","理由")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("apply_ID_group"))%>&nbsp;</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","收款人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="funder" type="hidden" value="<%=exchange.toHtml(rs.getString("funder"))%>"><%if(!rs.getString("funder").equals("")){%>
 <%=exchange.toHtml(rs.getString("funder"))%></td>
<%}else if(rs.getString("funder").equals("")&&!rs.getString("chain_name").equals("")){%>
 <%=exchange.toHtml(rs.getString("chain_name"))%></td>
<%}%>&nbsp;</td>
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
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="22%"><%=demo.getLang("erp","账户")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","账号")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","未付金额")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","本次付款方式")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","票据号码")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","本次付款金额")%></td>
 </tr>
<%
	int count=0;
	String sql5="select count(*) from fund_details where fund_ID='"+fund_ID+"' order by details_number";
ResultSet rs5=fund_db.executeQuery(sql5);
while(rs5.next()){
	count=rs5.getInt("count(*)");
}
if(count>20){
	int m=1;
String sql6="select * from fund_details where fund_ID='"+fund_ID+"' order by details_number";
ResultSet rs6=fund_db.executeQuery(sql6);
while(m<=20){
	rs6.next();
	if(fund_chain_ID.indexOf(rs6.getString("fund_chain_ID"))!= -1){
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("details_number")%><input name="details_number" type="hidden" style="width: 100%" value="<%=rs6.getString("details_number")%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("fund_chain_ID")%>/<%=exchange.toHtml(rs6.getString("fund_chain_name"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("account_ID")%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("cost_price_subtotal"))%>&nbsp;</td>
<%if(rs6.getString("execute_check_tag").equals("0")&&!rs6.getString("execute_details_tag").equals("2")){%>
	 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="bill_ID" type="text"></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="subtotal" type="text"></td>
<%}else if(rs6.getString("execute_check_tag").equals("1")&&!rs6.getString("execute_details_tag").equals("2")){%>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="execute_method" type="hidden" value="">&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="bill_ID" type="hidden" value="">&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="subtotal" type="hidden" value=""><%=demo.getLang("erp","等待审核")%></td>
<%}else if(rs6.getString("execute_details_tag").equals("2")){%>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="execute_method" type="hidden" value="">&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="bill_ID" type="hidden" value="">&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="subtotal" type="hidden" value=""><%=demo.getLang("erp","完成")%></td>
<%}%>
 </tr>
<%
	}
	m++;
	}
%>
</table>
<%=demo.getLang("erp","接下页")%>
&nbsp;
<div class="PageNext"></div>
&nbsp;
<%=demo.getLang("erp","承上页")%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
<%
for(int j=0;j<count-20;j++){
rs6.next();
if(fund_chain_ID.indexOf(rs6.getString("fund_chain_ID"))!= -1){
%>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("details_number")%><input name="details_number" type="hidden" style="width: 100%" value="<%=rs6.getString("details_number")%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("fund_chain_ID")%>/<%=exchange.toHtml(rs6.getString("fund_chain_name"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("account_ID")%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("cost_price_subtotal"))%>&nbsp;</td>
<%if(rs6.getString("execute_check_tag").equals("0")&&!rs6.getString("execute_details_tag").equals("2")){%>
	 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="bill_ID" type="text"></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="subtotal" type="text"></td>
<%}else if(rs6.getString("execute_check_tag").equals("1")&&!rs6.getString("execute_details_tag").equals("2")){%>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="execute_method" type="hidden" value="">&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="bill_ID" type="hidden" value="">&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="subtotal" type="hidden" value=""><%=demo.getLang("erp","等待审核")%></td>
<%}else if(rs6.getString("execute_details_tag").equals("2")){%>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="execute_method" type="hidden" value="">&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="bill_ID" type="hidden" value="">&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="subtotal" type="hidden" value=""><%=demo.getLang("erp","完成")%></td>
<%}%>
 </tr>
<%
}
	m++;
}
	 	fund_db.close();
	 %>
</table>
<%}else{
		 int m=1;
String sql6="select * from fund_details where fund_ID='"+fund_ID+"' order by details_number";
ResultSet rs6=fund_db.executeQuery(sql6);
while(rs6.next()){
	if(fund_chain_ID.indexOf(rs6.getString("fund_chain_ID"))!= -1){
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("details_number")%><input name="details_number" type="hidden" style="width: 100%" value="<%=rs6.getString("details_number")%>"></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("fund_chain_ID")%>/<%=exchange.toHtml(rs6.getString("fund_chain_name"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("account_ID")%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("cost_price_subtotal"))%>&nbsp;</td>
<%if(rs6.getString("execute_check_tag").equals("0")&&!rs6.getString("execute_details_tag").equals("2")){%>
	 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="bill_ID" type="text"></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE5%> class="INPUT_STYLE5" name="subtotal" type="text"></td>
<%}else if(rs6.getString("execute_check_tag").equals("1")&&!rs6.getString("execute_details_tag").equals("2")){%>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="execute_method" type="hidden" value="">&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="bill_ID" type="hidden" value="">&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="subtotal" type="hidden" value=""><%=demo.getLang("erp","等待审核")%></td>
<%}else if(rs6.getString("execute_details_tag").equals("2")){%>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="execute_method" type="hidden" value="">&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="bill_ID" type="hidden" value="">&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="subtotal" type="hidden" value=""><%=demo.getLang("erp","完成")%></td>
<%}%>
 </tr>
<%
	}
	m++;
}
%>
</table>
<%
	 }
%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","金额")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="demand_cost_price_sum" type="hidden" value="<%=rs.getString("demand_cost_price_sum")%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("demand_cost_price_sum"))%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","已付金额")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="personal_unit" type="hidden" value="<%=exchange.toHtml(rs.getString("personal_unit"))%>"><input name="executed_cost_price_sum" type="hidden" value="<%=rs.getString("executed_cost_price_sum")%>"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("executed_cost_price_sum"))%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","登记人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input <%=INPUT_STYLE3%> class="INPUT_STYLE3" name="register" type="text" value="<%=exchange.toHtml(register)%>"></td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="register_time" type="hidden" onfocus="setday(this)" value="<%=exchange.toHtml(time)%>"><%=exchange.toHtml(time)%>&nbsp;</td>
 </tr>
 </table>
 <%@include file="../include/paper_bottom.html"%>
 </div>
<%
}
	fund_db.close();
	funddb.close();
}
catch (Exception ex){
out.println("error"+ex);
}
%>