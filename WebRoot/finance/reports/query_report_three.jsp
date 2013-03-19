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
<%nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
 <jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<script language="javascript" src="../../javascript/winopen/winopenm.js"></script>
<script type="text/javascript">
function openDialog1()
{var sHTML =  document.getElementById("open1").innerHTML;
new NeatDialog(sHTML, "恩信科技", false);
}
</script>
<div id=open1 style="display:none"><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p><A HREF="query_report_one_down_excel.jsp"><font color=#6600FF><img src="../../images/down.jpg" width=20 height=20 style="border:   0;"><%=demo.getLang("erp","点击下载")%></font></A></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p></p><p><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="关闭" onclick="window.neatDialog.close()"></p></div>
<script>
function transfer_data(url){
var all_column='';
var data_span=document.getElementById('theObjTable');
var table_tr=data_span.getElementsByTagName('tr');
for(var i=1;i<table_tr.length;i++){
all_column=all_column+"■";
for(var j=0;j<table_tr[i].getElementsByTagName('td').length;j++){
if(table_tr[i].getElementsByTagName('td')[j].innerHTML=='&nbsp;'){
all_column=all_column+'⊙'+"<$$>";
}else{
all_column=all_column+table_tr[i].getElementsByTagName('td')[j].innerHTML+"<$$>";
}
}
all_column=all_column.substring(0,all_column.length-4);
}
all_column=all_column.substring(1,all_column.length);
all_column=all_column.replace(/&nbsp;/g,"");
all_column=all_column.replace(/<br>/g,"");
all_column=all_column.replace(/<BR>/g,"");
var company=document.getElementById('company').innerHTML;
var time=document.getElementById('time').innerHTML;
var money=document.getElementById('money').innerHTML;
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
openDialog1();
}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", url, true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");	xmlhttp3.send('company='+company+'&&time='+time+'&&money='+money+'&&all_column='+all_column);				
} else {alert('Can not create XMLHttpRequest object, please check your web browser.');}
}
</script>
<%
String tableselect=exchange.unURL(request.getParameter("tableselect"));
String year=request.getParameter("year");
String month=request.getParameter("month");
String sql="select * from finance_report_03 where month='"+month+"' and year='"+year+"'";
ResultSet rs=finance_db.executeQuery(sql);
if(rs.next()){
%>
<table <%=TABLE_STYLE6%> class="TABLE_STYLE6">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1"  id="show-dialog-btn" onfocus="close_div()" value="<%=demo.getLang("erp","PDF打印")%>">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","打印")%>" onClick="javascript:winopen('query_report_three_print.jsp?ID=<%=rs.getString("ID")%>')">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="query_locate.jsp"></div>
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
 <td align="center"><font size="4"><b><%=demo.getLang("erp","现金流量表")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><span id="company"><%=demo.getLang("erp","编制单位：")%><%=exchange.toHtml(rs.getString("report_unit"))%></span></td>
 
 <td <%=TD_STYLE3%> class="TD_STYLE3"><span id="time"><%=demo.getLang("erp","时间：")%><%=rs.getString("year")%><%=demo.getLang("erp","年")%> <%=rs.getString("month")%><%=demo.getLang("erp","月")%></span></td>
 
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
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year1"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","收到的其他与经营活动有关的现金")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">8</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year8"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","现金流入小计")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">9</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year9"))%></td>
</tr>
   <tr <%=TR_STYLE1%> class="TR_STYLE1">
	
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","购买商品、接受劳务支付的现金")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">10</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year10"))%></td>
	
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","支付给职工以及为职工支付的现金")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">12</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year12"))%></td>
	</tr>
   <tr <%=TR_STYLE1%> class="TR_STYLE1">
	
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","支付的各项税费")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">13</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year13"))%></td>
	
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","支付的其他与经营活动有关的现金")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">18</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year18"))%></td>
	</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","现金流出小计")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">20</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year20"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","经营活动产生的现金流量净额")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">21</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year21"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","二、投资活动产生的现金流量：")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","收回投资所收到的现金")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">22</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year22"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","取得投资收益所收到的现金")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">23</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year23"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","处置固定资产、无形资产和其他长期资产所收回的现金净额")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">25</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year25"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","收到的其他与投资活动有关的现金")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">28</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year28"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">	
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","现金流入小计")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">29</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year29"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">	
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","购建固定资产、无形资产和其他长期资产所支付的现金")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">30</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year30"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">	
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","投资所支付的现金")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">31</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year31"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","支付的其他与投资活动有关的现金")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">35</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year35"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","现金流出小计")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">36</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year36"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","投资活动产生的现金流量净额")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">37</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year37"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","三、筹资活动产生的现金流量：")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","吸收投资所收到的现金")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">38</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year38"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","借款所收到的现金")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">40</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year40"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","收到的其他与筹资活动有关的现金")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">43</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year43"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","现金流入小计")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">44</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year44"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","偿还债务所支付的现金")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">45</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year45"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","分配股利、利润或偿付利息所支付的现金")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">46</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year46"))%></td>	
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","支付的其他与筹资活动有关的现金")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">52</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year52"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","现金流出小计")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">53</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year53"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","筹资活动产生的现金流量净额")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">54</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year54"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","四、汇率变动对现金的影响")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">55</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year55"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","五、现金及现金等价物净增加额")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">56</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year56"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3">&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","补充资料")%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","行次")%></td>
<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","本年数")%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","1.将净利润调节为经营活动现金流量：")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;<%=demo.getLang("erp","净利润")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">57</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year57"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;<%=demo.getLang("erp","加：计提的资产减值准备")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">58</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year58"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","固定资产折旧")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">59</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year59"))%></td>	
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","无形资产摊销")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">60</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year60"))%></td>
</tr><tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","长期待摊费用摊销")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">61</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year61"))%></td>
</tr><tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","待摊费用减少（减：增加）")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">64</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year64"))%></td>
	</tr><tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","预提费用增加（减：减少）")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">65</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year65"))%></td>
