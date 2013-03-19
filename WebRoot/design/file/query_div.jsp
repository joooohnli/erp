<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseerdb.*,include.nseer_cookie.exchange,java.text.*,include.nseer_cookie.*"%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%nseer_db designdb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
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
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
<%
String product_ID=request.getParameter("product_ID");
try{
	String sql = "select * from design_file where product_ID='"+product_ID+"'" ;
	ResultSet rs = designdb.executeQuery(sql) ;
	while(rs.next()){
		String lately_trade_time=rs.getString("lately_trade_time");
		if(lately_trade_time.equals("1800-01-01 00:00:00.0")){
			lately_trade_time="没有销售";
		}
		String lately_change_time=rs.getString("change_time");
		if(lately_change_time.equals("1800-01-01 00:00:00.0")){
			lately_change_time="没有变更";
		}
%>
 <table <%=TABLE_STYLE7%> class="TABLE_STYLE7">
 <tr style="background-image:url(../../images/line.gif)"><td colspan="4"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","主信息")%></div></td></tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="25%" style="background-image:url(../../images/line7.gif)"><%=demo.getLang("erp","档案编号")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" colspan="3" width="25%"><%=rs.getString("product_ID")%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="25%" style="background-image:url(../../images/line7.gif)"><%=demo.getLang("erp","产品名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%" ><%=exchange.toHtml(rs.getString("product_name"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="25%" style="background-image:url(../../images/line7.gif)"><%=demo.getLang("erp","制造商")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><%=exchange.toHtml(rs.getString("factory_name"))%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="25%" style="background-image:url(../../images/line7.gif)"><%=demo.getLang("erp","产品分类")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><%=exchange.toHtml(rs.getString("chain_id"))%> <%=exchange.toHtml(rs.getString("chain_name"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="25%" style="background-image:url(../../images/line7.gif)"><%=demo.getLang("erp","产品简称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><%=exchange.toHtml(rs.getString("product_nick"))%>&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="25%" style="background-image:url(../../images/line7.gif)"><%=demo.getLang("erp","用途类型")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><%=exchange.toHtml(rs.getString("type"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="25%" style="background-image:url(../../images/line7.gif)"><%=demo.getLang("erp","档次级别")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><%=exchange.toHtml(rs.getString("product_class"))%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="25%" style="background-image:url(../../images/line7.gif)"><%=demo.getLang("erp","计量单位")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><%=exchange.toHtml(rs.getString("personal_unit"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="25%" style="background-image:url(../../images/line7.gif)"><%=demo.getLang("erp","计量值")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("personal_value"))%>&nbsp;</td>
 
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="25%" style="background-image:url(../../images/line7.gif)"><%=demo.getLang("erp","市场单价(元)")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("list_price"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="25%" style="background-image:url(../../images/line7.gif)"><%=demo.getLang("erp","计划成本单价")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("cost_price"))%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="25%" style="background-image:url(../../images/line7.gif)"><%=demo.getLang("erp","成本单价")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("real_cost_price"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="25%" style="background-image:url(../../images/line7.gif)">&nbsp;</td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%">&nbsp;</td>
 </tr>
 <tr style="background-image:url(../../images/line.gif)"><td colspan="4"><div style="width:100%; height:12; padding:3px; " ><%=demo.getLang("erp","辅助信息")%></div></td></tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="25%" style="background-image:url(../../images/line7.gif)"><%=demo.getLang("erp","保修期")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><%=exchange.toHtml(rs.getString("warranty"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="25%" style="background-image:url(../../images/line7.gif)"><%=demo.getLang("erp","替代品名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><%=exchange.toHtml(rs.getString("twin_name"))%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="25%" style="background-image:url(../../images/line7.gif)"><%=demo.getLang("erp","替代品编号")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><%=rs.getString("twin_ID")%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="25%" style="background-image:url(../../images/line7.gif)"><%=demo.getLang("erp","生命周期(年)")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><%=exchange.toHtml(rs.getString("lifecycle"))%>&nbsp;</td>
 
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="25%" style="background-image:url(../../images/line7.gif)"><%=demo.getLang("erp","单位")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><%=exchange.toHtml(rs.getString("amount_unit"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="25%" style="background-image:url(../../images/line7.gif)">&nbsp;</td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%">&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="25%" height="65" style="background-image:url(../../images/line7.gif)"><%=demo.getLang("erp","供应商集合")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><%=rs.getString("provider_group")%>&nbsp;</td>
<td <%=TD_STYLE11%> class="TD_STYLE1" width="25%" height="65" style="background-image:url(../../images/line7.gif)"><%=demo.getLang("erp","产品描述")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><%=rs.getString("product_describe")%>&nbsp;</td>
</tr>
<%
String[] attachment_name1=DealWithString.divide(rs.getString("attachment_name"),20);	
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="25%" style="background-image:url(../../images/line7.gif)"><%=demo.getLang("erp","档案附件")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><a href="javascript:winopenm('../file/query_attachment.jsp?id=<%=rs.getString("id")%>&tablename=design_file&fieldname=attachment_name')">
<%=attachment_name1[1]%></a>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="25%" style="background-image:url(../../images/line7.gif)"><%=demo.getLang("erp","档案变更累计")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><a href="../file/change_file_dig.jsp?product_ID=<%=rs.getString("product_ID")%>&&time=<%=toUtf8String.utf8String(exchange.toURL(rs.getString("lately_change_time")))%>"><%=rs.getString("file_change_amount")%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="25%" style="background-image:url(../../images/line7.gif)"><%=demo.getLang("erp","最近变更时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><a href="../file/change_file_dig.jsp?product_ID=<%=rs.getString("product_ID")%>&&time=<%=toUtf8String.utf8String(exchange.toURL(rs.getString("lately_change_time")))%>"><%=lately_change_time%>&nbsp;</td>
<td <%=TD_STYLE11%> class="TD_STYLE1" width="25%" style="background-image:url(../../images/line7.gif)"><%=demo.getLang("erp","建档时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><%=exchange.toHtml(rs.getString("register_time"))%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="25%" style="background-image:url(../../images/line7.gif)"><%=demo.getLang("erp","产品经理")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><%=exchange.toHtml(rs.getString("responsible_person_name"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="25%" style="background-image:url(../../images/line7.gif)"><%=demo.getLang("erp","登记人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><%=exchange.toHtml(rs.getString("register"))%>&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="25%" style="background-image:url(../../images/line7.gif)"><%=demo.getLang("erp","审核人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><%=exchange.toHtml(rs.getString("checker"))%>&nbsp;</td>
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="25%" style="background-image:url(../../images/line7.gif)"><%=demo.getLang("erp","审核时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="25%"><%=exchange.toHtml(rs.getString("check_time"))%>&nbsp;</td>
 </tr>
 </table>
 <TABLE <%=TABLE_STYLE6%> class="TABLE_STYLE6">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE1%> class="TD_STYLE8"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" onClick="window.neatDialog.close();" value=<%=demo.getLang("erp","关闭")%>></div></td>
</tr>
</table>
<%
}
designdb.close();
}
catch (Exception ex){
out.println("error"+ex);
}
%>