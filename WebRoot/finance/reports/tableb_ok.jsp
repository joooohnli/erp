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
<jsp:useBean id="getMonthSumFromItemb" scope="page" class="finance.getMonthSumFromItemb"/>
<jsp:useBean id="getYearSumFromItemb" scope="page" class="finance.getYearSumFromItemb"/>
<%nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<%@include file="../include/head.jsp"%>
 <jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<%
String table_width="820";
String account_period=request.getParameter("account_period");
String report_unit=request.getParameter("report_unit");
String end_time="";
String sql="select end_time from finance_account_period where account_period='"+account_period+"'";
ResultSet rs=finance_db.executeQuery(sql);
if(rs.next()){
	end_time=rs.getString("end_time");
}
%>
<body onload="profit()">
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 </table>
<div id="nseerGround" class="nseerGround">
 <form id="mutiValidation" method="POST" action="../../finance_reports_tableb_save" onSubmit="return doValidate('mutiValidation')">
 <table <%=TABLE_STYLE8%> class="TABLE_STYLE8">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="tableb_locate.jsp"></div></td>
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
 <td <%=TD_STYLE2%> class="TD_STYLE2"><span id="company"><%=demo.getLang("erp","编制单位：")%><%=exchange.toHtml(report_unit)%></span></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><span id="time"><%=demo.getLang("erp","时间：")%><%=end_time%></span></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><span id="money"><%=demo.getLang("erp","单位：元")%></span></td> 
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
<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getMonthSumFromItemb.getMonthSumFromItemb(finance_db,"1",account_period))%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemb.getYearSumFromItemb(finance_db,"1",account_period))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","减：主营业务成本")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">4</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getMonthSumFromItemb.getMonthSumFromItemb(finance_db,"4",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemb.getYearSumFromItemb(finance_db,"4",account_period))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">	
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","主营业务税金及附加")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">5</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getMonthSumFromItemb.getMonthSumFromItemb(finance_db,"5",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemb.getYearSumFromItemb(finance_db,"5",account_period))%></td>
</tr>

