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
<jsp:useBean id="getYearSumFromItemc" scope="page" class="finance.getYearSumFromItemc"/>
<jsp:useBean id="getYearSumFromItemd" scope="page" class="finance.getYearSumFromItemd"/>
<jsp:useBean id="getYearProfitSumFromItemb" scope="page" class="finance.getYearProfitSumFromItemb"/>
<jsp:useBean id="getYearSumFromAccount" scope="page" class="finance.getYearSumFromAccount"/>
<%nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head.jsp"%>
 <jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
try{
String table_width="820";
String account_period="";
String timea=request.getParameter("timea");
String report_unit=request.getParameter("report_unit");
if(!timea.equals("")){
String sql="select * from finance_account_period where start_time<='"+timea+"' and end_time>='"+timea+"'";
ResultSet rs=finance_db.executeQuery(sql);
if(rs.next()){
	account_period=rs.getString("account_period");
}
%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
<input name="finance_time" type="hidden" value="<%=timea%>">
<input name="report_unit" type="hidden" value="<%=exchange.toHtml(report_unit)%>">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
 <form id="mutiValidation" method="POST" action="../../finance_reports_tablec_save" onSubmit="return doValidate('mutiValidation')">
 <table <%=TABLE_STYLE8%> class="TABLE_STYLE8">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="tablec_locate.jsp"></div></td>
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
 <td align="center"><font size="4"><b><%=demo.getLang("erp","现金流量表")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><span id="company"><%=demo.getLang("erp","编制单位：")%><%=exchange.toHtml(report_unit)%></span></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><span id="time"><%=demo.getLang("erp","时间：")%><%=timea%></span></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><span id="money"><%=demo.getLang("erp","单位：元")%></span></td> 
 </tr>
</table>
<table <%=TABLE_STYLE11%> class="TABLE_STYLE11" id=theObjTable>
<tr <%=TR_STYLE2%> class="TR_STYLE2">	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","项目")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","行次")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","本年数")%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","一、经营活动产生的现金流量：")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">	
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","销售商品、提供劳务收到的现金")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">1</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemc.getYearSumFromItemc(finance_db,"1",timea))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">	
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","收到的其他与经营活动有关的现金")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">8</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemc.getYearSumFromItemc(finance_db,"8",timea))%></td>
</tr>
<%
double cashin1_sum=getYearSumFromItemc.getYearSumFromItemc(finance_db,"1◇8",timea);
%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
  <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","现金流入小计")%>
  </td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">9</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(cashin1_sum)%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">	
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","购买商品、接受劳务支付的现金")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">10</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemc.getYearSumFromItemc(finance_db,"10",timea))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","支付给职工以及为职工支付的现金")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">12</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemc.getYearSumFromItemc(finance_db,"12",timea))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","支付的各项税费")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">13</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemc.getYearSumFromItemc(finance_db,"13",timea))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","支付的其他与经营活动有关的现金")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">18</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemc.getYearSumFromItemc(finance_db,"18",timea))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<%
double cashout1_sum=getYearSumFromItemc.getYearSumFromItemc(finance_db,"10◇12◇13◇18",timea);
%>	
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","现金流出小计")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">20</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(cashout1_sum)%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<%
double cashbalance1_sum=cashin1_sum-cashout1_sum;
%>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","经营活动产生的现金流量净额")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">21</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(cashbalance1_sum)%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","二、投资活动产生的现金流量：")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
     <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","收回投资所收到的现金")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">22</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemc.getYearSumFromItemc(finance_db,"22",timea))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","取得投资收益所收到的现金")%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2">23</td>
<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemc.getYearSumFromItemc(finance_db,"23",timea))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","处置固定资产、无形资产和其他长期资产所收回的现金净额")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">25</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemc.getYearSumFromItemc(finance_db,"25",timea))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","收到的其他与投资活动有关的现金")%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2">28</td>
<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemc.getYearSumFromItemc(finance_db,"28",timea))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<%
double cashin2_sum=getYearSumFromItemc.getYearSumFromItemc(finance_db,"22◇23◇25◇28",timea);
%>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","现金流入小计")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">29</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(cashin2_sum)%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","购建固定资产、无形资产和其他长期资产所支付的现金")%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2">30</td>
<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemc.getYearSumFromItemc(finance_db,"30",timea))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","投资所支付的现金")%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2">31</td>
<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemc.getYearSumFromItemc(finance_db,"31",timea))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","支付的其他与投资活动有关的现金")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">35</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemc.getYearSumFromItemc(finance_db,"35",timea))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<%
double cashout2_sum=getYearSumFromItemc.getYearSumFromItemc(finance_db,"30◇31◇35",timea);
%>	
<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","现金流出小计")%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2">36</td>
<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(cashout2_sum)%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<%
double cashbalance2_sum=cashin2_sum-cashout2_sum;
%>
<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","投资活动产生的现金流量净额")%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2">37</td>
<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(cashbalance2_sum)%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","三、筹资活动产生的现金流量：")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","吸收投资所收到的现金")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">38</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemc.getYearSumFromItemc(finance_db,"38",timea))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
   <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","借款所收到的现金")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">40</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemc.getYearSumFromItemc(finance_db,"40",timea))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","收到的其他与筹资活动有关的现金")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">43</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemc.getYearSumFromItemc(finance_db,"43",timea))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<%
double cashin3_sum=getYearSumFromItemc.getYearSumFromItemc(finance_db,"38◇40◇43",timea);
%>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","现金流入小计")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">44</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(cashin3_sum)%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","偿还债务所支付的现金")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">45</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemc.getYearSumFromItemc(finance_db,"45",timea))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
    <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","分配股利、利润或偿付利息所支付的现金")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">46</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemc.getYearSumFromItemc(finance_db,"46",timea))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","支付的其他与筹资活动有关的现金")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">52</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemc.getYearSumFromItemc(finance_db,"52",timea))%></td>
