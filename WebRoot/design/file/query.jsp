<%/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */%>
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
<jsp:useBean id="mask" class="include.operateXML.Reading"/>
<jsp:setProperty name="mask" property="file" value="xml/design/design_file.xml"/>

<%
String product_ID=request.getParameter("product_ID");
try{
	String sql = "select * from design_file where product_ID='"+product_ID+"'" ;
	ResultSet rs = designdb.executeQuery(sql) ;
	if(rs.next()){
		String lately_trade_time=rs.getString("lately_trade_time");
		if(lately_trade_time.equals("1800-01-01 00:00:00.0")){
			lately_trade_time="没有销售";
		}
		String lately_change_time=rs.getString("change_time");
		if(lately_change_time.equals("1800-01-01 00:00:00.0")){
			lately_change_time="没有变更";
		}
%>

<style>
body {
	font-family: Arial,"宋体";
	font-size:9pt;
}
td { font-size:12px;;
}
.mousehand{
	cursor:hand;
}
table.TabBarLevel1 td{
 border:0px solid #CCCCCC;
 height:20px;
 background-color:#66ccff;
}

table.TabBarLevel1 td.Selected{
 border-bottom-width:0px;
 background-color:orange;
}
table.TabBarLevel1 td.Black{
 border-left-width:0px;
 border-top-width:0px;
 border-right-width:0px;
 background-color:#eeeeee;
}
table.Content{
 border-left:1px solid #CCCCCC;
 border-right:1px solid #CCCCCC;
 border-bottom:1px solid #CCCCCC;
}
</style>
<script language="javascript">
function switchTab(tabpage,tabid,action,type,num){
	var oItem = document.getElementById(tabpage);   
	for(var i=1;i<4;i++){
		var x = document.getElementById(type + 'Tab' + i);	
		//alert(x);
		x.className = "mousehand";
		//var y = x.getElementsByTagName('a');
		//y[0].style.color="#333333";
	}	

	document.getElementById(tabid).className = "Selected";
	//gethotimagelist(type+'_'+action);
	divimagelist_all.innerHTML =document.getElementById("nseer"+num).innerHTML;
}
</script>

<body onload="changeTab('nseer0')">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","打印")%>" onClick="javascript:winopen('query_print.jsp?product_ID=<%=product_ID%>')">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></div>
 </td>
 </tr>
</table>
<table style="width:100%;top:2%;">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3">
<div id="Tabs0">
<ul>
<li id="main_cur"><a href="javascript:changeTab('nseer0');"><span><%=demo.getLang("erp","全部信息")%></span></a></li>
</ul>
<ul>
<li><a href="javascript:changeTab('nseer1');"><span><%=demo.getLang("erp","主信息")%></span></a></li>
</ul>
<ul>
<li><a href="javascript:changeTab('nseer2');"><span><%=demo.getLang("erp","辅助信息")%></span></a></li><li></li>
</ul>
<%@include file="../../include/cDefineMouT.jsp"%>
</div>
	</td>
  </tr>
</table>

<div id="nseer1" style="display:none">
 <table <%=TABLE_STYLE7%> class="TABLE_STYLE7">
 <tr style="background-image:url(../../images/line.gif)"><td colspan="4"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","主信息")%></div></td></tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","档案编号")%> </td>
 <td colspan="3" <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=rs.getString("product_ID")%>&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","产品名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("product_name"))%>&nbsp;</td>
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
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=rs.getString("personal_unit")%>&nbsp;</td>
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
 </table>
 </div>
<div id="nseer2" style="display:none">
 <table <%=TABLE_STYLE7%> class="TABLE_STYLE7">
 <tr style="background-image:url(../../images/line.gif)"><td colspan="4"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","辅助信息")%></div></td></tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","保修期")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("warranty"))%>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","替代品名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("twin_name"))%>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","替代品编号")%> </td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("twin_ID"))%>&nbsp;</td>
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
 <td <%=TD_STYLE11%> class="TD_STYLE7" width="8%" height="65"><%=demo.getLang("erp","供应商集合")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=rs.getString("provider_group")%>
&nbsp;</td>
 <td height="65" <%=TD_STYLE11%> class="TD_STYLE7" width="8%"><%=demo.getLang("erp","产品描述")%> &nbsp; </td>
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
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><a href="javascript:winopen('change_file_dig.jsp?product_ID=<%=rs.getString("product_ID")%>&&time=<%=exchange.toURL(rs.getString("lately_change_time"))%>')"><%=rs.getString("file_change_amount")%></a>&nbsp</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","最近变更时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><a href="javascript:winopen('change_file_dig.jsp?product_ID=<%=rs.getString("product_ID")%>&&time=<%=exchange.toURL(rs.getString("lately_change_time"))%>')"><%=lately_change_time%></a>&nbsp;</td>
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

 </table>
 </div>
<div id="nseer0" style="display:none">
 <table <%=TABLE_STYLE7%> class="TABLE_STYLE7">
 <tr style="background-image:url(../../images/line.gif)"><td colspan="4"><div style="width:100%; height:12; padding:3px; "><%=demo.getLang("erp","全部信息")%></div></td></tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","档案编号")%> </td>
 <td colspan="3" <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=rs.getString("product_ID")%>&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","产品名称")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=exchange.toHtml(rs.getString("product_name"))%>&nbsp;</td>
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
 <td <%=TD_STYLE11%> class="TD_STYLE7" width="8%" height="65"><%=demo.getLang("erp","供应商集合")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=rs.getString("provider_group")%>
&nbsp;</td>
 <td height="65" <%=TD_STYLE11%> class="TD_STYLE7" width="8%"><%=demo.getLang("erp","产品描述")%> &nbsp; </td>
<td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><%=rs.getString("product_describe")%>&nbsp;</td>
 </tr>
<%
   attachment_name1=DealWithString.divide(rs.getString("attachment_name"),20);	
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","档案附件")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><a href="javascript:winopenm('query_attachment.jsp?id=<%=rs.getString("id")%>&tablename=design_file&fieldname=attachment_name')">
<%=attachment_name1[1]%></a>&nbsp;</td>
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","档案变更累计")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><a href="javascript:winopen('change_file_dig.jsp?product_ID=<%=rs.getString("product_ID")%>&&time=<%=exchange.toURL(rs.getString("lately_change_time"))%>')"><%=rs.getString("file_change_amount")%></a>&nbsp</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE11%> class="TD_STYLE1" width="8%"><%=demo.getLang("erp","最近变更时间")%></td>
 <td <%=TD_STYLE21%> class="TD_STYLE2" width="18%"><a href="javascript:winopen('change_file_dig.jsp?product_ID=<%=rs.getString("product_ID")%>&&time=<%=exchange.toURL(rs.getString("lately_change_time"))%>')"><%=lately_change_time%></a>&nbsp;</td>
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
<%
String nickName="产品档案";%>
<%@include file="../../include/cDefineMouQ.jsp"%>
 </table>
 </div>
<div id="nseer4" style="display:none">
 <table <%=TABLE_STYLE7%> class="TABLE_STYLE7">
<%@include file="../../include/cDefineMouQ.jsp"%>
 </table>
</div>
<%
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
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back();"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","该档案已删除，请返回。")%></td>
</tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">	 
 <td <%=TD_STYLE3%> class="TD_STYLE3">&nbsp;</td>
 </tr>
</table>
</div>
<%
 }
designdb.close();
}
catch (Exception ex){
out.println("error2:"+ex);
}
%>