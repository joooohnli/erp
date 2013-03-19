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
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db fund_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db funddb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1">
 <div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<%
String fund_ID=request.getParameter("fund_ID");
String details_number=request.getParameter("details_number");
try{
	String sql = "select * from fund_fund where fund_ID='"+fund_ID+"'" ;
	ResultSet rs = funddb.executeQuery(sql) ;
	if(rs.next()){
String check_tag="";
String fund_tag="";
String execute_tag="";
String color="#FF9A31";
String color1="#FF9A31";
String color2="#FF9A31";

if(rs.getString("check_tag").equals("0")){
check_tag="等待审核";
}else if(rs.getString("check_tag").equals("1")){
check_tag="审核通过";
color1="3333FF";
}else if(rs.getString("check_tag").equals("9")){
check_tag="审核未通过";
color1="red";
}
if(rs.getString("execute_tag").equals("0")){
execute_tag="等待";
}else if(rs.getString("execute_tag").equals("1")){
execute_tag="执行";
color2="mediumseagreen";
}else if(rs.getString("execute_tag").equals("2")){
execute_tag="完成";
color2="3333FF";
}
if(rs.getString("check_tag").equals("1")&&rs.getString("fund_tag").equals("0")){
fund_tag="执行";
color="mediumseagreen";
}else if(rs.getString("check_tag").equals("1")&&rs.getString("fund_tag").equals("1")){
fund_tag="完成";
color="3333FF";
}else if(rs.getString("check_tag").equals("0")||rs.getString("check_tag").equals("9")){
fund_tag="等待";
}
%>
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","返回")%> onClick="history.back();"></div></td>
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
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","责任人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("designer"))%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","理由")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("apply_ID_group"))%>&nbsp;</td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","收款人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=exchange.toHtml(rs.getString("funder"))%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","金额")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("demand_cost_price_sum"))%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","币种")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=exchange.toHtml(rs.getString("currency_name"))%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","单位")%>&nbsp;&nbsp;&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=exchange.toHtml(rs.getString("personal_unit"))%>&nbsp;</td>
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
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="22%"><%=demo.getLang("erp","账户")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","账号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="6%"><%=demo.getLang("erp","付款方式")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="10%"><%=demo.getLang("erp","票据号码")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="12%"><%=demo.getLang("erp","付款时间")%></td>
<%if(rs.getString("reason").equals("付款")){%>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="10%"><%=demo.getLang("erp","本次付款金额")%></td>
<%}else{%>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="10%"><%=demo.getLang("erp","本次付款金额")%></td>
<%}%>
 </tr>
<%
int i=1;
String sql6="select * from fund_executing where fund_ID='"+fund_ID+"' and details_number='"+details_number+"' and check_tag='1' order by register_time";
ResultSet rs6=fund_db.executeQuery(sql6);
while(rs6.next()){
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=i%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("fund_chain_ID")%>/<%=exchange.toHtml(rs6.getString("fund_chain_name"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("account_ID")%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("execute_method"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("bill_ID")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("check_time"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("subtotal"))%>&nbsp;</td>
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
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","登记人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("register"))%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("register_time"))%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","审核人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><%=exchange.toHtml(rs.getString("checker"))%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","审核时间")%>：</td>
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
	fund_db.close();
	funddb.close();
}
catch (Exception ex){
out.println("error"+ex);
}
%>