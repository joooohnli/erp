<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<jsp:useBean id="query" scope="page" class="include.query.getRecordCount"/>
<jsp:useBean id="getSumFromItem" scope="page" class="finance.getSumFromItem"/>
<%nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head.jsp"%>
 <jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String account_period=request.getParameter("account_period");
String report_unit=request.getParameter("report_unit");
%>
<%
try{
String table_width="820";
String end_time="";
String sql="select end_time from finance_account_period where account_period='"+account_period+"'";
ResultSet rs=finance_db.executeQuery(sql);
if(rs.next()){
	end_time=rs.getString("end_time");
}
%>
 <table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
 <div id="nseerGround" class="nseerGround">
 <form id="mutiValidation" method="POST" action="../../finance_reports_tablea_save" onSubmit="return doValidate('mutiValidation')">
 <table <%=TABLE_STYLE8%> class="TABLE_STYLE8">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="tablea_locate.jsp"></div></td>
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
 <td align="center"><font size="4"><b><%=demo.getLang("erp","资产负债表")%></b></font></td>
 </tr>
 </table>
 <table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><span id="company"><%=demo.getLang("erp","编制单位：")%><%=exchange.toHtml(report_unit)%></span></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><span id="time"><%=demo.getLang("erp","时间：")%><%=end_time%></span></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><span id="money"><%=demo.getLang("erp","单位：元")%></span></td> 
 </tr>
 </table>
 <table <%=TABLE_STYLE11%> class="TABLE_STYLE11" id=theObjTable>
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
	
<td <%=TD_STYLE2%> class="TD_STYLE2"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","资产")%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","行次")%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","年初数")%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","期末数")%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","负债和所有者权益（或股东权益）")%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","行次")%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","年初数")%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","期末数")%></td>
	
</tr>

<tr <%=TR_STYLE1%> class="TR_STYLE1">
<%
double active_asset1=getSumFromItem.getLastYearSumFromItem(finance_db,"1◇2◇3◇4◇6◇7◇10◇11◇21◇24",account_period);
double active_asset2=getSumFromItem.getSumFromItem(finance_db,"1◇2◇3◇4◇6◇7◇10◇11◇21◇24",account_period);
%>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","流动资产：")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","流动负债：")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>	
	</tr>
<%
double opp_active_asset1=getSumFromItem.getLastYearSumFromItem(finance_db,"68◇69◇70◇72◇73◇74◇76◇80◇81◇82◇86◇90",account_period);
double opp_active_asset2=getSumFromItem.getSumFromItem(finance_db,"68◇69◇70◇72◇73◇74◇76◇80◇81◇82◇86◇90",account_period);
%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","货币资金")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">1</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"1",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"1",account_period))%></td>

	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","短期借款")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">68</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"68",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"68",account_period))%></td>
	</tr>

	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","短期投资")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">2</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"2",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"2",account_period))%></td>

	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","应付票据")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">69</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"69",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"69",account_period))%></td>

</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	
<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","应收票据")%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2">3</td>
<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"3",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"3",account_period))%></td>

	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","应付账款")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">70</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"70",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"70",account_period))%></td>
	
	</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","应收股息")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">4</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"4",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"4",account_period))%></td>
	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","应付工资")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">72</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"72",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"72",account_period))%></td>
	
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","应收账款")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">6</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"6",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"6",account_period))%></td>

	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","应付福利费")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">73</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"73",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"73",account_period))%></td>

	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","其他应收款")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">7</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"7",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"7",account_period))%></td>

	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","应付利润")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">74</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"74",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"74",account_period))%></td>
	
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","存货")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">10</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"10",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"10",account_period))%></td>

	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","应缴税金")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">76</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"76",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"76",account_period))%></td>
	
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","待摊费用")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">11</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"11",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"11",account_period))%></td>
	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","其他应交款")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">80</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"80",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"80",account_period))%></td>
	
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","一年内到期的长期债权投资")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">21</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"21",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"21",account_period))%></td>

	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","其他应付款")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">81</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"81",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"81",account_period))%></td>
	
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","其他流动资产")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">24</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"24",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"24",account_period))%></td>

	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","预提费用")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">82</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"82",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"82",account_period))%></td>
	
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","流动资产合计")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">31</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(active_asset1)%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(active_asset2)%>
	</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","一年内到期的长期负债")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">86</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"86",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"86",account_period))%></td>
	</tr>

