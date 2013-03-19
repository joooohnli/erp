<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import="include.nseer_cookie.exchange" import ="include.nseer_db.*,include.nseerdb.*,java.text.*"%>
<%nseer_db stock_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db stockdb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db stock_db1 = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<jsp:useBean id="length" class="stock.getLength" scope="request"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<jsp:useBean id="available" class="stock.getBalanceAmountDetails" scope="request"/><style type="text/css">
<!--
.unnamed1 {
	border: 1px solid #003333;
}
.unnamed2 {
	border: 1px groove #003300;
}
--
</style>
<style media=print> 
.Noprint{display:none;} 
.PageNext{page-break-after: always;} 
</style> 
<style> 
.tdp 
{ 
border-bottom: 1 solid #000000; 
border-left: 1 solid #000000; 
border-right: 0 solid #ffffff; 
border-top: 0 solid #ffffff; 
} 
.tabp 
{ 
border-color: #000000 #000000 #000000 #000000; 
border-style: solid; 
border-top-width: 2px; 
border-right-width: 2px; 
border-bottom-width: 1px; 
border-left-width: 1px; 
} 
.NOPRINT { 
font-family: "宋体"; 
font-size: 9pt; 
} 
</style>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<%

int lll=0;
String pay_ID=request.getParameter("pay_ID") ;
String register=(String)session.getAttribute("realeditorc");
String register_ID=(String)session.getAttribute("human_IDD");
String stock_ID="";
try{
String sql3="select * from stock_config_public_char where describe1='库房' and responsible_person_ID like '%"+register_ID+"%'";
ResultSet rs3=stockdb.executeQuery(sql3);
while(rs3.next()){
	stock_ID+=rs3.getString("stock_ID")+",";
}
java.util.Date now = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=formatter.format(now);
String sql="select * from stock_pay where pay_ID='"+pay_ID+"'";
ResultSet rs=stockdb.executeQuery(sql);
if(rs.next()){
%>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" class="Noprint"><OBJECT id=WebBrowser classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2 height=0 width=0></OBJECT><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","打印")%> onclick="javascript:window.print()">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","页面设置")%> onclick=document.all.WebBrowser.ExecWB(8,1)>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","打印预览")%> onclick=document.all.WebBrowser.ExecWB(7,1)></td>
 </tr>
</table>
<%@include file="../include/paper_top.html"%>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","出库单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4" id=theObjTable> 
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","出库单编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3" width="87%"><input name="pay_ID" type="hidden" value="<%=pay_ID%>"><%=pay_ID%></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","出库理由")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input name="reason" type="hidden" value="<%=exchange.toHtml(rs.getString("reason"))%>"><%=exchange.toHtml(rs.getString("reason"))%>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","出库详细理由")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><input name="reasonexact" type="hidden" value="<%=exchange.toHtml(rs.getString("reasonexact"))%>"><%=exchange.toHtml(rs.getString("reasonexact"))%>&nbsp;</td>
 </tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table> 
<TABLE <%=TABLE_STYLE5%> class="TABLE_STYLE5">
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","产品编号")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","产品名称")%> </td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="8%"><%=demo.getLang("erp","库房名称")%> </td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","当前库存数量")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="8%"><%=demo.getLang("erp","应出库件数 ")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="8%"><%=demo.getLang("erp","已出库件数")%> </td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","本次出库数量")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="16%"><%=demo.getLang("erp","序列号")%></td>
	</tr>
<%
	int count=0;
	String sql5="select count(*) from stock_pre_paying where pay_ID='"+pay_ID+"'";