</tr><tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","处置固定资产、无形资产和其他长期资产的损失（减：收益）")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">66</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year66"))%></td>
	
</tr><tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","固定资产报废损失")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">67</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year67"))%></td>
	
</tr><tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","财务费用")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">68</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year68"))%></td>
	
</tr><tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","投资损失（减：收益）")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">69</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year69"))%></td>
	
</tr><tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","递延税款贷项（减：借项）")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">70</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year70"))%></td>
	
</tr><tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","存货的减少（减：增加）")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">71</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year71"))%></td>
	
</tr><tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","经营性应收项目的减少（减：增加）")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">72</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year72"))%></td>
	
</tr><tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","经营性应付项目的增加（减：减少）")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">73</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year73"))%></td>
</tr><tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","其他")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">74</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year74"))%></td>
</tr><tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;&nbsp;&nbsp;<%=demo.getLang("erp","经营活动产生的现金流量净额")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">75</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year75"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","2.不涉及现金收支的投资和筹资活动：")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;<%=demo.getLang("erp","债务转为资本")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">76</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year76"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;<%=demo.getLang("erp","一年内到期的可转换公司债券")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">77</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year77"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;<%=demo.getLang("erp","融资租入固定资产")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">78</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year78"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","3.现金及现金等价物净增加情况：")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;<%=demo.getLang("erp","现金的期末余额")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">79</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year79"))%></td>	
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;<%=demo.getLang("erp","减：现金的期初余额")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">80</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year80"))%></td>
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
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;&nbsp;<%=demo.getLang("erp","现金及现金等价物净增加额")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">83</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year83"))%></td>
</tr>
</table>
<%@include file="../include/paper_bottom.html"%>
<% 
 finance_db.close();
 }else{
 %>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","该报表未生成，请返回！")%></td>
 <td <%=TD_STYLE3%> class="TD_STYLE3">
 <div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="query_locate.jsp"></div>
 </td>
 </tr>
</table>
 </div>
 <%
 }%>