<%double long_capital1=getSumFromItem.getLastYearSumFromItem(finance_db,"32◇34",account_period);
  double long_capital2=getSumFromItem.getSumFromItem(finance_db,"32◇34",account_period);
	%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","长期投资：")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","其他流动负债")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">90</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"90",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"90",account_period))%></td>
	
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","长期股权投资")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">32</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"32",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"32",account_period))%></td>

	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","流动负债合计")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">100</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(opp_active_asset1)%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(opp_active_asset2)%></td>

 </tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","长期债权投资")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">34</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"34",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"34",account_period))%></td>
	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","长期负债：")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	</tr>

	<%double opp_long_capital1=getSumFromItem.getLastYearSumFromItem(finance_db,"101◇103◇106",account_period);

	double opp_long_capital2=getSumFromItem.getSumFromItem(finance_db,"101◇103◇106",account_period);
	%>

  <tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","长期投资合计")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">38</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(long_capital1)%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(long_capital2)%></td>
	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","长期借款")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">101</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"101",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"101",account_period))%></td>
	
</tr>
<%double fix_asset1=getSumFromItem.getLastYearSumFromItem(finance_db,"39◇40◇41◇44◇45◇46",account_period);
double fix_asset2=getSumFromItem.getSumFromItem(finance_db,"39◇40◇41◇44◇45◇46",account_period);
	
%>

<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","固定资产：")%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","长期应付款")%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2">103</td>
<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"103",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"103",account_period))%></td>
	</tr>

	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","固定资产原价")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">39</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"39",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"39",account_period))%></td>
	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","其他长期负债")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">106</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"106",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"106",account_period))%></td>
	
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","减：累计折旧")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">40</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"40",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"40",account_period))%></td>
	
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">108</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"108",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"108",account_period))%></td>
	</tr>
 
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","固定资产净值")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">41</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"41",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"41",account_period))%></td>
	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","长期负债合计")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">110</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(opp_long_capital1)%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(opp_long_capital2)%></td>
	</tr>
	
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","工程物资")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">44</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"44",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"44",account_period))%></td>
	
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
</tr>
  <tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","在建工程")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">45</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"45",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"45",account_period))%></td>

<%double opp_asset_sum1=opp_active_asset1+opp_long_capital1;
double opp_asset_sum2=opp_active_asset2+opp_long_capital1;
%>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","负债合计")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">114</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(opp_asset_sum1)%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(opp_asset_sum2)%></td>
</tr>

<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","固定资产清理")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">46</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"46",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"46",account_period))%></td>

<%double owner_asset1=getSumFromItem.getLastYearSumFromItem(finance_db,"115◇120◇121◇122◇123",account_period);
double owner_asset2=getSumFromItem.getSumFromItem(finance_db,"115◇120◇121◇122◇123",account_period);

%>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","所有者权益（或股东权益）：")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","固定资产合计")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">50</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(fix_asset1)%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(fix_asset2)%></td>
	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","实收资本")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">115</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"115",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2" ><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"115",account_period))%></td>

</tr>

<%double unvisable_asset1=getSumFromItem.getLastYearSumFromItem(finance_db,"51◇52◇53",account_period);
double unvisable_asset2=getSumFromItem.getSumFromItem(finance_db,"51◇52◇53",account_period);
	%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","无形资产及其他资产：")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","资本公积")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">120</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"120",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"120",account_period))%></td>
	
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","无形资产")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">51</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"51",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"51",account_period))%></td>
	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","盈余公积")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">121</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"121",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"121",account_period))%></td>
	
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","长期待摊费用")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">52</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"52",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"52",account_period))%></td>
	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","其中：法定公益金")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">122</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"122",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"122",account_period))%></td>
	
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","其他长期资产")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">53</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"53",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"53",account_period))%></td>
	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","未分配利润")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">123</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getLastYearSumFromItem(finance_db,"123",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getSumFromItem.getSumFromItem(finance_db,"123",account_period))%></td>
	
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","无形资产及其他资产合计")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">60</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(unvisable_asset1)%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(unvisable_asset2)%></td>
	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","所有者权益（或股东权益）合计")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">124</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(owner_asset1)%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(owner_asset2)%></td>
</tr>
<%double asset_sum1=active_asset1+long_capital1+fix_asset1+unvisable_asset1;
double asset_sum2=active_asset2+long_capital1+fix_asset2+unvisable_asset2;
%>
<%double opp_sum1=opp_asset_sum1+owner_asset1;
double opp_sum2=opp_asset_sum2+owner_asset2;
%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","资产合计")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">67</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(asset_sum1)%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(asset_sum2)%></td>

	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","负债和所有者权益（或股东权益）总计")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">135</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(opp_sum1)%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(opp_sum2)%></td>
	
</tr>
</table>
<%@include file="../include/paper_bottom.html"%>
</form>
</div>
<%
	finance_db.close();
}catch(Exception ex){
ex.printStackTrace();
}	
%>