</tr>
<%
double cashout3_sum=getYearSumFromItemc.getYearSumFromItemc(finance_db,"45◇46◇52",timea);
%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","现金流出小计")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">53</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(cashout3_sum)%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<%
double cashbalance3_sum=cashin3_sum-cashout3_sum;
%>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","筹资活动产生的现金流量净额")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">54</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(cashbalance3_sum)%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","四、汇率变动对现金的影响")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">55</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemc.getYearSumFromItemc(finance_db,"55",timea))%></td>
</tr>
<%
double cashbalance_sum=cashbalance1_sum+cashbalance2_sum+cashbalance3_sum+getYearSumFromItemc.getYearSumFromItemc(finance_db,"55",timea);
%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","五、现金及现金等价物净增加额")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">56</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(cashbalance_sum)%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3">&nbsp;</td>
	
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","补充资料")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","行次")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><font class="resizeDivClass" onmousedown="MouseDownToResize(this);" onmousemove="MouseMoveToResize(this);" onmouseup="MouseUpToResize(this);"></font><%=demo.getLang("erp","本年数")%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","1.将净利润调节为经营活动现金流量：")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;<%=demo.getLang("erp","净利润")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">57</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearProfitSumFromItemb.getYearProfitSumFromItemb(finance_db,"item_year30",account_period))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;<%=demo.getLang("erp","加：计提的资产减值准备")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">58</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemd.getYearSumFromItemd(finance_db,"58",timea))%></td>
</tr>
   <tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","固定资产折旧")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">59</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemd.getYearSumFromItemd(finance_db,"59",timea))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","无形资产摊销")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">60</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemd.getYearSumFromItemd(finance_db,"60",timea))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","长期待摊费用摊销")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">61</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemd.getYearSumFromItemd(finance_db,"61",timea))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","待摊费用减少（减：增加）")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">64</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemd.getYearSumFromItemd(finance_db,"64",timea))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","预提费用增加（减：减少）")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">65</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemd.getYearSumFromItemd(finance_db,"65",timea))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","处置固定资产、无形资产和其他长期资产的损失（减：收益）")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">66</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemd.getYearSumFromItemd(finance_db,"66",timea))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","固定资产报废损失")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">67</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemd.getYearSumFromItemd(finance_db,"67",timea))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","财务费用")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">68</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemd.getYearSumFromItemd(finance_db,"68",timea))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","投资损失（减：收益）")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">69</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemd.getYearSumFromItemd(finance_db,"69",timea))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","递延税款贷项（减：借项）")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">70</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemd.getYearSumFromItemd(finance_db,"70",timea))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","存货的减少（减：增加）")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">71</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemd.getYearSumFromItemd(finance_db,"71",timea))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","经营性应收项目的减少（减：增加）")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">72</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemd.getYearSumFromItemd(finance_db,"72",timea))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","经营性应付项目的增加（减：减少）")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">73</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemd.getYearSumFromItemd(finance_db,"73",timea))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","其他")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">74</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemd.getYearSumFromItemd(finance_db,"74",timea))%></td>
	<input name="item_year74" type="hidden" value="<%=getYearSumFromItemc.getYearSumFromItemc(finance_db,"74",timea)%>" >
</tr><tr <%=TR_STYLE1%> class="TR_STYLE1">
<%
double cash1balance1_sum=getYearProfitSumFromItemb.getYearProfitSumFromItemb(finance_db,"item_year30",account_period)+getYearSumFromItemd.getYearSumFromItemd(finance_db,"58◇59◇60◇61◇64◇65◇66◇67◇68◇69◇70◇71◇72◇73◇74",timea);
%>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","经营活动产生的现金流量净额")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">75</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(cash1balance1_sum)%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","2.不涉及现金收支的投资和筹资活动：")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;<%=demo.getLang("erp","债务转为资本")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">76</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemd.getYearSumFromItemd(finance_db,"76",timea))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;<%=demo.getLang("erp","一年内到期的可转换公司债券")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">77</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemd.getYearSumFromItemd(finance_db,"77",timea))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;<%=demo.getLang("erp","融资租入固定资产")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">78</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemd.getYearSumFromItemd(finance_db,"78",timea))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","3.现金及现金等价物净增加情况：")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;<%=demo.getLang("erp","现金的期末余额")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">79</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromAccount.getYearSumFromAccountCurrent(finance_db,account_period))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;<%=demo.getLang("erp","减：现金的期初余额")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">80</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromAccount.getYearSumFromAccountLast(finance_db,account_period))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;<%=demo.getLang("erp","加：现金等价物的期末余额")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">81</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;<%=demo.getLang("erp","减：现金等价物的期初余额")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">82</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
</tr>
<%
double cash1balance2_sum=getYearSumFromAccount.getYearSumFromAccountCurrent(finance_db,account_period)-getYearSumFromAccount.getYearSumFromAccountLast(finance_db,account_period);	
%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;<%=demo.getLang("erp","现金及现金等价物净增加额")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">83</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(cash1balance2_sum)%></td>
</tr>
</table>
<%@include file="../include/paper_bottom.html"%>
</form>
</div>
<%}else{%>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table> 
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="tablec_locate.jsp"></div></td>
 </tr>
</table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","对不起，你输入的时间格式错误，请返回！")%></td>
 </table>
</div>

<%
	}
finance_db.close();
}catch(Exception ex){
	ex.printStackTrace();
}
%>