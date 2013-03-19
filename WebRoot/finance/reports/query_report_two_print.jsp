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
<%nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
<script language="JavaScript">
function newwin(file) {
winopen(file)
}
</script>
<style type="text/css">
<!--
body {
	margin-left: 0px;
}
.style1 {font-size: 14px}
.style2 {font-size: 12px}
-->
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
<blockquote>
 &nbsp;
</blockquote>
<%
String ID=request.getParameter("ID");
String sql="select * from finance_report_02 where ID='"+ID+"'";
ResultSet rs=finance_db.executeQuery(sql);
if(rs.next()){	 
%>
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6"> 
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td class="Noprint">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><OBJECT id=WebBrowser classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2 height=0 width=0></OBJECT><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","打印")%> onclick="javascript:window.print()">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","页面设置")%> onclick=document.all.WebBrowser.ExecWB(8,1)>&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value=<%=demo.getLang("erp","打印预览")%> onclick=document.all.WebBrowser.ExecWB(7,1)></div> 
 </td>
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
 <td align="center"><font size="4"><b><%=demo.getLang("erp","损益表")%></b></font></td>
 </tr>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","编制单位：")%><%=exchange.toHtml(rs.getString("report_unit"))%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","时间：")%><%=rs.getString("year")%><%=demo.getLang("erp","年")%> <%=rs.getString("month")%><%=demo.getLang("erp","月")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","单位：元")%> </td> 
 </tr>
</table>
<table <%=TABLE_STYLE11%> class="TABLE_STYLE11" id=theObjTable>
<tr <%=TR_STYLE2%> class="TR_STYLE2">
    <td <%=TD_STYLE2%> class="TD_STYLE2"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","项目")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","行次")%></td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","本月数")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","本年累计数")%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","一、主营业务收入")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">1</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month1"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year1"))%></td>
</tr>	
<tr <%=TR_STYLE1%> class="TR_STYLE1">	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","减：主营业务成本")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">4</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month4"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year4"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">	
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","主营业务税金及附加")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">5</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month5"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year5"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","二、主营业务利润(亏损以“-”号填列)")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">10</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month10"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year10"))%></td>
	</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","加：其他业务利润(亏损以“-”号填列)")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">11</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month11"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year11"))%></td>
	</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","减：营业费用")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">14</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month14"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year14"))%></td>	
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">	
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","管理费用")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">15</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month15"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year15"))%></td>	
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">	
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","财务费用")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">16</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month16"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year16"))%></td>
	
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","三、营业利润(亏损以“-”号填列)")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">18</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month18"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year18"))%></td>
	</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","加：投资收益(损失以“-”号填列)")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">19</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month19"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year19"))%></td>	
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">	
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","营业外收入")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">23</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month23"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year23"))%></td>	
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","减：营业外支出")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">25</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month25"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year25"))%></td>	
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","四、利润总额(亏损总额以“-”号填列)")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">27</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month27"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year27"))%></td>
</tr>	
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","减：所得税")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">28</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month28"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year28"))%></td>	
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","五、净利润(净亏损以“-”号填列)")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">30</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month30"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year30"))%></td>
</tr>
</table>
<%@include file="../include/paper_bottom.html"%>
<%
 
 finance_db.close();
 }%>