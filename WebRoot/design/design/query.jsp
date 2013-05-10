<!--
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 -->
<%@page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*,include.nseer_cookie.*" import="java.util.*" import="java.io.*" import ="include.nseer_db.*,include.nseerdb.*,java.text.*"%>
<%nseer_db design_db = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%nseer_db designdb = new nseer_db((String)session.getAttribute("unit_db_name"));%>
<%@include file="../include/head.jsp"%>
<jsp:useBean id="demo" class="include.tree_index.businessComment" scope="page"/>
<% DealWithString DealWithString=new DealWithString(application);
String mod=request.getRequestURI();
	 demo.setPath(request);
	 String handbook=demo.businessComment(mod,"您正在做的业务是：","document_main","reason","value");%>
<script language="javascript" src="../../javascript/winopen/winopen.js"></script>
<link rel="stylesheet" type="text/css" href="../../javascript/ajax/NeatDialogs.css" media="screen" />
<script type="text/javascript" src="../../javascript/ajax/NeatDialogs.js"></script>
<script type="text/javascript">
function openDialog()
{var sHTML =  document.getElementById("open").innerHTML;
new NeatDialog(sHTML, "川大科技", false);
}

</script>
<div id=open style="display:none"><p></p><p><A HREF="register_down_excel.jsp"><font color=#6600FF><img src="../../images/down.jpg" width=20 height=20 style="border:   0;"><%=demo.getLang("erp","点击下载")%></font></A></p><p></p><p><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="关闭" onclick="window.neatDialog.close()"></p></div>
<script>
function transfer_data(url){
var all_column='';
var data_span=document.getElementById('table_data');
var table_tr=data_span.getElementsByTagName('tr');
for(var i=1;i<table_tr.length;i++){
all_column=all_column+"■";
for(var j=1;j<table_tr[i].getElementsByTagName('td').length;j++){
if(table_tr[i].getElementsByTagName('td')[j].innerHTML=='&nbsp;'){
all_column=all_column+'⊙'+"<$$>";
}else{if(j==1){
all_column=all_column+table_tr[i].getElementsByTagName('td')[j].innerHTML.substring(table_tr[i].getElementsByTagName('td')[j].innerHTML.indexOf('>')+1,table_tr[i].getElementsByTagName('td')[j].innerHTML.lastIndexOf('<'))+"<$$>";
}else{
all_column=all_column+table_tr[i].getElementsByTagName('td')[j].innerHTML+"<$$>";}
}}
all_column=all_column.substring(0,all_column.length-4);
}
all_column=all_column.substring(1,all_column.length);
all_column=all_column.replace(/&nbsp;/g,"");
all_column=all_column.replace(/<br>/g,"");
all_column=all_column.replace(/<BR>/g,"");
var product_name=document.getElementById('product_name').innerHTML;
var product_ID=document.getElementById('product_ID').innerHTML;
var cost_price_sum=document.getElementById('cost_price_sum').innerHTML;
var designer=document.getElementById('designer').innerHTML;
var checker=document.getElementById('checker').innerHTML;
var check_time=document.getElementById('check_time').innerHTML;
var register_time=document.getElementById('register_time').innerHTML;
var module_describe=document.getElementById('module_describe').innerHTML;
var xmlhttp3;
if (window.XMLHttpRequest){xmlhttp3=new XMLHttpRequest();}else if (window.ActiveXObject){
xmlhttp3=new ActiveXObject("Microsoft.XMLHTTP");}if(xmlhttp3) {xmlhttp3.onreadystatechange = function() {
if (xmlhttp3.readyState==4){try {if(xmlhttp3.status==200) {
openDialog();
}else {
alert( xmlhttp3.status + '=' + xmlhttp3.statusText);}} catch(exception) {alert(exception);}}};
xmlhttp3.open("POST", url, true);
xmlhttp3.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");	xmlhttp3.send('product_name='+product_name+'&&product_ID='+product_ID+'&&cost_price_sum='+cost_price_sum+'&&designer='+designer+'&&checker='+checker+'&&check_time='+check_time+'&&register_time='+register_time+'&&module_describe='+module_describe+'&&all_column='+all_column);				
} else {alert('Can not create XMLHttpRequest object, please check your web browser.');}
}
</script>
<%
String design_ID=request.getParameter("design_ID") ;
try{
String sql="select * from design_module where design_ID='"+design_ID+"'";
ResultSet rs=designdb.executeQuery(sql);
if(rs.next()){
String check_tag="";
String design_module_tag="等待";
String color="#FF9A31";
String color1="#FF9A31";
if(rs.getString("check_tag").equals("0")){
check_tag="等待";
}else if(rs.getString("check_tag").equals("1")){
check_tag="通过";
color1="mediumseagreen";
}else if(rs.getString("check_tag").equals("9")){
check_tag="未通过";
color1="red";
}
if((rs.getString("check_tag").equals("0")&&rs.getString("change_tag").equals("0"))||rs.getString("check_tag").equals("9")){
design_module_tag="等待";
}else if(rs.getString("check_tag").equals("0")&&rs.getString("change_tag").equals("1")){
design_module_tag="执行";
color="mediumseagreen";
}else if(rs.getString("check_tag").equals("1")&&rs.getString("change_tag").equals("0")){
design_module_tag="完成";
color="3333FF";
}
String check_time=rs.getString("check_time").equals("1800-01-01 00:00:00.0")?"":rs.getString("check_time");
%>
<table <%=TABLE_STYLE3%> class="TABLE_STYLE3">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_HANDBOOK_STYLE1%> class="TD_HANDBOOK_STYLE1"><div class="div_handbook"><%=handbook%></div></td>
 </tr>
</table>
<div id="nseerGround" class="nseerGround">
<table <%=TABLE_STYLE2%> class="TABLE_STYLE2">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8"><input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","打印")%>" onClick="javascript:winopen('query_print.jsp?design_ID=<%=design_ID%>')">&nbsp;<input type="button" <%=BUTTON_STYLE1%> class="BUTTON_STYLE1" value="<%=demo.getLang("erp","返回")%>" onClick="history.back()"></td>
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
 <td <%=TD_STYLE5%> class="TD_STYLE5"><font size="4"><b><%=demo.getLang("erp","物料组成设计单")%></b></font></td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","产品名称")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><span id="product_name"><%=exchange.toHtml(rs.getString("product_name"))%></span>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","产品编号")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><span id="product_ID"><%=rs.getString("product_ID")%></span>&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<TABLE <%=TABLE_STYLE5%> class="TABLE_STYLE5" id="table_data">
 <tr <%=TR_STYLE2%> class="TR_STYLE2">
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="5%"><%=demo.getLang("erp","序号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","物料编号")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","物料名称")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","用途类型")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","描述")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="8%"><%=demo.getLang("erp","数量")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="5%"><%=demo.getLang("erp","单位")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="11%"><%=demo.getLang("erp","单价（元）")%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="13%"><%=demo.getLang("erp","小计（元）")%></td>
 </tr>
