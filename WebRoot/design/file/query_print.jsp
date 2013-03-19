<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseerdb.*,java.text.*,include.nseer_cookie.*"%>
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
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">

 <table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td align="right" class="Noprint"><OBJECT id=WebBrowser classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2 height=0 width=0></OBJECT><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","打印")%> onclick="javascript:window.print()">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","页面设置")%> onclick=document.all.WebBrowser.ExecWB(8,1)>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","打印预览")%> onclick=document.all.WebBrowser.ExecWB(7,1)></td>
 </tr>
</table>
 <table <%=TABLE_STYLE7%> class="TABLE_STYLE7">
 <tr style="background-image:url(../../images/line.gif)"><td colspan="4"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","主信息")%></div></td></tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","档案编号")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" colspan="3" width="18%"><%=rs.getString("product_ID")%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","产品名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%" ><%=exchange.toHtml(rs.getString("product_name"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","制造商")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("factory_name"))%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","产品分类")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("chain_id"))%> <%=exchange.toHtml(rs.getString("chain_name"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","产品简称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("product_nick"))%>&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","用途类型")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("type"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","档次级别")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("product_class"))%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","计量单位")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("personal_unit"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","计量值")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("personal_value"))%>&nbsp;</td>
 
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","市场单价(元)")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("list_price"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","计划成本单价")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("cost_price"))%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","成本单价")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("real_cost_price"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%">&nbsp;</td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%">&nbsp;</td>
 </tr>
 <tr style="background-image:url(../../images/line.gif)"><td colspan="4"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","辅助信息")%></div></td></tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","保修期")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("warranty"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","替代品名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("twin_name"))%>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","替代品编号")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=rs.getString("twin_ID")%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","生命周期(年)")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("lifecycle"))%>&nbsp;</td>
 
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","单位")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("amount_unit"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%">&nbsp;</td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%">&nbsp;</td>
 </tr>

 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td height="65" <%=TD_STYLE11%> class="TD_STYLE7" width="8%"><%=demo.getLang("erp","供应商集合")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=rs.getString("provider_group")%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE7" width="8%" height="65"><%=demo.getLang("erp","产品描述")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=rs.getString("product_describe")%>&nbsp;</td>
 </tr>


<%
String[] attachment_name1=DealWithString.divide(rs.getString("attachment_name"),20);	
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","档案附件")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><a href="javascript:winopenm('query_attachment.jsp?id=<%=rs.getString("id")%>&tablename=design_file&fieldname=attachment_name')">
<%=attachment_name1[1]%></a>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","档案变更累计")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><a href="change_file_dig.jsp?product_ID=<%=rs.getString("product_ID")%>&&time=<%=toUtf8String.utf8String(exchange.toURL(rs.getString("lately_change_time")))%>"><%=rs.getString("file_change_amount")%>&nbsp;</td>
 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","最近变更时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><a href="change_file_dig.jsp?product_ID=<%=rs.getString("product_ID")%>&&time=<%=toUtf8String.utf8String(exchange.toURL(rs.getString("lately_change_time")))%>"><%=lately_change_time%>&nbsp;</td>
<td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","建档时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("register_time"))%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","产品经理")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("responsible_person_name"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","登记人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("register"))%>&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","审核人")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("checker"))%>&nbsp;</td>
	 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","审核时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("check_time"))%>&nbsp;</td>
 </tr>
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/design/design_file.xml"/>
<%
String nickName="产品档案";%>
<%@include file="../../include/cDefineMouQ.jsp"%>
 </table>
<%
}
designdb.close();
}
catch (Exception ex){
out.println("error"+ex);
}
%>
</div>