ResultSet rs5=stock_db.executeQuery(sql5);
while(rs5.next()){
	count=rs5.getInt("count(*)");
}
if(count>20){
	int m=1;
String sql6="select * from stock_pre_paying where pay_ID='"+pay_ID+"'";
ResultSet rs6=stock_db.executeQuery(sql6);
while(m<=20){
	rs6.next();
		int a=stock_ID.indexOf(rs6.getString("stock_ID"));
if(stock_ID.indexOf(rs6.getString("stock_ID"))!= -1){
	int serial_number_tag=0;
		String sql1="select * from stock_cell where product_ID='"+rs6.getString("product_ID")+"' and check_tag='1'";
		ResultSet rs1=stock_db1.executeQuery(sql1);
		if(rs1.next()){
			serial_number_tag=rs1.getInt("serial_number_tag");
		}
		if(serial_number_tag==1){
		lll=length.getLength((String)session.getAttribute("unit_db_name"));
		}else{
			lll=length.getLength2((String)session.getAttribute("unit_db_name"));
			}
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("product_ID")%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("product_name"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("stock_name"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=available.balanceAmount((String)session.getAttribute("unit_db_name"),rs6.getString("product_ID"),rs6.getString("stock_name"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerAmountPrecision")).format(rs6.getDouble("amount"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerAmountPrecision")).format(rs6.getDouble("paid_amount"))%>&nbsp;</td>
<%if(rs6.getString("pay_check_tag").equals("0")&&!rs6.getString("pay_tag").equals("1")){%>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="amount" type="text"></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%if(serial_number_tag==1){%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(S/N)<%}else if(serial_number_tag==2){%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(B/N)<%}else{%>&nbsp;<%}%></td>
<%}else if(rs6.getString("pay_check_tag").equals("1")&&!rs6.getString("pay_tag").equals("1")){%>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="amount" type="hidden" value=""><%=demo.getLang("erp","等待审核")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
<%}else if(rs6.getString("pay_tag").equals("1")){%>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="amount" type="hidden" value=""><%=demo.getLang("erp","完成")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
<%}%>
 </tr>
<%}
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
	int a=stock_ID.indexOf(rs6.getString("stock_ID"));
if(stock_ID.indexOf(rs6.getString("stock_ID"))!= -1){
	int serial_number_tag=0;
		String sql1="select * from stock_cell where product_ID='"+rs6.getString("product_ID")+"' and check_tag='1'";
		ResultSet rs1=stock_db1.executeQuery(sql1);
		if(rs1.next()){
			serial_number_tag=rs1.getInt("serial_number_tag");
		}
		if(serial_number_tag==1){
		lll=length.getLength((String)session.getAttribute("unit_db_name"));
		}else{
			lll=length.getLength2((String)session.getAttribute("unit_db_name"));
			}
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("product_ID")%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("product_name"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("stock_name"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=available.balanceAmount((String)session.getAttribute("unit_db_name"),rs6.getString("product_ID"),rs6.getString("stock_name"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerAmountPrecision")).format(rs6.getDouble("amount"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerAmountPrecision")).format(rs6.getDouble("paid_amount"))%>&nbsp;</td>
<%if(rs6.getString("pay_check_tag").equals("0")&&!rs6.getString("pay_tag").equals("1")){%>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="amount" type="text"></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%if(serial_number_tag==1){%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(S/N)<%}else if(serial_number_tag==2){%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(B/N)<%}else{%>&nbsp;<%}%></td>
<%}else if(rs6.getString("pay_check_tag").equals("1")&&!rs6.getString("pay_tag").equals("1")){%>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="amount" type="hidden" value=""><%=demo.getLang("erp","等待审核")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
<%}else if(rs6.getString("pay_tag").equals("1")){%>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="amount" type="hidden" value=""><%=demo.getLang("erp","完成")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
<%}%>
 </tr>
<%}}
	 %>
</table>
<%}else{
String sql6="select * from stock_pre_paying where pay_ID='"+pay_ID+"'";
ResultSet rs6=stock_db.executeQuery(sql6);
while(rs6.next()){
		int a=stock_ID.indexOf(rs6.getString("stock_ID"));
if(stock_ID.indexOf(rs6.getString("stock_ID"))!= -1){
	int serial_number_tag=0;
		String sql1="select * from stock_cell where product_ID='"+rs6.getString("product_ID")+"' and check_tag='1'";
		ResultSet rs1=stock_db1.executeQuery(sql1);
		if(rs1.next()){
			serial_number_tag=rs1.getInt("serial_number_tag");
		}
		if(serial_number_tag==1){
		lll=length.getLength((String)session.getAttribute("unit_db_name"));
		}else{
			lll=length.getLength2((String)session.getAttribute("unit_db_name"));
			}
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("product_ID")%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("product_name"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("stock_name"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=available.balanceAmount((String)session.getAttribute("unit_db_name"),rs6.getString("product_ID"),rs6.getString("stock_name"))%>&nbsp;</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerAmountPrecision")).format(rs6.getDouble("amount"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerAmountPrecision")).format(rs6.getDouble("paid_amount"))%>&nbsp;</td>
<%if(rs6.getString("pay_check_tag").equals("0")&&!rs6.getString("pay_tag").equals("1")){%>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input <%=INPUT_STYLE4%> class="INPUT_STYLE4" name="amount" type="text"></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><%if(serial_number_tag==1){%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(S/N)<%}else if(serial_number_tag==2){%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(B/N)<%}else{%>&nbsp;<%}%></td>
<%}else if(rs6.getString("pay_check_tag").equals("1")&&!rs6.getString("pay_tag").equals("1")){%>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="amount" type="hidden" value=""><%=demo.getLang("erp","等待审核")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
<%}else if(rs6.getString("pay_tag").equals("1")){%>
	 <td <%=TD_STYLE2%> class="TD_STYLE2"><input name="amount" type="hidden" value=""><%=demo.getLang("erp","完成")%></td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
<%}%>
 </tr>
<%
}
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
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","应出库总件数")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=rs.getDouble("demand_amount")%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","已出库总件数")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=rs.getDouble("paid_amount")%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","应出库总成本")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("cost_price_sum"))%>&nbsp;</td>
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","已出库总成本")%>：</td>
	 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("paid_cost_price_sum"))%>&nbsp;</td>
</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","登记人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%">&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="13%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="37%">&nbsp;</td>
 </tr>
 </table>
 </div>
 <%@include file="../include/paper_bottom.html"%>
<%
}
	stock_db.close();
	stockdb.close();
}
catch (Exception ex){
out.println("error"+ex);
}
%>