<%
double major_profit_year_sum=getYearSumFromItemb.getYearSumFromItemb(finance_db,"1",account_period)-getYearSumFromItemb.getYearSumFromItemb(finance_db,"4",account_period)-getYearSumFromItemb.getYearSumFromItemb(finance_db,"5",account_period);
double major_profit_month_sum=getMonthSumFromItemb.getMonthSumFromItemb(finance_db,"1",account_period)-getMonthSumFromItemb.getMonthSumFromItemb(finance_db,"4",account_period)-getMonthSumFromItemb.getMonthSumFromItemb(finance_db,"5",account_period);
%>	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","二、主营业务利润(亏损以“-”号填列)")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">10</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(major_profit_month_sum)%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(major_profit_year_sum)%></td>
</tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","加：其他业务利润(亏损以“-”号填列)")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">11</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getMonthSumFromItemb.getMonthSumFromItemb(finance_db,"11",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemb.getYearSumFromItemb(finance_db,"11",account_period))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","减：营业费用")%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2">14</td>
<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getMonthSumFromItemb.getMonthSumFromItemb(finance_db,"14",account_period))%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemb.getYearSumFromItemb(finance_db,"14",account_period))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","管理费用")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">15</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getMonthSumFromItemb.getMonthSumFromItemb(finance_db,"15",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemb.getYearSumFromItemb(finance_db,"15",account_period))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","财务费用")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">16</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getMonthSumFromItemb.getMonthSumFromItemb(finance_db,"16",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemb.getYearSumFromItemb(finance_db,"16",account_period))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<%
double business_profit_year_sum=major_profit_year_sum+getYearSumFromItemb.getYearSumFromItemb(finance_db,"11",account_period)-getYearSumFromItemb.getYearSumFromItemb(finance_db,"14",account_period)-getYearSumFromItemb.getYearSumFromItemb(finance_db,"15",account_period)-getYearSumFromItemb.getYearSumFromItemb(finance_db,"16",account_period);
double business_profit_month_sum=major_profit_month_sum+getMonthSumFromItemb.getMonthSumFromItemb(finance_db,"11",account_period)-getMonthSumFromItemb.getMonthSumFromItemb(finance_db,"14",account_period)-getMonthSumFromItemb.getMonthSumFromItemb(finance_db,"15",account_period)-getMonthSumFromItemb.getMonthSumFromItemb(finance_db,"16",account_period);
%>	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","三、营业利润(亏损以“-”号填列)")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">18</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(business_profit_month_sum)%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(business_profit_year_sum)%></td>

	<input name="item_month18" type="hidden" value="<%=business_profit_month_sum%>" style="width:100%">
	<input name="item_year18" type="hidden" value="<%=business_profit_year_sum%>" style="width:100%">
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","加：投资收益(损失以“-”号填列)")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">19</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getMonthSumFromItemb.getMonthSumFromItemb(finance_db,"19",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemb.getYearSumFromItemb(finance_db,"19",account_period))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">	
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","营业外收入")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">23</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getMonthSumFromItemb.getMonthSumFromItemb(finance_db,"23",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemb.getYearSumFromItemb(finance_db,"23",account_period))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","减：营业外支出")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">25</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getMonthSumFromItemb.getMonthSumFromItemb(finance_db,"25",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemb.getYearSumFromItemb(finance_db,"25",account_period))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<%
double profit_year_sum=business_profit_year_sum+getYearSumFromItemb.getYearSumFromItemb(finance_db,"19",account_period)+getYearSumFromItemb.getYearSumFromItemb(finance_db,"23",account_period)-getYearSumFromItemb.getYearSumFromItemb(finance_db,"25",account_period);
double profit_month_sum=business_profit_month_sum+getMonthSumFromItemb.getMonthSumFromItemb(finance_db,"19",account_period)+getMonthSumFromItemb.getMonthSumFromItemb(finance_db,"23",account_period)-getMonthSumFromItemb.getMonthSumFromItemb(finance_db,"25",account_period);
%>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","四、利润总额(亏损总额以“-”号填列)")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">27</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(profit_month_sum)%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(profit_year_sum)%></td>
</tr>
	<input name="item_month27" type="hidden" value="<%=profit_month_sum%>" style="width:100%">
	<input name="item_year27" type="hidden" value="<%=profit_year_sum%>" style="width:100%">
    <tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","减：所得税")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">28</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getMonthSumFromItemb.getMonthSumFromItemb(finance_db,"28",account_period))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(getYearSumFromItemb.getYearSumFromItemb(finance_db,"28",account_period))%></td>
</tr>
<%
double real_profit_year_sum=profit_year_sum-getYearSumFromItemb.getYearSumFromItemb(finance_db,"28",account_period);
double real_profit_month_sum=profit_month_sum-getMonthSumFromItemb.getMonthSumFromItemb(finance_db,"28",account_period);
%>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","五、净利润(净亏损以“-”号填列)")%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2">30</td>
<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(real_profit_month_sum)%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(real_profit_year_sum)%></td>
</tr>
</table>
<input type="hidden" id="report_unit" value="<%=report_unit%>">
<input type="hidden" id="profit" value="<%=new java.text.DecimalFormat("#####0.00").format(real_profit_year_sum)%>">
<input type="hidden" id="account_period" value="<%=account_period%>">

<%@include file="../include/paper_bottom.html"%>
</form>
</div>
</body>
<%
finance_db.close();
%>
<script>
function profit(){
var report_unit=document.getElementById('report_unit').value;
var profit=document.getElementById('profit').value;
var account_period=document.getElementById('account_period').value;

var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", "../../finance_reports_tableb_save", true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xmlhttp3.send('report_unit='+encodeURI(report_unit)+'&profit='+profit+'&account_period='+account_period);
}
}
</script>