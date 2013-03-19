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
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db fund_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db funddb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<%
String apply_pay_ID_group=request.getParameter("apply_pay_ID") ;
StringTokenizer tokenTO = new StringTokenizer(apply_pay_ID_group,","); 
 while(tokenTO.hasMoreTokens()) {
				String apply_pay_ID=tokenTO.nextToken();
try{
String sql="select * from fund_apply_pay where apply_pay_ID='"+apply_pay_ID+"'";
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
 <td <%=TD_STYLE3%> class="TD_STYLE3" class="Noprint"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><OBJECT id=WebBrowser classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2 height=0 width=0></OBJECT><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","打印")%> onclick="javascript:window.print()">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","页面设置")%> onclick=document.all.WebBrowser.ExecWB(8,1)>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","打印预览")%>" onclick=document.all.WebBrowser.ExecWB(7,1)></div></td>
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
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","费用申请单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
 <table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","申请单编号")%>：</td>
 <td colspan="3" <%=TD_STYLE2%> class="TD_STYLE2" width="89%"><input name="apply_pay_ID" type="hidden" value="<%=rs.getString("apply_pay_ID")%>"><%=rs.getString("apply_pay_ID")%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","机构")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("chain_name"))%></td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","员工")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
<%if(rs.getString("human_ID").equals("")){%>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%">&nbsp;</td>
<%}else{%>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=rs.getString("human_ID")%>/<%=rs.getString("human_name")%>&nbsp;</td>
<%}%>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","币种/单位")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("currency_name"))%>/<%=exchange.toHtml(rs.getString("personal_unit"))%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","总金额")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("demand_cost_price_sum"))%>&nbsp;</td>
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
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="60%"><%=demo.getLang("erp","科目")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="24%"><%=demo.getLang("erp","金额")%></td>
 </tr>
<%
	int count=0;
	String sql5="select count(*) from fund_apply_pay_details where apply_pay_ID='"+apply_pay_ID+"'";
ResultSet rs5=fund_db.executeQuery(sql5);
while(rs5.next()){
	count=rs5.getInt("count(*)");
}
if(count>20){
	int m=1;
String sql6="select * from fund_apply_pay_details where apply_pay_ID='"+apply_pay_ID+"'";
ResultSet rs6=fund_db.executeQuery(sql6);
while(m<=20){
	rs6.next();
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("details_number")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("file_chain_ID")%>/<%=exchange.toHtml(rs6.getString("file_chain_name"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("cost_price_subtotal"))%>&nbsp;</td>
 </tr>
<%
	m++;
	}
%>
</table>
<%=demo.getLang("erp","接下页")%>
&nbsp;
<div class="PageNext"></div>
&nbsp;
<%=demo.getLang("erp","承上页")%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2"><%
for(int j=0;j<count-20;j++){
rs6.next();
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("details_number")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("file_chain_ID")%>/<%=exchange.toHtml(rs6.getString("file_chain_name"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("cost_price_subtotal"))%>&nbsp;</td>
 </tr>
<%
	m++;
}
	 %>
</table>
<%}else{
		 int m=1;
String sql6="select * from fund_apply_pay_details where apply_pay_ID='"+apply_pay_ID+"'";
ResultSet rs6=fund_db.executeQuery(sql6);
while(rs6.next()){		 
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("details_number")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("file_chain_ID")%>/<%=exchange.toHtml(rs6.getString("file_chain_name"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("cost_price_subtotal"))%>&nbsp;</td>
 </tr>
<%
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
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","登记人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="register" type="hidden" value="<%=exchange.toHtml(rs.getString("register"))%>"><%=exchange.toHtml(rs.getString("register"))%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><input name="register_time" type="hidden" onfocus="setday(this)" value="<%=exchange.toHtml(rs.getString("register_time"))%>"><%=exchange.toHtml(rs.getString("register_time"))%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","审批人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("checker"))%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","审批时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("check_time"))%>&nbsp;</td>
 </tr>
	 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","备注")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3" width="89%"><%=rs.getString("remark")%>&nbsp;</td>
 </tr>
 </table>
<%@include file="../include/paper_bottom.html"%>
</div>
<%
}
}
catch (Exception ex){
out.println("error"+ex);
}
			}
fund_db.close();
funddb.close();
%>