<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="include.excel_export.Solid" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,java.text.*"%>
<jsp:useBean id="query" scope="page" class="include.query.query_three"/>
<%@ taglib uri="/WEB-INF/mytag.tld" prefix="page"%>
<jsp:useBean id="validata" scope ="page" class ="validata.ValidataNumber"/>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>

<%nseer_db finance_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
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
String table_width="1025";
try{
String tableselect=exchange.unURL(request.getParameter("tableselect"));
String year=request.getParameter("year");
String month=request.getParameter("month");
String sql="select * from finance_report_01 where month='"+month+"' and year='"+year+"'";
ResultSet rs=finance_db.executeQuery(sql);
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
 <td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","打印")%>" onClick="javascript:winopen('query_report_one_print.jsp?ID=<%=rs.getString("ID")%>')">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="query_locate.jsp"></div></td>
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
 <td <%=TD_STYLE3%> class="TD_STYLE3"><span id="company"><%=demo.getLang("erp","编制单位：")%><%=exchange.toHtml(rs.getString("report_unit"))%></span></td>

 <td <%=TD_STYLE3%> class="TD_STYLE3"><span id="time"><%=demo.getLang("erp","时间：")%><%=rs.getString("year")%><%=demo.getLang("erp","年")%> <%=rs.getString("month")%><%=demo.getLang("erp","月")%></span></td>

 <td <%=TD_STYLE3%> class="TD_STYLE3"><span id="money"><%=demo.getLang("erp","单位：元")%></span></td> 

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
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","流动资产：")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","流动负债：")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","货币资金")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">1</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year1"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month1"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","短期借款")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">68</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year68"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month68"))%></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","短期投资")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">2</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year2"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month2"))%></td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","应付票据")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">69</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year69"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month69"))%></td>	
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","应收票据")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">3</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year3"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month3"))%></td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","应付账款")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">70</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year70"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month70"))%></td>	
	</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","应收股息")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">4</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year4"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month4"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","应付工资")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">72</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year72"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month72"))%></td>	
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","应收账款")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">6</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year6"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month6"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","应付福利费")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">73</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year73"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month73"))%></td>
</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","其他应收款")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">7</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year7"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month7"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","应付利润")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">74</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year74"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month74"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","存货")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">10</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year10"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month10"))%></td>

	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","应缴税金")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">76</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year76"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month76"))%></td>
	
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","待摊费用")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">11</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year11"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month11"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","其他应交款")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">80</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year80"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month80"))%></td>
</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","一年内到期的长期债权投资")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">21</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year21"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month21"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","其他应付款")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">81</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year81"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month81"))%></td>
</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","其他流动资产")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">24</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year24"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month24"))%></td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","预提费用")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">82</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year82"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month82"))%></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","流动资产合计")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">31</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year31"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month31"))%>
	</td>
	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","一年内到期的长期负债")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">86</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year86"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month86"))%></td>
	</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","长期投资：")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","其他流动负债")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">90</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year90"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month90"))%></td>
	
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","长期股权投资")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">32</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year32"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month32"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","流动负债合计")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">100</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year100"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month100"))%></td>
</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","长期债权投资")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">34</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year34"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month34"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","长期负债：")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","长期投资合计")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">38</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year38"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month38"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","长期借款")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">101</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year101"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month101"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","固定资产：")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","长期应付款")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">103</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year103"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month103"))%></td>
</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","固定资产原价")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">39</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year39"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month39"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","其他长期负债")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">106</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year106"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month106"))%></td>
</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","减：累计折旧")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">40</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year40"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month40"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">108</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year108"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month108"))%></td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","固定资产净值")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">41</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year41"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month41"))%></td>
	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","长期负债合计")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">110</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year110"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month110"))%></td>
</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","工程物资")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">44</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year44"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month44"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","在建工程")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">45</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year45"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month45"))%></td>
		
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","负债合计")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">114</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year114"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month114"))%></td>
</tr>
	<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","固定资产清理")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">46</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year46"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month46"))%></td>
	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","所有者权益（或股东权益）：")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","固定资产合计")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">50</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year50"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month50"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","实收资本")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">115</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year115"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month115"))%></td>
	</tr>


<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","无形资产及其他资产：")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">&nbsp;</td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","资本公积")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">120</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year120"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month120"))%></td>
	
</tr>
    <tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","无形资产")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">51</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year51"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month51"))%></td>
	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","盈余公积")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">121</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year121"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month121"))%></td>
	
</tr>
    <tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","长期待摊费用")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">52</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year52"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month52"))%></td>
	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","其中：法定公益金")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">122</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year122"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month122"))%></td>
	
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","其他长期资产")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">53</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year53"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month53"))%></td>
	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","未分配利润")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">123</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year123"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month123"))%></td>
	
</tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","无形资产及其他资产合计")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">60</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year60"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month60"))%></td>
	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","所有者权益（或股东权益）合计")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">124</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year124"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month124"))%></td>
</tr>
	

<tr <%=TR_STYLE1%> class="TR_STYLE1">
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","资产合计")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">67</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year67"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month67"))%></td>
	
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=demo.getLang("erp","负债和所有者权益（或股东权益）总计")%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2">135</td>
    <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_year135"))%></td>
	<td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("item_month135"))%></td>
	
</tr>
</table>
<%@include file="../include/paper_bottom.html"%>
</div>
 <%
 finance_db.close();
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
<td <%=TD_STYLE3%> class="TD_STYLE3"><div <%=DIV_STYLE1%> class="DIV_STYLE1"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick=location="query_locate.jsp"></div></td>
 </tr>
 </table>
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
<td <%=TD_STYLE3%> class="TD_STYLE3"><%=demo.getLang("erp","该报表未生成，请返回！")%></td>
 </tr>
 </table>
 </div>
 <%
 }
 }catch(Exception ex){
 	ex.printStackTrace();
 }%>