<%
int i=1;
String sql6="select * from design_module_details where design_ID='"+design_ID+"' order by details_number";
ResultSet rs6=design_db.executeQuery(sql6);
while(rs6.next()){
%>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=i%></td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><a href="query_product.jsp?product_ID=<%=rs6.getString("product_ID")%>"><%=rs6.getString("product_ID")%></a>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("product_name"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("type"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=rs6.getString("product_describe")%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerAmountPrecision")).format(rs6.getDouble("amount"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=exchange.toHtml(rs6.getString("amount_unit"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("cost_price"))%>&nbsp;</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs6.getDouble("subtotal"))%>&nbsp;</td>
 </tr>
<%
	i++;
	}
%>
</table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE5%> class="TD_STYLE5">&nbsp;</td>
 </tr>
 </table>
<table <%=TABLE_STYLE4%> class="TABLE_STYLE4">
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","物料总成本")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3" width="89%"><span id="cost_price_sum"><%=new java.text.DecimalFormat((String)application.getAttribute("nseerPrecision")).format(rs.getDouble("cost_price_sum"))%></span>&nbsp;</td>
 </tr>
<tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","设计人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><span id="designer"><%=exchange.toHtml(rs.getString("designer"))%></span>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","审核人")%>&nbsp;&nbsp;：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><span id="checker"><%=exchange.toHtml(rs.getString("checker"))%></span>&nbsp;</td>
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","审核时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><span id="check_time"><%=check_time%></span>&nbsp;</td>
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","登记时间")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" width="40%"><span id="register_time"><%=exchange.toHtml(rs.getString("register_time"))%></span>&nbsp;</td> 
 </tr>
 <tr <%=TR_STYLE1%> class="TR_STYLE1">
 <td <%=TD_STYLE1%> class="TD_STYLE8" width="10%"><%=demo.getLang("erp","设计要求")%>：</td>
 <td <%=TD_STYLE2%> class="TD_STYLE2" colspan="3" width="89%"><span id="module_describe"><%=rs.getString("module_describe")%></span>&nbsp;</td>
 </tr>
</table>
</div>
<%@include file="../include/paper_bottom.html"%>
<%
}
design_db.close();
designdb.close();
}
catch (Exception ex){
out.println("error"+ex);
}
%>